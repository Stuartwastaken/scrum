import 'package:flutter/material.dart';
import 'package:scrum/controllers/quiz-time-stream.dart';
import 'package:scrum/utils/fire_RTdatabase.dart';

class QuizListener {
  static void listen(
      QuizTimeStream quizTime, BuildContext context, Widget navigateToWidget, [String? quizID,
      int? timer]) {
    quizTime.timeStream.listen((time) {
      // Check if time is 0
      if (time == 0) {
        //if timer passed as parameter to next widget, reset timer in RT database
        if (timer != null && quizID != null) {
          ScrumRTdatabase.setTimer(quizID, timer);
        }
        // Navigate to a different page
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => navigateToWidget),
        );
      }
    });
  }
}
