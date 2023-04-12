import 'package:flutter/material.dart';
import 'package:scrum/controllers/quiz-time-stream.dart';
import 'package:scrum/utils/fire_RTdatabase.dart';

class LeaderboardScreen extends StatefulWidget {
  final String quizID;

  LeaderboardScreen({required this.quizID});

  @override
  LeaderboardScreenState createState() => LeaderboardScreenState();
}

Map<String, dynamic> sort(Map<String, dynamic> usersAndScores) {
  List<MapEntry<String, dynamic>> usersList = usersAndScores.entries.toList();
  usersList.sort((a, b) => b.value['score'].compareTo(a.value['score']));
  usersAndScores = Map.fromEntries(usersList);
  return usersAndScores;
}

String getPlayer(List<MapEntry<String, dynamic>> sortedEntries, int place) {
  String username = "";

  if (sortedEntries != null && sortedEntries.isNotEmpty) {
    username = sortedEntries.length > place
        ? sortedEntries[place].value["nickname"]
        : "N/A";
  }

  return username;
}

String getScore(List<MapEntry<String, dynamic>> sortedEntries, int place) {
  String score =
      '${sortedEntries.length > place ? sortedEntries[place].value["score"] : "N/A"}';

  return score;
}

class LeaderboardScreenState extends State<LeaderboardScreen> {
  @override
  late final QuizTimeStream quizTime;

  void initState() {
    super.initState();

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
                  return StandingsScreenBuilder2(sortedEntries.sublist(0));
                } else {
                  return StandingsScreenBuilder2(sortedEntries.sublist(0, 5));
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 12,
            ),
            Container(
              child: Text(
                "Current Standings",
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 80,
                  color: Colors.white,
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: 4),
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
                            padding:
                                const EdgeInsets.only(left: 50.0, right: 50.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  getPlayer(sortedEntries, 0),
                                  style: TextStyle(
                                    fontWeight: FontWeight.w800,
                                    fontSize: 24,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  getScore(sortedEntries, 0),
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
                            padding:
                                const EdgeInsets.only(left: 50.0, right: 50.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  getPlayer(sortedEntries, 1),
                                  style: TextStyle(
                                    fontWeight: FontWeight.w800,
                                    fontSize: 24,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  getScore(sortedEntries, 1),
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
                            padding:
                                const EdgeInsets.only(left: 50.0, right: 50.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  getPlayer(sortedEntries, 2),
                                  style: TextStyle(
                                    fontWeight: FontWeight.w800,
                                    fontSize: 24,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  getScore(sortedEntries, 2),
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
                            padding:
                                const EdgeInsets.only(left: 50.0, right: 50.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  getPlayer(sortedEntries, 3),
                                  style: TextStyle(
                                    fontWeight: FontWeight.w800,
                                    fontSize: 24,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  getScore(sortedEntries, 3),
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
                            padding:
                                const EdgeInsets.only(left: 50.0, right: 50.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  getPlayer(sortedEntries, 4),
                                  style: TextStyle(
                                    fontWeight: FontWeight.w800,
                                    fontSize: 24,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  getScore(sortedEntries, 4),
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
          ],
        ),
      ),
    );
  }

  Widget StandingsScreenBuilder2(
      List<MapEntry<String, dynamic>> sortedEntries) {
    final scaffoldKey = GlobalKey<ScaffoldState>();
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 12,
            ),
            Container(
              child: Text(
                "Current Standings",
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 80,
                  color: Colors.white,
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: 4),
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
                            padding:
                                const EdgeInsets.only(left: 50.0, right: 50.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  getPlayer(sortedEntries, 0),
                                  style: TextStyle(
                                    fontWeight: FontWeight.w800,
                                    fontSize: 24,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  getScore(sortedEntries, 0),
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
                            padding:
                                const EdgeInsets.only(left: 50.0, right: 50.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  " ",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w800,
                                    fontSize: 24,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  " ",
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
                            padding:
                                const EdgeInsets.only(left: 50.0, right: 50.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  " ",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w800,
                                    fontSize: 24,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  " ",
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
                            padding:
                                const EdgeInsets.only(left: 50.0, right: 50.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  " ",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w800,
                                    fontSize: 24,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  " ",
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
                            padding:
                                const EdgeInsets.only(left: 50.0, right: 50.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  " ",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w800,
                                    fontSize: 24,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  " ",
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
          ],
        ),
      ),
    );
  }
}
