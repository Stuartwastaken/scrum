import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:scrum/screens/login-screen.dart';
import 'game-pin-screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:scrum/screens/home-screen.dart';
import 'package:scrum/utils/fire_auth.dart';
import 'package:scrum/utils/validator.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _registerFormKey = GlobalKey<FormState>();

  final _nameTextController = TextEditingController();
  final _emailTextController = TextEditingController();
  final _passwordTextController = TextEditingController();

  final _focusName = FocusNode();
  final _focusEmail = FocusNode();
  final _focusPassword = FocusNode();
  final User? user = FirebaseAuth.instance.currentUser;

  bool _isProcessing = false;

  @override
  void dispose() {
    _focusName.dispose();
    _focusEmail.dispose();
    _focusPassword.dispose();
    _nameTextController.dispose();
    _emailTextController.dispose();
    _passwordTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _focusName.unfocus();
        _focusEmail.unfocus();
        _focusPassword.unfocus();
      },
      child: Scaffold(
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
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(24, 10, 24, 0),
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      PageRouteBuilder(
                        transitionDuration: Duration
                            .zero, // Set transition duration to zero to remove animation
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            GamePinScreen(),
                      ),
                    );
                  },
                  child: Text(
                    "Back",
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
                    minimumSize: Size(90, 35),
                  ),
                ),
              ),
              //column 2
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 400,
                      child: Text(
                        "Register here!",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: "Poppins",
                          color: Colors.white,
                          fontSize: 54,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      width: 325,
                      height: 335,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 0.0, bottom: 8.0, left: 40.0, right: 40.0),
                          ),
                          Form(
                            key: _registerFormKey,
                            child: Column(
                              children: <Widget>[
                                //username field
                                TextFormField(
                                  controller: _nameTextController,
                                  focusNode: _focusName,
                                  validator: (value) => Validator.validateName(
                                    name: value,
                                  ),
                                  style: TextStyle(color: Colors.white),
                                  decoration: InputDecoration(
                                    labelText: "Name",
                                    labelStyle: TextStyle(
                                        color:
                                            Color.fromARGB(255, 255, 255, 255)),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      borderSide: BorderSide(
                                          width: 2.0, color: Colors.white),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      borderSide: BorderSide(
                                          width: 2.0, color: Colors.white),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      borderSide: BorderSide(
                                          width: 2.0, color: Colors.white),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 4.0,
                                      bottom: 12.0,
                                      left: 40.0,
                                      right: 40.0),
                                ),
                                //email field
                                TextFormField(
                                  controller: _emailTextController,
                                  focusNode: _focusEmail,
                                  validator: (value) => Validator.validateEmail(
                                    email: value,
                                  ),
                                  style: TextStyle(color: Colors.white),
                                  decoration: InputDecoration(
                                    labelText: "Email",
                                    labelStyle: TextStyle(
                                        color:
                                            Color.fromARGB(255, 255, 255, 255)),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      borderSide: BorderSide(
                                          width: 2.0, color: Colors.white),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      borderSide: BorderSide(
                                          width: 2.0, color: Colors.white),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      borderSide: BorderSide(
                                          width: 2.0, color: Colors.white),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 4.0,
                                      bottom: 12.0,
                                      left: 40.0,
                                      right: 40.0),
                                ),
                                //password field
                                TextFormField(
                                  controller: _passwordTextController,
                                  focusNode: _focusPassword,
                                  obscureText: true,
                                  validator: (value) =>
                                      Validator.validatePassword(
                                    password: value,
                                  ),
                                  style: TextStyle(color: Colors.white),
                                  decoration: InputDecoration(
                                    labelText: "Password",
                                    labelStyle: TextStyle(
                                        color:
                                            Color.fromARGB(255, 255, 255, 255)),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      borderSide: BorderSide(
                                          width: 2.0, color: Colors.white),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      borderSide: BorderSide(
                                          width: 2.0, color: Colors.white),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      borderSide: BorderSide(
                                          width: 2.0, color: Colors.white),
                                    ),
                                  ),
                                ),
                                // sign up button
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 4.0,
                                      bottom: 12.0,
                                      left: 40.0,
                                      right: 40.0),
                                ),
                                _isProcessing
                                    ? CircularProgressIndicator()
                                    : Row(
                                        children: [
                                          Expanded(
                                            child: OutlinedButton(
                                              onPressed: () async {
                                                setState(() {
                                                  _isProcessing = true;
                                                });

                                                if (_registerFormKey
                                                    .currentState!
                                                    .validate()) {
                                                  User? user = await FireAuth
                                                      .registerUsingEmailPassword(
                                                    name: _nameTextController
                                                        .text,
                                                    email: _emailTextController
                                                        .text,
                                                    password:
                                                        _passwordTextController
                                                            .text,
                                                  );

                                                  setState(() {
                                                    _isProcessing = false;
                                                  });
                                                  //authentication complete
                                                  if (user != null) {
                                                    //create firestore collection
                                                    FirebaseFirestore
                                                        firestore =
                                                        FirebaseFirestore
                                                            .instance;
                                                    firestore
                                                        .collection("User")
                                                        .doc(user.uid)
                                                        .set({"Quizzes": []});
                                                    //navigate user to home page
                                                    Navigator.of(context)
                                                        .pushAndRemoveUntil(
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            ProfilePage(
                                                                user: user),
                                                      ),
                                                      ModalRoute.withName('/'),
                                                    );
                                                  }
                                                }
                                              },
                                              child: Text(
                                                'Sign up',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: 18,
                                                    color: Colors.white),
                                              ),
                                              style: OutlinedButton.styleFrom(
                                                foregroundColor: Colors.white,
                                                side: BorderSide(
                                                    width: 2.0,
                                                    color: Color.fromARGB(
                                                        255, 255, 255, 255)),
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.0)),
                                                minimumSize: Size(330, 50),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                              ],
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
                          ),
                          Divider(
                              thickness: 5,
                              indent: 55,
                              endIndent: 55,
                              color: Colors.white),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(24, 10, 24, 10),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Already have an account? ",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                                MouseRegion(
                                  cursor: SystemMouseCursors.click,
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.pushReplacement(
                                        context,
                                        PageRouteBuilder(
                                          transitionDuration: Duration
                                              .zero, // Set transition duration to zero to remove animation
                                          pageBuilder: (context, animation,
                                                  secondaryAnimation) =>
                                              LoginScreen(),
                                        ),
                                      );
                                    },
                                    child: Text(
                                      'Log in',
                                      style: TextStyle(
                                        color: Colors.blue,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
