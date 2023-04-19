import 'package:flutter/material.dart';
import 'package:scrum/controllers/quiz-time-stream.dart';
import 'package:scrum/screens/host-correct-answer-screen.dart';
import 'package:scrum/controllers/quiz-document.dart';
import 'package:scrum/utils/fire_RTdatabase.dart';

class HostMultipleChoiceWidget extends StatefulWidget {
  const HostMultipleChoiceWidget({
    Key? key,
    required this.quizID,
  }) : super(key: key);

  final String quizID;

  @override
  _HostMultipleChoiceWidgetState createState() =>
      _HostMultipleChoiceWidgetState();
}

class _HostMultipleChoiceWidgetState extends State<HostMultipleChoiceWidget>
    with TickerProviderStateMixin {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  late final QuizTimeStream quizTimeStream;
  late Stream<int> timeStream;

  @override
  void initState() {
    super.initState();

    Quiz quiz = Quiz.getInstance(document: widget.quizID);
    quizTimeStream = QuizTimeStream();
    quizTimeStream.listenToQuizTime(widget.quizID);
    timeStream = quizTimeStream.timeStream;
    quizTimeStream.startTimer(widget.quizID);
    quizTimeStream.isTimeZeroStream.listen((isTimeZero) {
      if (isTimeZero) {
        quizTimeStream.cancelTimer();
        ScrumRTdatabase.setTimer(widget.quizID, 7);
        Navigator.pushReplacement(
            context,
            PageRouteBuilder(
              transitionDuration: Duration.zero,
              reverseTransitionDuration: Duration.zero,
              pageBuilder: (context, animation, secondaryAnimation) {
                return HostCorrectAnswerScreen(
                    quizID: widget.quizID, correctOption: 3);
              },
            ));
      }
    });
  }

  @override
  void dispose() {
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
                                  shape: BoxShape.rectangle,
                                ),
                                child: Row(
                                  children: <Widget>[
                                    Icon(
                                      Icons.favorite_sharp,
                                      color: Colors.white,
                                      size: 60,
                                    ),
                                    Flexible(
                                      child: Text(
                                        "January 1 on the new years day because it was raining outside",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 28,
                                            color: Colors.white),
                                      ),
                                    ),
                                  ],
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
                                  shape: BoxShape.rectangle,
                                ),
                                child: Row(
                                  children: <Widget>[
                                    Icon(
                                      Icons.waves_sharp,
                                      color: Colors.white,
                                      size: 60,
                                    ),
                                    Flexible(
                                      child: Text(
                                        "January 1 on the new years day because it was raining outside",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 28,
                                            color: Colors.white),
                                      ),
                                    ),
                                  ],
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
                                  shape: BoxShape.rectangle,
                                ),
                                child: Row(
                                  children: <Widget>[
                                    Icon(
                                      Icons.brightness_1_rounded,
                                      color: Colors.white,
                                      size: 60,
                                    ),
                                    Flexible(
                                      child: Text(
                                        "January 1 on the new years day because it was raining outside",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 28,
                                            color: Colors.white),
                                      ),
                                    ),
                                  ],
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
                                  shape: BoxShape.rectangle,
                                ),
                                child: Row(
                                  children: <Widget>[
                                    Icon(
                                      Icons.bedtime_sharp,
                                      color: Colors.white,
                                      size: 60,
                                    ),
                                    Flexible(
                                      child: Text(
                                        "January 1 on the new years day because it was raining outside",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 28,
                                            color: Colors.white),
                                      ),
                                    ),
                                  ],
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
