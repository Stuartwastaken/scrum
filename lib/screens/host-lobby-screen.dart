import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:scrum/controllers/screen-navigator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:scrum/screens/home-screen.dart';
import 'package:scrum/utils/fire_RTdatabase.dart';
import 'package:scrum/screens/host-mc-screen.dart';

import '../controllers/quiz-document.dart';

class HostLobbyScreen extends StatefulWidget {
  final String document;
  final User user;
  const HostLobbyScreen({
    Key? key,
    required this.document,
    required this.user,
  }) :super(key: key);
    
  @override
  State<HostLobbyScreen> createState() => HostLobbyScreenState();
}

class HostLobbyScreenState extends State<HostLobbyScreen> {
  late ScrumRTdatabase _scrumRTdatabase;
  late Stream<int> playerStreamController;
  late Future<String> quizID = ScrumRTdatabase.createQuiz(widget.document);
  String quizIDString = '';
  late User _currentUser;

  @override
  void dispose() {
    _scrumRTdatabase.dispose();
    super.dispose();
  }

  void loadQuiz() async {
    String doc = await ScrumRTdatabase.getQuizDoc(quizIDString);
    Quiz.getInstance(document: doc);
  }

  @override
  void initState() {
    _currentUser = widget.user;
    super.initState();

    _scrumRTdatabase = ScrumRTdatabase();
    playerStreamController = _scrumRTdatabase.playerCountStream;
    quizID.then((value) {
      quizIDString = value;
      _scrumRTdatabase.listenToPeopleInLobby(quizIDString);
      loadQuiz();
    });
  }

  @override
  Widget build(BuildContext context) {
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
            children: <Widget>[
              Positioned(
                  top: 16,
                  right: 16,
                  child: OutlinedButton(
                    onPressed: () {
                      playerStreamController.drain();
                      ScrumRTdatabase.deleteLobby(quizIDString);
                      ScreenNavigator.navigate(context, ProfilePage(user: _currentUser));
                    },
                    child: Text(
                      "Leave",
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
                  )),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: 12),
                    FutureBuilder<String>(
                      future: quizID,
                      builder: (BuildContext context,
                          AsyncSnapshot<String> snapshot) {
                        if (snapshot.hasData) {
                          // Use the quiz ID here
                          String quizID = snapshot.data!;
                          return Text(
                            'Join the SCRUM: $quizID',
                            style: TextStyle(
                              fontWeight: FontWeight.w800,
                              fontSize: 72,
                              fontStyle: FontStyle.normal,
                              color: Colors.white,
                            ),
                          );
                        } else if (snapshot.hasError) {
                          // Handle the error here
                          return Text('Error: ${snapshot.error}');
                        } else {
                          // Show a loading indicator while waiting for the Future to complete
                          return CircularProgressIndicator();
                        }
                      },
                    ),
                    SizedBox(height: 2),
                    StreamBuilder<int>(
                      stream: playerStreamController,
                      builder:
                          (BuildContext context, AsyncSnapshot<int> snapshot) {
                        if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        } else {
                          switch (snapshot.connectionState) {
                            case ConnectionState.none:
                              return Text('Not connected to the stream');
                            case ConnectionState.waiting:
                              return Text('Loading...');
                            case ConnectionState.active:
                              return Text(
                                '${snapshot.data} players joined',
                                style: TextStyle(
                                  fontWeight: FontWeight.w800,
                                  fontSize: 48,
                                  fontStyle: FontStyle.normal,
                                  color: Colors.white,
                                ),
                              );
                            case ConnectionState.done:
                              return Text('Stream has ended');
                          }
                        }
                      },
                    ),
                    ConstrainedBox(
                      constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width * 0.8,
                        maxHeight: MediaQuery.of(context).size.height * 0.65,
                      ),
                      child: FutureBuilder<String>(
                        future: quizID,
                        builder: (BuildContext context,
                            AsyncSnapshot<String> quizIdSnapshot) {
                          if (quizIdSnapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          if (quizIdSnapshot.hasError) {
                            return Center(
                              child: Text('Failed to create quiz'),
                            );
                          }
                          final quizId = quizIdSnapshot.data!;
                          _scrumRTdatabase.listenToPeopleInLobby(quizId);
                          return StreamBuilder(
                            stream: FirebaseDatabase.instance
                                .ref()
                                .child(quizIDString)
                                .onValue,
                            builder: (BuildContext context,
                                AsyncSnapshot<DatabaseEvent> snapshot) {
                              if (snapshot.hasData) {
                                final eventData = snapshot.data?.snapshot.value;
                                if (eventData is Map<dynamic, dynamic>) {
                                  final lobbyData = eventData;
                                  List<Widget> buttons = [];
                                  lobbyData.forEach((key, value) {
                                    if (key.startsWith('uid')) {
                                      String nickname = value['nickname'];
                                      // Create an outlined button with the nickname
                                      buttons.add(
                                        OutlinedButton(
                                          child: Text(
                                            nickname,
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                              fontSize: 22,
                                            ),
                                          ),
                                          onPressed: () {
                                            ScrumRTdatabase.removeUserFromTree(
                                                key, quizIDString);
                                            ScrumRTdatabase
                                                .incrementPeopleInLobby(
                                                    quizIDString, -1);
                                            setState(() {
                                              buttons.removeWhere((element) =>
                                                  element.key == ValueKey(key));
                                            });
                                          },
                                          key: ValueKey(key),
                                          style: ElevatedButton.styleFrom(
                                            foregroundColor: Color.fromARGB(
                                                255, 255, 255, 255),
                                            side: BorderSide(
                                                width: 2.0,
                                                color: Color.fromARGB(
                                                    255,
                                                    255,
                                                    255,
                                                    255)), // foreground color
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(
                                                  7), // set the desired border radius here
                                            ),
                                            minimumSize: Size(0, 55),
                                          ),
                                        ),
                                      );
                                    }
                                  });
                                  // Create a container with the list of buttons evenly spaced
                                  return Center(
                                    child: Wrap(
                                      spacing: 10,
                                      runSpacing: 10,
                                      runAlignment: WrapAlignment.center,
                                      children: buttons,
                                    ),
                                  );
                                }
                              }
                              // Return a placeholder widget while data is being fetched
                              return CircularProgressIndicator();
                            },
                          );
                        },
                      ),
                    ),
                    OutlinedButton(
                      onPressed: () {
                        ScrumRTdatabase.setTimer(quizIDString, 20);
                        ScrumRTdatabase.setStart(quizIDString);
                        ScreenNavigator.navigate(context,
                            HostMultipleChoiceWidget(quizID: quizIDString));
                      },
                      child: Text(
                        "Begin!",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
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
                        minimumSize: Size(180, 80),
                      ),
                    )
                  ],
                ),
              ),
            ],
          )),
    );
  }
}
