import 'package:flutter/material.dart';
import 'package:scrum/controllers/calculate-score.dart';
import 'package:scrum/controllers/quiz-time-stream.dart';
import 'package:scrum/screens/post-question-screen.dart';

class MultipleChoiceWidget extends StatefulWidget {
  MultipleChoiceWidget({
    Key? key,
    required this.quizID,
    required this.uid,
  }) : super(key: key);

  final String quizID;
  final String uid;
  final bool isCorrect = false;
  late final Future<int> pointsGained;

  @override
  MultipleChoiceWidgetState createState() => MultipleChoiceWidgetState();
}

class MultipleChoiceWidgetState extends State<MultipleChoiceWidget>
    with TickerProviderStateMixin {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  late final QuizTimeStream quizTimeStream;
  late Stream<int> timeStream;
  bool buttonsEnabled = true;
  int selectedIndex = 0;

  void onButtonPressed(int index) {
    setState(() {
      selectedIndex = index;
      buttonsEnabled = false;
    });
  }

  void disableButtons() {
    setState(() {
      buttonsEnabled = false;
    });
  }

  @override
  void initState() {
    super.initState();

    quizTimeStream = QuizTimeStream();
    quizTimeStream.listenToQuizTime(widget.quizID);
    timeStream = quizTimeStream.timeStream;
    quizTimeStream.isTimeZeroStream.listen((isTimeZero) {
      if (isTimeZero) {
        Navigator.pushReplacement(
          context, 
          PageRouteBuilder(
            transitionDuration: const Duration(milliseconds: 100),
            reverseTransitionDuration: Duration.zero,
            pageBuilder: (context, animation, secondaryAnimation) {
              return PostQuestionScreenWidget(quizID: widget.quizID, uid: widget.uid, isCorrect: widget.isCorrect, pointsGained: widget.pointsGained as int);
            },
          )
        );
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
                child: Text(
                  'When did Lebron meet Mia Khalifa?',
                  style: TextStyle(
                    fontFamily: 'Lexend Deca',
                    color: Colors.white,
                    fontSize: 55,
                    fontWeight: FontWeight.bold,
                  ),
                ),
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
                                      ? () => onButtonPressed(1)
                                      : null,
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty
                                        .resolveWith<Color?>(
                                      (Set<MaterialState> states) {
                                        if (selectedIndex == 0 ||
                                            selectedIndex == 1) {
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
                                      ? () => onButtonPressed(2)
                                      : null,
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty
                                        .resolveWith<Color?>(
                                      (Set<MaterialState> states) {
                                        if (selectedIndex == 0 ||
                                            selectedIndex == 2) {
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
                                      ? () => onButtonPressed(3)
                                      : null,
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty
                                        .resolveWith<Color?>(
                                      (Set<MaterialState> states) {
                                        if (selectedIndex == 0 ||
                                            selectedIndex == 3) {
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
                                      ? () => onButtonPressed(4)
                                      : null,
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty
                                        .resolveWith<Color?>(
                                      (Set<MaterialState> states) {
                                        if (selectedIndex == 0 ||
                                            selectedIndex == 4) {
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
