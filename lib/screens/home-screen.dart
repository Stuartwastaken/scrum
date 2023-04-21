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
            colors: [Color(0xFF4434CD), Color(0xFFE6963F), Color(0xFFB73AB7)],
            stops: [0, 0.9, 1],
            begin: AlignmentDirectional(0.64, 1),
            end: AlignmentDirectional(-0.64, -1),
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
                          size: 130,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 25, 0, 0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
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
                ],
              ),
            ),
            Container(
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
                      fontFamily: 'Poppins',
                      color: Colors.white,
                      fontSize: 60,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
