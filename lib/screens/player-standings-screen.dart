import 'package:flutter/material.dart';
import 'package:scrum/controllers/quiz-listener.dart';
import 'package:scrum/controllers/quiz-time-stream.dart';
import 'package:scrum/screens/mc-screen.dart';
import 'package:scrum/utils/fire_RTdatabase.dart';

class PlayerStandingsScreen extends StatefulWidget {
  final String quizID;

  PlayerStandingsScreen({required this.quizID});

  @override
  _PlayerStandingsScreenState createState() => _PlayerStandingsScreenState();
}

Map<String, dynamic> sort(Map<String, dynamic> usersAndScores) {
  List<MapEntry<String, dynamic>> usersList = usersAndScores.entries.toList();
  usersList.sort((a, b) => b.value['score'].compareTo(a.value['score']));
  usersAndScores = Map.fromEntries(usersList);
  return usersAndScores;
}

class _PlayerStandingsScreenState extends State<PlayerStandingsScreen> {
  late final QuizTimeStream quizTime;

  @override
  void initState() {
    super.initState();
    quizTime = QuizTimeStream();
    quizTime.listenToQuizTime(widget.quizID);
    QuizListener.listen(
        quizTime, context, MultipleChoiceWidget(quizID: widget.quizID), 30);
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
                    ElevatedButton(
                      onPressed: () {
                        /* Add appropriate navigation later
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => NextQuestionScreen()),
                      );
                      */
                      },
                      child: Text('Next Question'),
                    ),
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
