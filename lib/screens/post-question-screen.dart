import 'package:flutter/material.dart';
import 'package:scrum/controllers/quiz-stream.dart';
import 'package:scrum/controllers/screen-navigator.dart';
import 'package:scrum/screens/leaderboard-screen.dart';
import 'package:scrum/screens/player-end-game-screen.dart';
import 'package:scrum/utils/fire_RTdatabase.dart';
import 'package:scrum/controllers/quiz-document.dart';

class PostQuestionScreenWidget extends StatefulWidget {
  final String quizID;
  final String uid;
  final bool isCorrect;
  final int pointsGained;
  const PostQuestionScreenWidget(
      {Key? key,
      required this.quizID,
      required this.uid,
      required this.isCorrect,
      required this.pointsGained})
      : super(key: key);

  @override
  PostQuestionScreenWidgetState createState() =>
      PostQuestionScreenWidgetState();
}

String getPlayerStatus(
    List<MapEntry<String, dynamic>> sortedEntries, String uid) {
  int index = -1;
  for (int i = 0; i < sortedEntries.length; i++) {
    MapEntry<String, dynamic> currentEntry = sortedEntries[i];
    if (currentEntry.key == uid) {
      index = i;
      break;
    }
  }
  //user uid not found. Fail gracefully.
  if (index == -1) {
    return "Better luck next time.";
  }
  //user is in first place
  if (index == 0) {
    return "You're in 1st place! Way to go Scrum Master!";
  } else {
    int competitorScore = sortedEntries[index - 1].value['score'];
    String competitor = sortedEntries[index - 1].value['nickname'];
    int thisPlayerScore = sortedEntries[index].value['score'];
    String scoreDifference = (competitorScore - thisPlayerScore).toString();
    String position = (index + 1).toString();
    return "Position: $position. You are $scoreDifference points behind $competitor";
  }
}

class PostQuestionScreenWidgetState extends State<PostQuestionScreenWidget> {
  final _unfocusNode = FocusNode();
  late final QuizStream quizTimeStream;
  late final Stream<int> timeStream;

  @override
  void initState() {
    super.initState();
    Quiz quiz = Quiz.getInstance(document: widget.quizID);
    quizTimeStream = QuizStream();
    quizTimeStream.listenToQuizTime(widget.quizID);
    timeStream = quizTimeStream.timeStream;
    quizTimeStream.isTimeZeroStream.listen((isTimeZero) {
      if (isTimeZero) {
        if (quiz.isQuizEmpty() == false) {
          ScreenNavigator.navigate(context,
              LeaderboardScreen(quizID: widget.quizID, uid: widget.uid));
        } else {
          ScreenNavigator.navigate(
              context, PlayerEndScreen(quizID: widget.quizID, uid: widget.uid));
        }
      }
    });
  }

  @override
  void dispose() {
    quizTimeStream.dispose();
    _unfocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.isCorrect ? Color(0xFF66BF39) : Color(0xFFFF3355),
      body: FutureBuilder<Map<String, dynamic>>(
          future: ScrumRTdatabase.getUsersAndScores(widget.quizID),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              Map<String, dynamic> usersAndScores = snapshot.data!;
              Map<String, dynamic> usersandscoresSorted =
                  ScrumRTdatabase.sort(usersAndScores);
              List<MapEntry<String, dynamic>> sortedEntries =
                  usersandscoresSorted.entries.toList();
              String playerStatus = getPlayerStatus(sortedEntries, widget.uid);
              return buildPostQuestionScreen(playerStatus);
            } else if (snapshot.hasError) {
              return Center(child: Text("Error:  ${snapshot.error}"));
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }),
    );
  }

  Widget buildPostQuestionScreen(String playerStatus) {
    final points = widget.pointsGained.toString();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: widget.isCorrect ? Color(0xFF66BF39) : Color(0xFFFF3355),
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(_unfocusNode),
          child: Align(
            alignment: AlignmentDirectional(0, 0),
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(20, 20, 20, 20),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      widget.isCorrect ? "Correct!" : "Incorrect :(",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        color: Colors.white,
                        fontSize: 80,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Icon(
                      widget.isCorrect ? Icons.check : Icons.close,
                      color: Colors.white,
                      size: 200,
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                      child: Container(
                          width: MediaQuery.of(context).size.width * 0.5,
                          height: MediaQuery.of(context).size.height * 0.2,
                          decoration: BoxDecoration(
                            color: widget.isCorrect
                                ? Color(0xFF26890C)
                                : Color(0xFFE21B3C),
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 4,
                                color: Color(0x33000000),
                                offset: Offset(0, 2),
                              )
                            ],
                            borderRadius: BorderRadius.circular(20),
                            shape: BoxShape.rectangle,
                          ),
                          alignment: AlignmentDirectional(0, 0),
                          child: Text(
                            '+ $points pts',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              color: Colors.white,
                              fontSize: 40,
                            ),
                          )),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                      child: Text(
                        playerStatus,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          color: Colors.white,
                          fontSize: 45,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
