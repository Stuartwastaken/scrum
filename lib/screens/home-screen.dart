import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:scrum/screens/login-screen.dart';
import 'package:scrum/utils/fire_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
      body: FutureBuilder<List<DocumentSnapshot<Map<String, dynamic>>>>(
        future: _getDataFuture,
        builder: (BuildContext context,
            AsyncSnapshot<List<DocumentSnapshot<Map<String, dynamic>>>>
                snapshot) {
          if (snapshot.hasData) {
            // use the result of the getData() function
            List<DocumentSnapshot<Map<String, dynamic>>> documentList =
                snapshot.data!;
            // build the UI using documentList
            return ListView.builder(
              itemCount: documentList.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(documentList[index].data()?['Title'] ?? ''),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            return CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
