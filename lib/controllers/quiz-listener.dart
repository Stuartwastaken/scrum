import 'package:flutter/material.dart';
import 'package:scrum/controllers/quiz-time-stream.dart';

class QuizListener {
  static void listen(
      QuizTimeStream quizTime, BuildContext context, Widget navigateToWidget) {
    quizTime.timeStream.listen((time) {
      // Check if time is 0
      if (time == 0) {
        // Navigate to a different page
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => navigateToWidget),
        );
      }
    });
  }
}
