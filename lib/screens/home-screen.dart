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
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 1,
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width,
          maxHeight: MediaQuery.of(context).size.height * 1,
        ),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: [0.0, 0.35, 1.0], // set stops for the gradient
            colors: [
              Color.fromARGB(255, 161, 15, 223),
              Color.fromARGB(255, 251, 153, 42),
              Color.fromARGB(255, 63, 3, 192), // add a third color
            ],
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Your Quizzes',
              style: TextStyle(
                fontFamily: 'Poppins',
                color: Colors.white,
                fontSize: 80,
              ),
            ),
            //futurebuildertime
            Expanded(
              child:
                  FutureBuilder<List<DocumentSnapshot<Map<String, dynamic>>>>(
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
                          return Container(
                            width: MediaQuery.of(context).size.width * 0.8,
                            height: MediaQuery.of(context).size.height * 0.4,
                            decoration: BoxDecoration(),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Text(
                                  'It looks very empty in here, go ahead and create a SCRUM Battle.',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 60,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 4.0, bottom: 12.0),
                                  child: OutlinedButton(
                                    onPressed: () {
                                      Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                          builder: (context) => MakeQuizScreen(
                                              user: _currentUser),
                                        ),
                                      );
                                    },
                                    child: Text(
                                      "Create Battle",
                                      style: TextStyle(
                                        letterSpacing: 1.1,
                                        fontSize: 20,
                                      ),
                                    ),
                                    style: OutlinedButton.styleFrom(
                                      foregroundColor: Colors.white,
                                      side: BorderSide(
                                          width: 2.0,
                                          color: Color.fromARGB(
                                              255, 255, 255, 255)),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0)),
                                      minimumSize: Size(330, 50),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                          //body if user has one or more quizzes
                        } else {
                          //Each "Quiz"
                          return Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              MouseRegion(
                                cursor: SystemMouseCursors.click,
                                child: GestureDetector(
                                  onTap: () {
                                    print("Quiz Selected");
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
                                  child: Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.3,
                                    height: MediaQuery.of(context).size.height *
                                        0.1,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(25),
                                      shape: BoxShape.rectangle,
                                      border: Border.all(
                                        color: Colors.white,
                                        width: 4,
                                      ),
                                    ),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Expanded(
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Expanded(
                                                child: Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(10, 0, 0, 0),
                                                  child: Text(
                                                    "${documentList[index].data()?['Title'] ?? ''}",
                                                    style: TextStyle(
                                                      fontFamily: 'Poppins',
                                                      color: Colors.white,
                                                      fontSize: 40,
                                                      fontWeight:
                                                          FontWeight.normal,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  showDialog(
                                                    context: context,
                                                    builder:
                                                        (BuildContext context) {
                                                      return AlertDialog(
                                                        title: Text(
                                                            "Are you sure you would like to delete quiz?"),
                                                        actions: [
                                                          TextButton(
                                                            child: Text("No"),
                                                            onPressed: () {
                                                              print(
                                                                  "pressed no");
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                            },
                                                          ),
                                                          TextButton(
                                                            child: Text("Yes"),
                                                            onPressed:
                                                                () async {
                                                              print(
                                                                  "pressed yes");
                                                              //delete from "User" Collection
                                                              deleteQuizFromUser(
                                                                  _currentUser
                                                                      .uid,
                                                                  index);
                                                              //delete from "Quiz" collection
                                                              await db
                                                                  .doc(_stringQuizRefs[
                                                                      index])
                                                                  .delete();
                                                              //reload page
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                              Navigator.of(
                                                                      context)
                                                                  .pushReplacement(
                                                                MaterialPageRoute(
                                                                  builder: (context) =>
                                                                      ProfilePage(
                                                                          user:
                                                                              _currentUser),
                                                                ),
                                                              );
                                                            },
                                                          ),
                                                        ],
                                                      );
                                                    },
                                                  );
                                                },
                                                child: Container(
                                                  width: 60,
                                                  height: 60,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30),
                                                    border: Border.all(
                                                      color: Colors.transparent,
                                                      width: 1,
                                                    ),
                                                  ),
                                                  child: Icon(
                                                    Icons.delete,
                                                    color: Color(0xFFFF0000),
                                                    size: 40,
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
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
      ),
    );
  }
}
