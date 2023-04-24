import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:scrum/screens/host-lobby-screen.dart';
import 'package:scrum/screens/login-screen.dart';
import 'package:scrum/screens/make-quiz-screen.dart';
import 'package:scrum/screens/view-profile-screen.dart';
import 'package:scrum/utils/fire_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// Tracker for appbar drop-down elements
enum MenuItem {
  item1,
  item2,
}

class ProfilePage extends StatefulWidget {
  final User user;

  const ProfilePage({required this.user});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool _isSendingVerification = false;
  bool _isSigningOut = false;

  late User _currentUser;
  final db = FirebaseFirestore.instance;
  late Future<List<DocumentSnapshot<Map<String, dynamic>>>> _getDataFuture;
  late Future<List<DocumentSnapshot<Map<String, dynamic>>>> _quizDocs;
  late Future<List<dynamic>> _quizRefs;
  List<dynamic> _stringQuizRefs = [];

  @override
  void initState() {
    _currentUser = widget.user;
    _quizRefs = getQuizRefs();
    _quizDocs = getQuizDocsFromRefs(_quizRefs);
    super.initState();
  }

  //fetches all quiz references from "User" collecton & stores the documents within _quizRefs & _stringQuizRefs
  Future<List<dynamic>> getQuizRefs() async {
    final userDocRef = await db.collection("User").doc(_currentUser.uid).get();
    final userQuizRefs = userDocRef.data()?['Quizzes'] as List<dynamic>;
    List userQuizStringRefs = [];
    for (var ref in userQuizRefs) {
      ref = ref.path;
      userQuizStringRefs.add(ref);
      _stringQuizRefs.add(ref);
    }
    return userQuizStringRefs;
  }

  Future<void> deleteQuizFromUser(String documentID, int indexToRemove) async {
    final documentReference = db.collection('User').doc(documentID);
    final documentSnapshot = await documentReference.get();
    final data = documentSnapshot.data()!;
    final quizzes = List.from(data['Quizzes']);
    quizzes.removeAt(indexToRemove);
    await documentReference.update({'Quizzes': quizzes});
  }

  //Takes a List of String references & returns the DocumentSnapshot for each reference.
  Future<List<DocumentSnapshot<Map<String, dynamic>>>> getQuizDocsFromRefs(
      Future<List<dynamic>> refs) async {
    List<DocumentSnapshot<Map<String, dynamic>>> userQuizDocs = [];
    for (var ref in await refs) {
      final quizDoc = await db.doc(ref).get();
      userQuizDocs.add(quizDoc);
    }
    return userQuizDocs;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appbar
      appBar: AppBar(
        title: TextButton(
            onPressed: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => ProfilePage(user: _currentUser)));
            },
            child: const Text(
              "Home Screen",
              style: TextStyle(color: Colors.white),
            )),
        actions: [
          PopupMenuButton(
            onSelected: (value) {
              //view profile button
              if (value == MenuItem.item1) {
                print("View Profile");
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ViewProfileScreen(user: _currentUser),
                  ),
                ).then((updatedUser) {
                  setState(() {
                    _currentUser = updatedUser;
                  });
                });
              }
              //sign out button
              if (value == MenuItem.item2) {
                print("Sign Out");
                setState(() {
                  _isSigningOut = true;
                });
                FirebaseAuth.instance.signOut();
                setState(() {
                  _isSigningOut = false;
                });
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => LoginScreen(),
                  ),
                );
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                value: MenuItem.item1,
                child: Text("View Profile"),
              ),
              PopupMenuItem(
                value: MenuItem.item2,
                child: Text("Sign Out"),
              ),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => MakeQuizScreen(user: _currentUser),
                ),
              );
            },
            child: Text("Add Quiz"),
          ),
          Expanded(
            child: FutureBuilder<List<DocumentSnapshot<Map<String, dynamic>>>>(
              future: _quizDocs,
              builder: (BuildContext context,
                  AsyncSnapshot<List<DocumentSnapshot<Map<String, dynamic>>>>
                      snapshot) {
                if (snapshot.hasData) {
                  List<DocumentSnapshot<Map<String, dynamic>>> documentList =
                      snapshot.data!;
                  return ListView.builder(
                    itemCount:
                        documentList.length > 0 ? documentList.length : 1,
                    itemBuilder: (BuildContext context, int index) {
                      //body if user has no quizzes
                      if (documentList.length == 0) {
                        print("no entries");
                        return Text("You dont have any quizzes");
                        //body if user has one or more quizzes
                      } else {
                        //Each "Quiz"
                        return ListTile(
                          //quiz title
                          title:
                              Text(documentList[index].data()?['Title'] ?? ''),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              //play button
                              IconButton(
                                  onPressed: () {
                                    String doc =
                                        _stringQuizRefs[index].substring(5);
                                    Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                        builder: (context) => HostLobbyScreen(
                                          document: doc,
                                          user: _currentUser,
                                        ),
                                      ),
                                    );
                                  },
                                  icon: Icon(IconData(0xf00a0,
                                      fontFamily: 'MaterialIcons'))),
                              //delete button
                              IconButton(
                                  onPressed: () async {
                                    //delete from "User" Collection
                                    deleteQuizFromUser(_currentUser.uid, index);
                                    //delete from "Quiz" collection
                                    await db
                                        .doc(_stringQuizRefs[index])
                                        .delete();
                                    //reload page
                                    Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            ProfilePage(user: _currentUser),
                                      ),
                                    );
                                  },
                                  icon: Icon(Icons.delete)),
                            ],
                          ),
                        );
                      }
                    },
                  );
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  return CircularProgressIndicator();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
