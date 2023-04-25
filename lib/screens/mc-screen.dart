import 'package:flutter/material.dart';
import 'package:scrum/controllers/calculate-score.dart';
import 'package:scrum/controllers/quiz-stream.dart';
import 'package:scrum/controllers/screen-navigator.dart';
import 'package:scrum/screens/post-question-screen.dart';
import 'package:scrum/utils/fire_RTdatabase.dart';

import '../controllers/quiz-document.dart';

import '../utils/fire_RTdatabase.dart';

class MultipleChoiceWidget extends StatefulWidget {
  MultipleChoiceWidget({
    Key? key,
    required this.quizID,
    required this.uid,
  }) : super(key: key);

  final String quizID;
  final String uid;
  bool isCorrect = false;
  int pointsGained = 0;

  @override
  MultipleChoiceWidgetState createState() => MultipleChoiceWidgetState();
}

class MultipleChoiceWidgetState extends State<MultipleChoiceWidget>
    with TickerProviderStateMixin {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  late final QuizStream quizTimeStream;
  late Stream<int> timeStream;
  bool buttonsEnabled = true;
  int correctIndex = Quiz.getInstance().getCorrectAnswer();
  int selectedIndex = -1;

  void onButtonPressed(int index) async {
    setState(() {
      selectedIndex = index;
      buttonsEnabled = false;
      widget.isCorrect = selectedIndex == correctIndex;
    });
    if (widget.isCorrect) {
      int remainingTime = await ScrumRTdatabase.getTime(widget.quizID) as int;
      widget.pointsGained = CalculateScore.calculateAddValue(remainingTime);
      ScrumRTdatabase.addPointsToPlayer(
          widget.quizID, widget.uid, widget.pointsGained);
    } else {
      widget.pointsGained = 0;
    }
  }

  void disableButtons() {
    setState(() {
      buttonsEnabled = false;
    });
  }

  @override
  void initState() {
    super.initState();
    quizTimeStream = QuizStream();
    quizTimeStream.listenToQuizTime(widget.quizID);
    timeStream = quizTimeStream.timeStream;
    quizTimeStream.isTimeZeroStream.listen((isTimeZero) {
      if (isTimeZero) {
        ScreenNavigator.navigate(
            context,
            PostQuestionScreenWidget(
                quizID: widget.quizID,
                uid: widget.uid,
                isCorrect: widget.isCorrect,
                pointsGained: widget.pointsGained));
      }
    });
  }

  @override
  void dispose() {
    quizTimeStream.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Color(0xFF1E2429),
      body: Container(
          width: double.infinity,
          height: double.infinity,
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
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 24, 0, 0),
              ),
              Container(
                width: 919.8,
                height: 412.1,
                decoration: BoxDecoration(),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 0, 5, 5),
                              child: Container(
                                width: 400,
                                height: 300,
                                decoration: BoxDecoration(
                                  color: Color(0xFFB21B3C),
                                  borderRadius: BorderRadius.circular(30),
                                  shape: BoxShape.rectangle,
                                ),
                                child: ElevatedButton(
                                  onPressed: buttonsEnabled
                                      ? () => onButtonPressed(0)
                                      : null,
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty
                                        .resolveWith<Color?>(
                                      (Set<MaterialState> states) {
                                        if (selectedIndex == -1 ||
                                            selectedIndex == 0) {
                                          return Color(
                                              0xFFB21B3C); // Disabled button color
                                        }
                                        return Colors
                                            .grey; // Default button color
                                      },
                                    ),
                                  ),
                                  child: Icon(
                                    Icons.favorite_sharp,
                                    color: Colors.white,
                                    size: 120,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(5, 0, 0, 5),
                              child: Container(
                                width: 400,
                                height: 300,
                                decoration: BoxDecoration(
                                  color: Color(0xFF45A3E5),
                                  borderRadius: BorderRadius.circular(30),
                                  shape: BoxShape.rectangle,
                                ),
                                child: ElevatedButton(
                                  onPressed: buttonsEnabled
                                      ? () => onButtonPressed(1)
                                      : null,
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty
                                        .resolveWith<Color?>(
                                      (Set<MaterialState> states) {
                                        if (selectedIndex == -1 ||
                                            selectedIndex == 1) {
                                          return Color(
                                              0xFF45A3E5); // Disabled button color
                                        }
                                        return Colors
                                            .grey; // Default button color
                                      },
                                    ),
                                  ),
                                  child: Icon(
                                    Icons.waves_sharp,
                                    color: Colors.white,
                                    size: 120,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 5, 5, 0),
                              child: Container(
                                width: 400,
                                height: 300,
                                decoration: BoxDecoration(
                                  color: Color(0xFFFFA602),
                                  borderRadius: BorderRadius.circular(30),
                                  shape: BoxShape.rectangle,
                                ),
                                child: ElevatedButton(
                                  onPressed: buttonsEnabled
                                      ? () => onButtonPressed(2)
                                      : null,
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty
                                        .resolveWith<Color?>(
                                      (Set<MaterialState> states) {
                                        if (selectedIndex == -1 ||
                                            selectedIndex == 2) {
                                          return Color(
                                              0xFFFFA602); // Disabled button color
                                        }
                                        return Colors
                                            .grey; // Default button color
                                      },
                                    ),
                                  ),
                                  child: Icon(
                                    Icons.brightness_1_rounded,
                                    color: Colors.white,
                                    size: 120,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(5, 5, 0, 0),
                              child: Container(
                                width: 400,
                                height: 300,
                                decoration: BoxDecoration(
                                  color: Color(0xFF26890C),
                                  borderRadius: BorderRadius.circular(30),
                                  shape: BoxShape.rectangle,
                                ),
                                child: ElevatedButton(
                                  onPressed: buttonsEnabled
                                      ? () => onButtonPressed(3)
                                      : null,
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty
                                        .resolveWith<Color?>(
                                      (Set<MaterialState> states) {
                                        if (selectedIndex == -1 ||
                                            selectedIndex == 3) {
                                          return Color(
                                              0xFF26890C); // Disabled button color
                                        }
                                        return Colors
                                            .grey; // Default button color
                                      },
                                    ),
                                  ),
                                  child: Icon(
                                    Icons.bedtime_sharp,
                                    color: Colors.white,
                                    size: 120,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              StreamBuilder<int>(
                stream: timeStream,
                builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
                  if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    switch (snapshot.connectionState) {
                      case ConnectionState.none:
                        return Text('Not connected to the stream');
                      case ConnectionState.waiting:
                        return Text('Loading...');
                      case ConnectionState.active:
                        return Text(
                          '${snapshot.data}',
                          style: TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: 64,
                            fontStyle: FontStyle.normal,
                            color: Colors.white,
                          ),
                        );
                      case ConnectionState.done:
                        return Text('Stream has ended');
                    }
                  }
                },
              ),
            ],
          )),
    );
  }
}
