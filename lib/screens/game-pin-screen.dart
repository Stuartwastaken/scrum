import 'dart:async';
import 'package:flutter/material.dart';
import 'package:scrum/screens/login-screen.dart';
import '../routes.dart';
import 'register-screen.dart';
import 'package:firebase_database/firebase_database.dart';

class GamePinScreen extends StatefulWidget {
  const GamePinScreen({super.key});

  @override
  State<GamePinScreen> createState() => GamePinScreenState();
}

class GamePinScreenState extends State<GamePinScreen> {
  FirebaseDatabase database = FirebaseDatabase.instance;
  final nicknameController = TextEditingController();
  final pinController = TextEditingController();

  String getNickname() {
    return nicknameController.text;
  }

  bool isNicknameEmpty(TextEditingController nicknameController) {
    return nicknameController.text.isEmpty;
  }

  String getPin() {
    return pinController.text;
  }

  bool isPinEmpty(TextEditingController pinController) {
    return pinController.text.isEmpty;
  }

  Future<void> writeUserToTree(String nickname, String gamePin) async {
    final databaseRef = FirebaseDatabase.instance.reference();
    final gamePinRef = databaseRef.child(gamePin);
    String? hash = gamePinRef.push().key;

    await gamePinRef.child(hash!).set({
      'nickname': nickname,
      'score': 0,
    });
  }

  Future<bool> checkPinExists(String pinID) async {
    final databaseRef = FirebaseDatabase.instance.reference();
    var snapshot = await databaseRef.child(pinID).once();

    return snapshot.snapshot.exists;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Color.fromARGB(255, 5, 70, 175),
              Color.fromARGB(255, 180, 203, 240),
            ],
          ),
        ),
        child: Stack(
          children: [
            Positioned(
                top: 16,
                right: 106,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation1, animation2) =>
                            LoginScreen(),
                        transitionDuration: Duration.zero,
                        reverseTransitionDuration: Duration.zero,
                      ),
                    );
                  },
                  child: Text(
                    "Login",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white, // background color
                    onPrimary:
                        Color.fromARGB(255, 5, 70, 175), // foreground color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          7), // set the desired border radius here
                    ),
                    minimumSize: Size(90, 35),
                  ),
                )),
            Positioned(
                top: 16,
                right: 16,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation1, animation2) =>
                            Register(),
                        transitionDuration: Duration.zero,
                        reverseTransitionDuration: Duration.zero,
                      ),
                    );
                  },
                  child: Text(
                    "Sign Up",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white, // background color
                    onPrimary:
                        Color.fromARGB(255, 5, 70, 175), // foreground color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          7), // set the desired border radius here
                    ),
                    minimumSize: Size(90, 35),
                  ),
                )),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    'images/SCRUM2.png', // path to your image file
                    width: MediaQuery.of(context).size.width * 0.265,
                    //height: 250,
                    fit: BoxFit.fitWidth,
                  ),
                  SizedBox(height: 12),
                  Container(
                    width: 400,
                    height: 225,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(7),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          offset: Offset(0.0, 1.0),
                          blurRadius: 15.0,
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 12.0, bottom: 12.0, left: 40.0, right: 40.0),
                          child: TextField(
                              controller: pinController,
                              style: new TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontFamily: "SegoeUI",
                                  fontStyle: FontStyle.normal,
                                  fontSize: 16.0),
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Color.fromARGB(255, 0, 0,
                                            0)), // Set border color to a darker shade of grey
                                  ),
                                  hintText: 'Game PIN',
                                  labelStyle: new TextStyle(
                                      color: const Color(0xFF424242)))),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 4.0, bottom: 12.0, left: 40.0, right: 40.0),
                          child: TextField(
                            controller: nicknameController,
                            style: TextStyle(
                              fontFamily: 'Roboto',
                              fontSize: 16,
                              color: Colors.black,
                            ),
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'Nickname',
                                labelStyle: new TextStyle(
                                    color: const Color(0xFF424242))),
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(top: 4.0, bottom: 12.0),
                          child: ElevatedButton(
                            onPressed: () async {
                              if (isPinEmpty(pinController) &
                                  isNicknameEmpty(nicknameController)) {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text(
                                          "Please enter a game pin and nickname"),
                                      actions: [
                                        TextButton(
                                          child: Text("OK"),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                );
                              } else if (isPinEmpty(pinController)) {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text("Please enter a gamepin"),
                                      actions: [
                                        TextButton(
                                          child: Text("OK"),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                );
                              } else if (isNicknameEmpty(nicknameController)) {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text("Please enter a nickname"),
                                      actions: [
                                        TextButton(
                                          child: Text("OK"),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                );
                              } else if (!await checkPinExists(getPin())) {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text("Game pin is not valid"),
                                      actions: [
                                        TextButton(
                                          child: Text("OK"),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                );
                              } else if (await checkPinExists(getPin()) &
                                  !isNicknameEmpty(nicknameController)) {
                                writeUserToTree(getNickname(), getPin());
                                print("The user should be written!");
                              }
                            },
                            child: Text(
                              "Enter",
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 16,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              primary: Color.fromARGB(255, 5, 70, 175),
                              onPrimary: Colors.white,
                              shadowColor: Colors.grey,
                              elevation: 3,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(7.0)),
                              minimumSize: Size(330, 50),
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
    );
  }
}
