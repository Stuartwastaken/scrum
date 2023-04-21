import 'package:flutter/material.dart';
import 'package:scrum/controllers/quiz-time-stream.dart';
import 'package:scrum/screens/host-mc-screen.dart';
import 'package:scrum/utils/fire_RTdatabase.dart';
import 'package:scrum/controllers/quiz-document.dart';

class PlayerStandingsScreen extends StatefulWidget {
  final String quizID;

  PlayerStandingsScreen({Key? key, required this.quizID}) : super(key: key);

  @override
  PlayerStandingsScreenState createState() => PlayerStandingsScreenState();
}

class PlayerStandingsScreenState extends State<PlayerStandingsScreen> {
  late final QuizTimeStream quizTimeStream;
  late final Stream<int> timeStream;

  @override
  void initState() {
    super.initState();

    Quiz quiz = Quiz.getInstance(document: widget.quizID);
    quizTimeStream = QuizTimeStream();
    quizTimeStream.listenToQuizTime(widget.quizID);
    timeStream = quizTimeStream.timeStream;
    quizTimeStream.startTimer(widget.quizID);
    quizTimeStream.isTimeZeroStream.listen((isTimeZero) {
      if (isTimeZero) {
        quizTimeStream.cancelTimer();
        ScrumRTdatabase.setTimer(widget.quizID, 30);
        Navigator.pushReplacement(
          context, 
          PageRouteBuilder(
            transitionDuration: const Duration(milliseconds: 100),
            reverseTransitionDuration: Duration.zero,
            pageBuilder: (context, animation, secondaryAnimation) {
              return HostMultipleChoiceWidget(quizID: widget.quizID);
            },
          )
        );
      } 
    });
  }

  @override
  void dispose(){
    quizTimeStream.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: FutureBuilder<Map<String, dynamic>>(
            future: ScrumRTdatabase.getUsersAndScores(widget.quizID),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                Map<String, dynamic> usersAndScores = snapshot.data!;
                Map<String, dynamic> usersandscoresSorted =
                    ScrumRTdatabase.sort(usersAndScores);
                List<MapEntry<String, dynamic>> sortedEntries =
                    usersandscoresSorted.entries.toList();
                if (sortedEntries.length < 5) {
                  return standingsScreenBuilder(sortedEntries.sublist(0));
                } else {
                  return standingsScreenBuilder(sortedEntries.sublist(0, 5));
                }
              } else if (snapshot.hasError) {
                return Center(child: Text("Error: ${snapshot.error}"));
              } else {
                return Center(child: CircularProgressIndicator());
              }
            }));
  }

  Widget standingsScreenBuilder(List<MapEntry<String, dynamic>> sortedEntries) {
    final scaffoldKey = GlobalKey<ScaffoldState>();
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 48.0),
            Container(
              padding: EdgeInsets.symmetric(vertical: 24.0),
              child: Text(
                'Current Standings',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 48.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    ...sortedEntries.map((entry) {
                      return Text(
                        '${entry.value["nickname"]} - ${entry.value["score"]}',
                        style: TextStyle(fontSize: 18.0),
                      );
                    }),
                    SizedBox(height: 32.0),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
