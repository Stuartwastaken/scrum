import 'dart:async';
import 'package:firebase_database/firebase_database.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:scrum/screens/game-pin-screen.dart';

class PodiumScreen extends StatefulWidget {
  const PodiumScreen({super.key});

  @override
  State<PodiumScreen> createState() => _PodiumScreenState();
}

Future<Map<String, dynamic>> getUsersAndScores(String lobbyID) async {
  final databaseRef = FirebaseDatabase.instance.ref();
  Map<String, dynamic> usersInLobby = {};
  await databaseRef.child(lobbyID).once().then((DatabaseEvent event) {
    Map<dynamic, dynamic> lobbyData = event.snapshot.value as Map;
    if (lobbyData != null) {
      lobbyData.forEach((uid, userData) {
        if (uid.toString().substring(0,3) == 'uid') {
          String nickname = userData['nickname'];
          int score = userData['score'];
          usersInLobby[uid] = {
            'nickname': nickname,
            'score': score
          };
        };
      });
    }
  });
  return usersInLobby;
}

Map<String, dynamic> sort(Map<String, dynamic> usersAndScores){
  List<MapEntry<String, dynamic>> usersList = usersAndScores.entries.toList();
  usersList.sort((a,b) => b.value['score'].compareTo(a.value['score']));
  usersAndScores = Map.fromEntries(usersList);
  return usersAndScores;
}

class _PodiumScreenState extends State<PodiumScreen> {
  //global variables
  Map<String, dynamic> usersAndScores_sorted = {};
  List<MapEntry<String, dynamic>> sortedEntries = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: FutureBuilder<Map<String, dynamic>>(
        future: getUsersAndScores('998765'), //hardcoded lobbyID. Will need to be changed where lobbyID is passed as parameter to constructor.
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            Map<String, dynamic> usersAndScores = snapshot.data!;
            Map<String, dynamic> usersAndScores_sorted = sort(usersAndScores);
            List<MapEntry<String, dynamic>> sortedEntries = usersAndScores_sorted.entries.toList();
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
              )
            )
          ),
          Container(
            width: 1445.3,
            height: 905.1,
            decoration: BoxDecoration(
              color: Color(0x00FFFFFF),
            ),
            alignment: AlignmentDirectional(0, 0),
            child: Align(
              alignment: AlignmentDirectional(0, 1),
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
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
                        child: AutoSizeText( (sortedEntries.length >= 2)? sortedEntries[1].value['nickname'].toString(): ' ',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Poppins',
                            color: Colors.black,
                            fontSize: 40,
                          ),
                        )
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
                                  image: AssetImage("../../assets/images/silver-medal.png"),
                                  fit: BoxFit.fitHeight,
                                )
                              )
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(0, 15, 0, 0),
                              child: Text( (sortedEntries.length >= 2)? sortedEntries[1].value['score'].toString(): ' ',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  color: Colors.white,
                                  fontSize: 30,
                                ),
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
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
                        child: AutoSizeText( (sortedEntries.length >= 1)? sortedEntries[0].value['nickname'].toString(): ' ',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Poppins',
                            color: Colors.black,
                            fontSize: 40,
                          ),
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
                                  image: AssetImage("../../assets/images/gold-medal.png"),
                                  fit: BoxFit.fitHeight,
                                )
                              )
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(0, 15, 0, 0),
                              child: Text( (sortedEntries.length >= 1)? sortedEntries[0].value['score'].toString(): ' ',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  color: Colors.white,
                                  fontSize: 30,
                                ),
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
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
                        child: AutoSizeText( (sortedEntries.length >= 3)? sortedEntries[2].value['nickname'].toString(): ' ',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Poppins',
                            color: Colors.black,
                            fontSize: 40,
                          ),
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
                                  image: AssetImage("../../assets/images/bronze-medal.png"),
                                  fit: BoxFit.fitHeight,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(0, 15, 0, 0),
                              child: Text( (sortedEntries.length >= 3)? sortedEntries[2].value['score'].toString(): ' ',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  color: Colors.white,
                                  fontSize: 30,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ]
              ),
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
                    pageBuilder: (context, animation,
                      secondaryAnimation) =>
                        GamePinScreen(),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}