import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:scrum/controllers/quiz-time-stream.dart';
import 'package:scrum/screens/game-pin-screen.dart';
import 'package:firebase_database/firebase_database.dart';

class LeaderboardScreen extends StatefulWidget {
  final String quizID;

  LeaderboardScreen({required this.quizID});

  @override
  State<LeaderboardScreen> createState() => LeaderboardScreenState();
}

class LeaderboardScreenState extends State<LeaderboardScreen> {
  late DatabaseReference databaseRef;
  late List<Map<dynamic, dynamic>> _leaderboard;
  late final QuizTimeStream quizTime;

  @override
  void dispose() {}

  @override
  void initState() {
    super.initState();
    databaseRef = FirebaseDatabase.instance.ref().child(widget.quizID);
    _leaderboard = [];
    _loadLeaderboard();

    quizTime = QuizTimeStream();
    quizTime.timeStream.listen((time) {
      // Check if time is 0
      if (time == 0) {
        // Navigate to a different page
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => LeaderboardScreen(quizID: "999999")),
        );
      }
    });
  }

  _loadLeaderboard() {
    databaseRef.onValue.listen((event) {
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

  String getPlayer(int place) {
    String username = "";

    if (_leaderboard != null && _leaderboard.isNotEmpty) {
      username =
          _leaderboard.isNotEmpty ? _leaderboard[place]["nickname"] : "N/A";
    }

    return username;
  }

  String getScore(int place) {
    String score =
        '${_leaderboard.isNotEmpty ? _leaderboard[place]["score"] : "N/A"}';

    return score;
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
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "Results",
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 92,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 8),
              Container(
                width: MediaQuery.of(context).size.width * 0.5,
                height: MediaQuery.of(context).size.height * 0.6,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.white,
                    width: 4,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 50.0, right: 50.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            getPlayer(0),
                            style: TextStyle(
                              fontWeight: FontWeight.w800,
                              fontSize: 24,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            getScore(0),
                            style: TextStyle(
                              fontWeight: FontWeight.w800,
                              fontSize: 24,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                        height: 3,
                        width: MediaQuery.of(context).size.width * 0.42,
                        child: Container(color: Colors.white)),
                    Padding(
                      padding: const EdgeInsets.only(left: 50.0, right: 50.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            getPlayer(1),
                            style: TextStyle(
                              fontWeight: FontWeight.w800,
                              fontSize: 24,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            getScore(1),
                            style: TextStyle(
                              fontWeight: FontWeight.w800,
                              fontSize: 24,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                        height: 3,
                        width: MediaQuery.of(context).size.width * 0.42,
                        child: Container(color: Colors.white)),
                    Padding(
                      padding: const EdgeInsets.only(left: 50.0, right: 50.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            getPlayer(2),
                            style: TextStyle(
                              fontWeight: FontWeight.w800,
                              fontSize: 24,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            getScore(2),
                            style: TextStyle(
                              fontWeight: FontWeight.w800,
                              fontSize: 24,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                        height: 3,
                        width: MediaQuery.of(context).size.width * 0.42,
                        child: Container(color: Colors.white)),
                    Padding(
                      padding: const EdgeInsets.only(left: 50.0, right: 50.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            getPlayer(3),
                            style: TextStyle(
                              fontWeight: FontWeight.w800,
                              fontSize: 24,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            getScore(3),
                            style: TextStyle(
                              fontWeight: FontWeight.w800,
                              fontSize: 24,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                        height: 3,
                        width: MediaQuery.of(context).size.width * 0.42,
                        child: Container(color: Colors.white)),
                    Padding(
                      padding: const EdgeInsets.only(left: 50.0, right: 50.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            getPlayer(4),
                            style: TextStyle(
                              fontWeight: FontWeight.w800,
                              fontSize: 24,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            getScore(4),
                            style: TextStyle(
                              fontWeight: FontWeight.w800,
                              fontSize: 24,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 12,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Column(
                    children: [
                      Text(
                        "14",
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 80,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        "Selected A",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 24,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 28,
                  ),
                  Column(
                    children: [
                      Text(
                        "2",
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 80,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        "Selected B",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 24,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 28,
                  ),
                  Column(
                    children: [
                      Text(
                        "6",
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 80,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        "Selected C",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 24,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 28,
                  ),
                  Column(
                    children: [
                      Text(
                        "1",
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 80,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        "Selected D",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 24,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
