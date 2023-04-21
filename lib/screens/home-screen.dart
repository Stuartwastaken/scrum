import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:scrum/screens/login-screen.dart';
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
  late Future<List<DocumentSnapshot<Map<String, dynamic>>>> _getDataFuture;

  @override
  void initState() {
    _currentUser = widget.user;
    _getDataFuture = getData();
    super.initState();
  }

  //fetches user's firestore data & stores the documents within a list
  final db = FirebaseFirestore.instance;
  Future<List<DocumentSnapshot<Map<String, dynamic>>>> getData() async {
    final userDocRef = await db.collection("User").doc(_currentUser.uid).get();
    final userQuizRefs = userDocRef.data()?['Quizzes'] as List<dynamic>;
    List<DocumentSnapshot<Map<String, dynamic>>> documentList = [];
    for (var ref in userQuizRefs) {
      ref = ref.path;
      final quizDoc = await db.doc(ref).get();
      documentList.add(quizDoc);
    }
    return documentList;
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
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 6),
                        child: Text(
                          'SCRUM',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            color: Colors.white,
                            fontSize: 80,
                            letterSpacing: 1.5,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      InkWell(
                        splashColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () async {},
                        child: Icon(
                          Icons.person,
                          color: Colors.white,
                          size: 80,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

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
                future: _getDataFuture,
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
                                    onPressed: () async {},
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
                          return ListTile(
                            title: Text(
                                documentList[index].data()?['Title'] ?? ''),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                    onPressed: () {},
                                    icon: Icon(IconData(0xf00a0,
                                        fontFamily: 'MaterialIcons'))),
                                IconButton(
                                    onPressed: () {}, icon: Icon(Icons.edit)),
                                IconButton(
                                    onPressed: () {}, icon: Icon(Icons.delete)),
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
      ),
    );
  }
}
