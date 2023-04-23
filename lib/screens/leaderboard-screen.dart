import 'package:flutter/material.dart';
import 'package:scrum/controllers/screen-navigator.dart';
import 'package:scrum/screens/mc-screen.dart';
import 'package:scrum/utils/fire_RTdatabase.dart';
import 'package:scrum/controllers/quiz-stream.dart';

class LeaderboardScreen extends StatefulWidget {
  final String quizID;
  final String uid;

  LeaderboardScreen({required this.quizID, required this.uid});

  @override
  LeaderboardScreenState createState() => LeaderboardScreenState();
}

class LeaderboardScreenState extends State<LeaderboardScreen> {
  late final QuizStream quizTimeStream;
  late Stream<int> timeStream;

  @override
  void initState() {
    super.initState();
    print("leaderboardScreen");
    quizTimeStream = QuizStream();
    quizTimeStream.listenToQuizTime(widget.quizID);
    timeStream = quizTimeStream.timeStream;
    quizTimeStream.isTimeZeroStream.listen((isTimeZero) {
      if (isTimeZero) {
        print("LDB-T0");
        ScreenNavigator.navigate(context,
            MultipleChoiceWidget(quizID: widget.quizID, uid: widget.uid));
      }
    });
  }

  @override
  void dispose() {
    print("LDB-DIS");
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
                  return StandingsScreenBuilder(sortedEntries.sublist(0));
                } else {
                  return StandingsScreenBuilder(sortedEntries.sublist(0, 5));
                }
              } else if (snapshot.hasError) {
                return Center(child: Text("Error: ${snapshot.error}"));
              } else {
                return Center(child: CircularProgressIndicator());
              }
            }));
  }

  Widget StandingsScreenBuilder(List<MapEntry<String, dynamic>> sortedEntries) {
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
