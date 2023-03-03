import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:scrum/screens/game-pin-screen.dart';

class PodiumScreen extends StatefulWidget {
  const PodiumScreen({super.key});

  @override
  State<PodiumScreen> createState() => _PodiumScreenState();
}

class _PodiumScreenState extends State<PodiumScreen> {
  @override
  Widget build(BuildContext context) {
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
                        child: AutoSizeText(
                          'BillyBobJoe',
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
                              child: Text(
                                'Score: 420',
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
                        child: AutoSizeText(
                          'Scrum Master',
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
                              child: Text(
                                'Score : 42069',
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
                        child: AutoSizeText(
                          'MillyBobbyBrown',
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
                              child: Text(
                                'Score: 69',
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
                        gamePinScreen(),
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
