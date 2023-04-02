import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:scrum/screens/login-screen.dart';
import 'package:scrum/utils/fire_auth.dart';

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

  @override
  void initState() {
    _currentUser = widget.user;
    super.initState();
  }

  final List<String> entries = <String>['1', '2', '3', '4'];
  //final List<String> entries = <String>[];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Center(
        child: ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: entries.length > 0 ? entries.length : 1,
            itemBuilder: (BuildContext context, int index) {
              //final List<String> entries = <String>[];
              if (entries.length == 0) {
                print("no entries");
                return Text("You don't have any quizzes");
              } else {
                return Container(
                  height: 50,
                  color: Colors.amber[600],
                  child: Row(
                    children: [
                      Text("Title ${entries[index]}"),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(
                          IconData(0xf67a, fontFamily: 'MaterialIcons'),
                          color: Colors.blue,
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(
                          IconData(0xf3e9, fontFamily: 'MaterialIcons'),
                          color: Colors.red,
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        child: const Text("Delete"),
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        child: const Text("Play"),
                      ),
                    ],
                  ),
                );
              }
            }),
      ),
    );
  }
}
