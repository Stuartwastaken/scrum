import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
<<<<<<< HEAD
<<<<<<< HEAD
import 'edit-profile-screen.dart';
=======
import 'package:firebase_core/firebase_core.dart';
>>>>>>> 9433ad4 (Preliminary screen for viewing profile)
=======
>>>>>>> b50c583 (Added edit-profile-screen)

class ViewProfileScreen extends StatefulWidget {
  final User user;
  const ViewProfileScreen({required this.user});

  @override
  _ViewProfileScreenState createState() => _ViewProfileScreenState();
}

class _ViewProfileScreenState extends State<ViewProfileScreen> {
<<<<<<< HEAD
<<<<<<< HEAD
=======
  final FirebaseAuth _auth = FirebaseAuth.instance;
>>>>>>> 9433ad4 (Preliminary screen for viewing profile)
=======
>>>>>>> cf023f3 (Removed unused variable)
  String? _username;
  String? _email;

  late User _currentUser;

  @override
  void initState() {
    _currentUser = widget.user;
    _username = _currentUser.displayName;
    _email = _currentUser.email;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
<<<<<<< HEAD
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () async {
            final User updatedUser = await FirebaseAuth.instance.currentUser!;
            Navigator.pop(context, updatedUser);
          },
        ),
=======
>>>>>>> 9433ad4 (Preliminary screen for viewing profile)
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Username: $_username',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 10),
            Text(
              'Email: $_email',
              style: TextStyle(fontSize: 20),
            ),
<<<<<<< HEAD
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context)
                    .push(
                  MaterialPageRoute(
                    builder: (context) => EditProfileScreen(user: _currentUser),
                  ),
                )
                    .then((updatedUser) {
                  setState(() {
                    _currentUser = updatedUser;
                    _username = _currentUser.displayName;
                    _email = _currentUser.email;
                  });
                });
              },
              child: Text('Edit Profile'),
            ),
=======
>>>>>>> 9433ad4 (Preliminary screen for viewing profile)
          ],
        ),
      ),
    );
  }
}
