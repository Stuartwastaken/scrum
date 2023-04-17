import 'package:flutter/material.dart';
import 'package:scrum/utils/fire_RTdatabase.dart';
import 'package:scrum/screens/game-pin-screen.dart';

class PlayerEndScreen extends StatefulWidget {
  final String quizID;
  final String uid;
  const PlayerEndScreen({
    Key? key,
    required this.quizID,
    required this.uid,
  }) : super(key: key);

  @override
  _PlayerEndScreenState createState() => _PlayerEndScreenState();
}

class _PlayerEndScreenState extends State<PlayerEndScreen> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
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
              Map<String, dynamic> usersAndScoresSorted =
                  ScrumRTdatabase.sort(usersAndScores);
              List<MapEntry<String, dynamic>> sortedEntries =
                  usersAndScoresSorted.entries.toList();
              int position =
                  ScrumRTdatabase.getPlayerPosition(sortedEntries, widget.uid);
              int points =
                  ScrumRTdatabase.getPlayerPoints(sortedEntries, widget.uid);
              return buildEndGameScreen(position.toString(), points.toString());
            } else if (snapshot.hasError) {
              return Center(child: Text("Error: ${snapshot.error}"));
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ));
  }

  Widget buildEndGameScreen(String position, String points) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Align(
          alignment: AlignmentDirectional(0, 0),
          child: Stack(
            alignment: AlignmentDirectional(0, 0),
            children: [
              Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                image: AssetImage("../../assets/images/shapes-background.jpg"),
                fit: BoxFit.cover,
              ))),
              Container(
                width: MediaQuery.of(context).size.width * 0.4,
                height: MediaQuery.of(context).size.width * 0.4,
                decoration: BoxDecoration(
                  color: Color(0xFF8E50EE),
                  shape: BoxShape.circle,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'GAME OVER',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              color: Colors.white,
                              fontSize: 80,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ]),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Final Position: $position',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            color: Colors.white,
                            fontSize: 40,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Final Score: $points',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w200,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Align(
                alignment: AlignmentDirectional(0.95, -0.95),
                child: IconButton(
                  iconSize: 60,
                  color: Color(0xFF8E50EE),
                  icon: Icon(
                    Icons.home_rounded,
                    color: Color(0xFF8E50EE),
                    size: 75,
                  ),
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      PageRouteBuilder(
                        transitionDuration: Duration.zero,
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            GamePinScreen(),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
