import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'edit-profile-screen.dart';

class ViewProfileScreen extends StatefulWidget {
  final User user;
  const ViewProfileScreen({required this.user});

  @override
  _ViewProfileScreenState createState() => _ViewProfileScreenState();
}

class _ViewProfileScreenState extends State<ViewProfileScreen> {
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
        title: TextButton(
          child: Text(
            'SCRUM',
            style: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.w700,
              color: Colors.deepOrange,
            ),
          ),
          onPressed: () {},
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.deepOrange,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () async {
            final User updatedUser = await FirebaseAuth.instance.currentUser!;
            Navigator.pop(context, updatedUser);
          },
        ),
      ),
      body: Container(
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
          child: Stack(
            children: [
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Profile Information",
                      style: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 40,
                          color: Colors.white),
                    ),
                    SizedBox(height: 4),
                    Container(
                      width: 400,
                      height: 175,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        border: Border.all(
                          color: Colors
                              .white, // Set the color of the outline to white
                          width: 2, // Set the width of the outline to 2 pixels
                        ),
                        borderRadius: BorderRadius.circular(
                            10), // Set the border radius to 10 pixels
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'Username: $_username',
                            style: TextStyle(
                              color:
                                  Colors.white, // Set the text color to white
                              fontSize: 20,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Email: $_email',
                            style: TextStyle(
                              color:
                                  Colors.white, // Set the text color to white
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 12),
                    OutlinedButton(
                      onPressed: () {
                        Navigator.of(context)
                            .push(
                          MaterialPageRoute(
                            builder: (context) =>
                                EditProfileScreen(user: _currentUser),
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
                      child: Text(
                        "Edit Profile",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Color.fromARGB(255, 255, 255, 255),
                        side: BorderSide(
                            width: 2.0,
                            color: Color.fromARGB(
                                255, 255, 255, 255)), // foreground color
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              7), // set the desired border radius here
                        ),
                        minimumSize: Size(100, 40),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )),
    );
  }
}
