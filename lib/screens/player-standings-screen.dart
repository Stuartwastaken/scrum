import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class PlayerStandingsScreen extends StatefulWidget {
  final String quizId;

  PlayerStandingsScreen({required this.quizId});

  @override
  _PlayerStandingsScreenState createState() => _PlayerStandingsScreenState();
}

class _PlayerStandingsScreenState extends State<PlayerStandingsScreen> {
  late DatabaseReference _databaseReference;
  late List<Map<dynamic, dynamic>> _leaderboard;

  @override
  void initState() {
    super.initState();
    _databaseReference = FirebaseDatabase.instance.ref().child(widget.quizId);
    _leaderboard = [];
    _loadLeaderboard();
  }

  void _loadLeaderboard() {
    _databaseReference.onValue.listen((event) {
      DataSnapshot snapshot = event.snapshot;
      Map<dynamic, dynamic>? values = snapshot.value as Map<dynamic, dynamic>?;
      if (values != null) {
        // Sort the values by score
        List<dynamic> sortedValues = values.values.toList()
          ..sort((a, b) => b["score"].compareTo(a["score"]));
        // Get the top 5 values
        _leaderboard = sortedValues.sublist(0, 5).cast<Map<dynamic, dynamic>>();
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
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
                    ..._leaderboard.map((entry) {
                      return Text(
                        '${entry["nickname"]} - ${entry["score"]}',
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
