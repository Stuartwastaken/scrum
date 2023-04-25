import 'dart:async';
import 'package:flutter/material.dart';
import 'package:scrum/controllers/quiz-stream.dart';
import 'package:scrum/controllers/screen-navigator.dart';
import 'package:scrum/screens/game-pin-screen.dart';
import 'package:scrum/utils/fire_RTdatabase.dart';
import 'package:scrum/screens/mc-screen.dart';

import '../controllers/quiz-document.dart';

class LobbyScreen extends StatefulWidget {
  final String quizID;
  final String hash;
  const LobbyScreen({
    Key? key,
    required this.quizID,
    required this.hash,
  }) : super(key: key);

  @override
  State<LobbyScreen> createState() => LobbyScreenState();
}

class LobbyScreenState extends State<LobbyScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  late Stream<bool> startStream;
  late ScrumRTdatabase _scrumRTdatabase;
  late Stream<int> playerStreamController;
  late final QuizStream quizStartStream;

  @override
  void dispose() {
    _controller.dispose();
    _scrumRTdatabase.dispose();
    quizStartStream.dispose();
    ScrumRTdatabase.cancelListenForKick(widget.quizID);
    super.dispose();
  }

  void loadQuiz() async {
    String doc = await ScrumRTdatabase.getQuizDoc(widget.quizID);
    Quiz.getInstance(document: doc);
  }

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3500),
    )..repeat();

    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);

    _scrumRTdatabase = ScrumRTdatabase();
    ScrumRTdatabase.listenForKick(widget.quizID, widget.hash, context);
    _scrumRTdatabase.listenToPeopleInLobby(widget.quizID);
    playerStreamController = _scrumRTdatabase.playerCountStream;
    loadQuiz();

    quizStartStream = QuizStream();
    quizStartStream.listenForStart(widget.quizID);
    startStream = quizStartStream.startStream;
    quizStartStream.isStartTrueStream.listen((isStartZero) {
      if (isStartZero) {
        print("quizID: ${widget.quizID}");
        print("uid: ${widget.hash}");
        ScreenNavigator.navigate(context,
            MultipleChoiceWidget(quizID: widget.quizID, uid: widget.hash));
      }
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
                      ScrumRTdatabase.removeUserFromTree(
                          widget.hash.toString(), widget.quizID);
                      ScrumRTdatabase.incrementPeopleInLobby(widget.quizID, -1);
                      ScreenNavigator.navigate(context, GamePinScreen());
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
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    AnimatedBuilder(
                      animation: _animation,
                      builder: (BuildContext context, Widget? child) {
                        final ellipsis =
                            '.' * (0 + (_animation.value * 4).floor());
                        return Text(
                          "Waiting for Players$ellipsis",
                          style: TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: 72,
                            fontStyle: FontStyle.italic,
                            color: Colors.white,
                          ),
                        );
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
                                '${snapshot.data}',
                                style: TextStyle(
                                  fontWeight: FontWeight.w800,
                                  fontSize: 80,
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
                    Text(
                      "Players Joined",
                      style: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontStyle: FontStyle.normal,
                          fontSize: 32,
                          color: Colors.white),
                    ),
                  ],
                ),
              ),
            ],
          )),
    );
  }
}
