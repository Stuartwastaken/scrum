import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:scrum/screens/login-screen.dart';
import 'package:scrum/screens/make-quiz-screen.dart';
import 'package:scrum/screens/view-profile-screen.dart';
import 'package:scrum/utils/fire_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// Implementation to track which drop-down menu item is selected
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
  //late List<dynamic> d;
  late Future<List<DocumentSnapshot<Map<String, dynamic>>>> _getDataFuture;
  late Future<List<dynamic>> _quizRefs;
  late Future<List<DocumentSnapshot<Map<String, dynamic>>>> _quizDocs;
  //late List<dynamic> d;
  List<dynamic> d = [];

  @override
  void initState() {
    _currentUser = widget.user;
    _quizRefs = getQuizRefs();
    _quizDocs = getQuizDocsFromRefs(_quizRefs);
    //_getDataFuture = getData();
    super.initState();
  }

  //fetches user's firestore data & stores the documents within a list
  final db = FirebaseFirestore.instance;
  Future<List<dynamic>> getQuizRefs() async {
    final userDocRef = await db.collection("User").doc(_currentUser.uid).get();
    final userQuizRefs = userDocRef.data()?['Quizzes'] as List<dynamic>;
    List userQuizStringRefs = [];
    for (var ref in userQuizRefs) {
      ref = ref.path;
      userQuizStringRefs.add(ref);
      d.add(ref);
    }
    //print(userQuizStringRefs.runtimeType);
    return userQuizStringRefs;
  }

  Future<void> deleteQuizFromUser(String documentID, int indexToRemove) async {
    final documentReference =
        FirebaseFirestore.instance.collection('User').doc(documentID);
    final documentSnapshot = await documentReference.get();
    final data = documentSnapshot.data()!;
    final quizzes = List.from(data['Quizzes']);
    quizzes.removeAt(indexToRemove);
    await documentReference.update({'Quizzes': quizzes});
  }

  Future<List<DocumentSnapshot<Map<String, dynamic>>>> getQuizDocsFromRefs(
      Future<List<dynamic>> refs) async {
    List<DocumentSnapshot<Map<String, dynamic>>> userQuizDocs = [];
    for (var ref in await refs) {
      final quizDoc = await db.doc(ref).get();
      userQuizDocs.add(quizDoc);
    }
    //print(userQuizDocs.runtimeType);
    return userQuizDocs;
  }
  /*
  Future<List<DocumentSnapshot<Map<String, dynamic>>>> getData() async {
    final userDocRef = await db.collection("User").doc(_currentUser.uid).get();
    final userQuizRefs = userDocRef.data()?['Quizzes'] as List<dynamic>;
    List<DocumentSnapshot<Map<String, dynamic>>> documentList = [];
    for (var ref in userQuizRefs) {
      ref = ref.path;
      //quizRefs.add(ref);
      //print(ref);
      final quizDoc = await db.doc(ref).get();
      documentList.add(quizDoc);
    }
    //print(quizRefs);'
    print(documentList.runtimeType);
    print(documentList);
    return documentList;
  }
  */

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
                          title:
                              Text(documentList[index].data()?['Title'] ?? ''),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                  onPressed: () {
                                    print(d[index]);
                                    print("pressed play");
                                  },
                                  icon: Icon(IconData(0xf00a0,
                                      fontFamily: 'MaterialIcons'))),
                              IconButton(
                                  onPressed: () async {
                                    //delete from "User" Collection
                                    deleteQuizFromUser(_currentUser.uid, index);
                                    //delete from "Quiz" collection
                                    await db.doc(d[index]).delete();
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
