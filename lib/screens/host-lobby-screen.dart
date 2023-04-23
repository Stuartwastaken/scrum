import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:scrum/utils/fire_RTdatabase.dart';

class HostLobbyScreen extends StatefulWidget {
  final String document;
  const HostLobbyScreen({
    Key? key,
    required this.document,
  }) : super(key: key);

  @override
  State<HostLobbyScreen> createState() => HostLobbyScreenState();
}

class HostLobbyScreenState extends State<HostLobbyScreen> {
  late ScrumRTdatabase _scrumRTdatabase;
  late Stream<int> playerStreamController;
  late Future<String> quizID = ScrumRTdatabase.createQuiz(widget.document);
  String quizIDString = '';

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    _scrumRTdatabase = ScrumRTdatabase();
    playerStreamController = _scrumRTdatabase.playerCountStream;
    quizID.then((value) {
      quizIDString = value;
      _scrumRTdatabase.listenToPeopleInLobby(quizIDString);
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
                      /*
                      Navigator.pushReplacement(
                        context,
                        PageRouteBuilder(
                          pageBuilder: (context, animation1, animation2) =>
                              const GamePinScreen(),
                          transitionDuration: Duration.zero,
                          reverseTransitionDuration: Duration.zero,
                        ),
                      );
                      */

                      ScrumRTdatabase.deleteLobby(quizIDString);
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
                        /*
                      Navigator.pushReplacement(
                        context,
                        PageRouteBuilder(
                          pageBuilder: (context, animation1, animation2) =>
                              const HostMultipleChoiceWidget(quizID: quizIDString),
                          transitionDuration: Duration.zero,
                          reverseTransitionDuration: Duration.zero,
                        ),
                      );
                      */
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