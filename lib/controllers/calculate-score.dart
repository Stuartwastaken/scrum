import 'quiz-time-stream.dart';
import 'package:scrum/utils/fire_RTdatabase.dart';

class CalculateScore {
  static Future<int> calculateAddValue(String quizID) async {
    // Get the remaining time from the database
    int? remainingTime = await ScrumRTdatabase.getTime(quizID);

    // Do your calculations using remainingTime as an int value
    int score = remainingTime! * 30 + 100;

    return score;
  }
}
