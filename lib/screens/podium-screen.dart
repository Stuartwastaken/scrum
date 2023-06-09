import 'package:flutter/material.dart';
import 'package:scrum/controllers/screen-navigator.dart';
import 'package:scrum/screens/game-pin-screen.dart';
import 'package:scrum/utils/fire_RTdatabase.dart';

class PodiumScreen extends StatefulWidget {
  final String gameID;
  const PodiumScreen({Key? key, required this.gameID}) : super(key: key);

  @override
  State<PodiumScreen> createState() => _PodiumScreenState();
}

class _PodiumScreenState extends State<PodiumScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: FutureBuilder<Map<String, dynamic>>(
        future: ScrumRTdatabase.getUsersAndScores(widget.gameID),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            Map<String, dynamic> usersAndScores = snapshot.data!;
            Map<String, dynamic> usersandscoresSorted =
                ScrumRTdatabase.sort(usersAndScores);
            List<MapEntry<String, dynamic>> sortedEntries =
                usersandscoresSorted.entries.toList();
            return buildPodiumScreen(sortedEntries);
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  Widget buildPodiumScreen(List<MapEntry<String, dynamic>> sortedEntries) {
    final scaffoldKey = GlobalKey<ScaffoldState>();
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          //background image
          Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
            image: AssetImage("../../assets/images/shapes-background.jpg"),
            fit: BoxFit.cover,
          ))),
          Container(
            alignment: AlignmentDirectional(0, 1),
            decoration: BoxDecoration(
              color: Color(0x00FFFFFF),
            ),
            child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  //Second Place Column
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        (sortedEntries.length >= 2)
                            ? sortedEntries[1].value['nickname'].toString()
                            : ' ',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Poppins',
                          color: Colors.black,
                          fontSize: 40,
                        ),
                      ),
                      Container(
                        width: 350,
                        height: 403.9,
                        decoration: BoxDecoration(
                          color: Color(0xFF864CBF),
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(0),
                            bottomRight: Radius.circular(0),
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(0),
                          ),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Container(
                                width: 120,
                                height: 120,
                                clipBehavior: Clip.antiAlias,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                  image: AssetImage(
                                      "../../assets/images/silver-medal.png"),
                                  fit: BoxFit.fitHeight,
                                ))),
                            Text(
                              (sortedEntries.length >= 2)
                                  ? sortedEntries[1].value['score'].toString()
                                  : ' ',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                color: Colors.white,
                                fontSize: 30,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  //First Place Column
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        (sortedEntries.isNotEmpty)
                            ? sortedEntries[0].value['nickname'].toString()
                            : ' ',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Poppins',
                          color: Colors.black,
                          fontSize: 40,
                        ),
                      ),
                      Container(
                        width: 350,
                        height: 578.1,
                        decoration: BoxDecoration(
                          color: Color(0xFF864CBF),
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 20,
                              color: Color(0x33000000),
                              offset: Offset(0, 2),
                            )
                          ],
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(0),
                            bottomRight: Radius.circular(0),
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                          ),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Container(
                                width: 120,
                                height: 120,
                                clipBehavior: Clip.antiAlias,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                  image: AssetImage(
                                      "../../assets/images/gold-medal.png"),
                                  fit: BoxFit.fitHeight,
                                ))),
                            Text(
                              (sortedEntries.isNotEmpty)
                                  ? sortedEntries[0].value['score'].toString()
                                  : ' ',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                color: Colors.white,
                                fontSize: 30,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  //Third Place Column
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        (sortedEntries.length >= 3)
                            ? sortedEntries[2].value['nickname'].toString()
                            : ' ',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Poppins',
                          color: Colors.black,
                          fontSize: 40,
                        ),
                      ),
                      Container(
                        width: 350,
                        height: 301.4,
                        decoration: BoxDecoration(
                          color: Color(0xFF864CBF),
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 20,
                              color: Color(0x33000000),
                              offset: Offset(0, 2),
                            )
                          ],
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(0),
                            bottomRight: Radius.circular(0),
                            topLeft: Radius.circular(0),
                            topRight: Radius.circular(10),
                          ),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Container(
                              width: 120,
                              height: 120,
                              clipBehavior: Clip.antiAlias,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(
                                      "../../assets/images/bronze-medal.png"),
                                  fit: BoxFit.fitHeight,
                                ),
                              ),
                            ),
                            Text(
                              (sortedEntries.length >= 3)
                                  ? sortedEntries[2].value['score'].toString()
                                  : ' ',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                color: Colors.white,
                                fontSize: 30,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ]),
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
                ScrumRTdatabase.deleteLobby(widget.gameID);
                ScreenNavigator.navigate(context, GamePinScreen()); //will automatically direct to HomeScreen if user is logged in, else GamePinScreen
              },
            ),
          ),
        ],
      ),
    );
  }
}
