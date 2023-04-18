import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Quiz {
  late List<String> questions = [];
  late List<List<String>> answers = [];
  late List<int> correctAnswers = [];
  late String title;
  int currentIndex = 0;
  String document;

  // Private constructor
  Quiz._({required this.document});

  // Singleton instance
  static Quiz? _instance;

  // Public method to access the singleton instance
  static Quiz getInstance({required String document}) {
    if (_instance == null) {
      _instance = Quiz._(document: document);
      _instance!._init();
    }
    return _instance!;
  }

  // Instance initialization
  Future<void> _init() async {
    await loadQuiz(document);
  }

  Future<void> loadQuiz(String document) async {
    resetQuiz();

    final quizDoc =
        await FirebaseFirestore.instance.collection('Quiz').doc(document).get();

    title = quizDoc.data()?['Title'] ?? '';
    questions = List<String>.from(quizDoc.data()?['Questions'] ?? []);
    correctAnswers = List<int>.from(quizDoc.data()?['CorrectAnswers'] ?? []);
    List<String> answersList =
        List<String>.from(quizDoc.data()?['Answers'] ?? []);
    answers = List.generate(questions.length,
        (index) => answersList.sublist(index * 4, (index + 1) * 4));
  }

  String nextQuestion() {
    String currentQuestion = questions[currentIndex];
    currentIndex++;
    return currentQuestion;
  }

  bool checkAnswer(int answerIndex) {
    if (correctAnswers[currentIndex] == answerIndex) {
      return true;
    } else {
      return false;
    }
  }

  List<String> get currentAnswers => answers[currentIndex];

  void resetQuiz() {
    currentIndex = 0;
  }

  bool isQuizEmpty() {
    if (currentIndex == questions.length - 1) {
      return true;
    } else {
      return false;
    }
  }
}
