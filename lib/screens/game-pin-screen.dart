import 'dart:async';
import 'package:flutter/material.dart';
import 'package:scrum/screens/lobby_screen.dart';
import 'package:scrum/screens/login-screen.dart';
import '../routes.dart';
import 'package:scrum/screens/home-screen.dart';
import 'register-screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:scrum/utils/fire_RTdatabase.dart';

class GamePinScreen extends StatefulWidget {
  const GamePinScreen({super.key});

  @override
  State<GamePinScreen> createState() => GamePinScreenState();
}

class GamePinScreenState extends State<GamePinScreen> {
  bool _isProcessing = false;

  Future<FirebaseApp> _initializeFirebase() async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();

    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => ProfilePage(
            user: user,
          ),
        ),
      );
    }
    return firebaseApp;
  }

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

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Scaffold(
        body: FutureBuilder(
            future: _initializeFirebase(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return Scaffold(
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
                        Positioned(
                            top: 16,
                            right: 106,
                            child: OutlinedButton(
                              onPressed: () {
                                Navigator.pushReplacement(
                                  context,
                                  PageRouteBuilder(
                                    pageBuilder:
                                        (context, animation1, animation2) =>
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
                                onPrimary: Color.fromARGB(255, 255, 255, 255),
                                side: BorderSide(
                                    width: 2.0,
                                    color: Color.fromARGB(255, 255, 255,
                                        255)), // foreground color
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
                            child: OutlinedButton(
                              onPressed: () {
                                Navigator.pushReplacement(
                                  context,
                                  PageRouteBuilder(
                                    pageBuilder:
                                        (context, animation1, animation2) =>
                                            RegisterScreen(),
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
                                onPrimary: Color.fromARGB(255, 255, 255, 255),
                                side: BorderSide(
                                    width: 2.0,
                                    color: Color.fromARGB(255, 255, 255,
                                        255)), // foreground color
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
                              Text(
                                "SCRUM",
                                style: TextStyle(
                                    fontWeight: FontWeight.w800,
                                    fontSize: 80,
                                    color: Colors.white),
                              ),
                              Text(
                                "Transforming the world of work.",
                                style: TextStyle(
                                    fontWeight: FontWeight.w800,
                                    fontStyle: FontStyle.italic,
                                    fontSize: 32,
                                    color: Colors.white),
                              ),
                              Container(
                                width: 400,
                                height: 225,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 12.0,
                                          bottom: 12.0,
                                          left: 40.0,
                                          right: 40.0),
                                      child: TextField(
                                        controller: pinController,
                                        style: TextStyle(color: Colors.white),
                                        decoration: InputDecoration(
                                          labelText: 'Game PIN',
                                          labelStyle: TextStyle(
                                              color: Color.fromARGB(
                                                  255, 255, 255, 255)),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                            borderSide: BorderSide(
                                                width: 2.0,
                                                color: Colors.white),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                            borderSide: BorderSide(
                                                width: 2.0,
                                                color: Colors.white),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                            borderSide: BorderSide(
                                                width: 2.0,
                                                color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 4.0,
                                          bottom: 12.0,
                                          left: 40.0,
                                          right: 40.0),
                                      child: TextField(
                                        controller: nicknameController,
                                        style: TextStyle(color: Colors.white),
                                        decoration: InputDecoration(
                                          labelText: 'Nickname',
                                          labelStyle: TextStyle(
                                              color: Color.fromARGB(
                                                  255, 255, 255, 255)),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                            borderSide: BorderSide(
                                                width: 2.0,
                                                color: Colors.white),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                            borderSide: BorderSide(
                                                width: 2.0,
                                                color: Colors.white),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                            borderSide: BorderSide(
                                                width: 2.0,
                                                color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 4.0, bottom: 12.0),
                                      child: OutlinedButton(
                                        onPressed: () async {
                                          if (isPinEmpty(pinController) &
                                              isNicknameEmpty(
                                                  nicknameController)) {
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
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                    ),
                                                  ],
                                                );
                                              },
                                            );
                                          } else if (isPinEmpty(
                                              pinController)) {
                                            showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                  title: Text(
                                                      "Please enter a gamepin"),
                                                  actions: [
                                                    TextButton(
                                                      child: Text("OK"),
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                    ),
                                                  ],
                                                );
                                              },
                                            );
                                          } else if (isNicknameEmpty(
                                              nicknameController)) {
                                            showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                  title: Text(
                                                      "Please enter a nickname"),
                                                  actions: [
                                                    TextButton(
                                                      child: Text("OK"),
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                    ),
                                                  ],
                                                );
                                              },
                                            );
                                          } else if (!await ScrumRTdatabase
                                              .checkPinExists(getPin())) {
                                            showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                  title: Text(
                                                      "Game pin is not valid"),
                                                  actions: [
                                                    TextButton(
                                                      child: Text("OK"),
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                    ),
                                                  ],
                                                );
                                              },
                                            );
                                          } else if (await ScrumRTdatabase
                                                  .checkPinExists(getPin()) &
                                              !isNicknameEmpty(
                                                  nicknameController)) {
                                            ScrumRTdatabase.writeUserToTree(
                                                getNickname(), getPin());
                                            print(
                                                "The user should be written!");

                                            String gameID = pinController.text;
                                            ScrumRTdatabase
                                                .incrementPeopleInLobby(
                                                    gameID, 1);
                                            Navigator.pushReplacement(
                                              context,
                                              PageRouteBuilder(
                                                pageBuilder: (context,
                                                        animation1,
                                                        animation2) =>
                                                    LobbyScreen(gameID: gameID),
                                                transitionDuration:
                                                    Duration.zero,
                                                reverseTransitionDuration:
                                                    Duration.zero,
                                              ),
                                            );
                                          }
                                        },
                                        child: Text(
                                          "Enter",
                                          style: TextStyle(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 18,
                                          ),
                                        ),
                                        style: OutlinedButton.styleFrom(
                                          primary: Colors.white,
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
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }
              return Center(
                child: CircularProgressIndicator(),
              );
            }),
      ),
    );
  }
}
