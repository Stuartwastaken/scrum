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
      body: FutureBuilder<List<DocumentSnapshot<Map<String, dynamic>>>>(
        future: _getDataFuture,
        builder: (BuildContext context,
            AsyncSnapshot<List<DocumentSnapshot<Map<String, dynamic>>>>
                snapshot) {
          if (snapshot.hasData) {
            List<DocumentSnapshot<Map<String, dynamic>>> documentList =
                snapshot.data!;
            return ListView.builder(
              itemCount: documentList.length > 0 ? documentList.length : 1,
              itemBuilder: (BuildContext context, int index) {
                //body if user has no quizzes
                if (documentList.length == 0) {
                  print("no entries");
                  return Text("You dont have any quizzes");
                  //body if user has one or more quizzes
                } else {
                  //Each "Quiz"
                  return ListTile(
                    title: Text(documentList[index].data()?['Title'] ?? ''),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                            onPressed: () {},
                            icon: Icon(IconData(0xf00a0,
                                fontFamily: 'MaterialIcons'))),
                        IconButton(onPressed: () {}, icon: Icon(Icons.edit)),
                        IconButton(onPressed: () {}, icon: Icon(Icons.delete)),
                      ],
                    ),
                  );
                }
              },
            );
          } else if (snapshot.hasError) {
            return Center(
                child: Stack(
              alignment: Alignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Nothing to see yet.',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w600,
                        color: Colors.deepPurple,
                      ),
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            PageRouteBuilder(
                              transitionDuration: Duration
                                  .zero, // Set transition duration to zero to remove animation
                              pageBuilder:
                                  (context, animation, secondaryAnimation) =>
                                      MakeQuizScreen(user: widget.user),
                            ),
                          );
                        },
                        child: Text(
                          "Click here to make some quizzes!",
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w600,
                            color: Colors.deepPurple,
                          ),
                        ))
                  ],
                )
              ],
            ));
          } else {
            return CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
