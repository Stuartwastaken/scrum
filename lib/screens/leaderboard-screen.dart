import 'package:flutter/material.dart';
import 'package:scrum/screens/mc-screen.dart';
import 'package:scrum/utils/fire_RTdatabase.dart';
import 'package:scrum/controllers/quiz-time-stream.dart';
import 'package:scrum/controllers/quiz-document.dart';

class LeaderboardScreen extends StatefulWidget {
  final String quizID;
  final String uid;

  LeaderboardScreen({required this.quizID, required this.uid});

  @override
  LeaderboardScreenState createState() => LeaderboardScreenState();
}

Map<String, dynamic> sort(Map<String, dynamic> usersAndScores) {
  List<MapEntry<String, dynamic>> usersList = usersAndScores.entries.toList();
  usersList.sort((a, b) => b.value['score'].compareTo(a.value['score']));
  usersAndScores = Map.fromEntries(usersList);
  return usersAndScores;
}

class LeaderboardScreenState extends State<LeaderboardScreen> {
  late final QuizTimeStream quizTimeStream;
  late Stream<int> timeStream;

  @override
  void initState() {
    super.initState();

    quizTimeStream = QuizTimeStream();
    quizTimeStream.listenToQuizTime(widget.quizID);
    timeStream = quizTimeStream.timeStream;
    if (quizTimeStream.isTimeZeroStream as bool) {
      Navigator.pushReplacement(
        context, 
        PageRouteBuilder(
          transitionDuration: Duration.zero,
          reverseTransitionDuration: Duration.zero,
          pageBuilder: (context, animation, secondaryAnimation) {
            return MultipleChoiceWidget(quizID: widget.quizID, uid: widget.uid);
          },
        )
      );
    } 
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
                Map<String, dynamic> usersAndScores_sorted =
                    sort(usersAndScores);
                List<MapEntry<String, dynamic>> sortedEntries =
                    usersAndScores_sorted.entries.toList();
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
