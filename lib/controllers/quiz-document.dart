import 'package:cloud_firestore/cloud_firestore.dart';

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
  static Quiz getInstance({String? document}) {
    if (_instance == null) {
      if (document != null) {
        _instance = Quiz._(document: document);
        _instance!._init();
      }
    }
    return _instance!;
  }

  // Instance initialization
  Future<void> _init() async {
    await loadQuiz(document);
  }

Future<void> loadQuiz(String document) async {
  resetQuiz();
  try {
    final quizDoc =
      await FirebaseFirestore.instance.collection('Quiz').doc(document).get();
    Map<String, dynamic> docData = quizDoc.data() ?? {}; // Handle null data
    title = docData['Title'] ?? '';
    questions = List<String>.from(docData['Questions'] ?? []);
    correctAnswers = List<int>.from(docData['CorrectAnswers'] ?? []);
    List<String> answersList = List<String>.from(docData['Answers'] ?? []);
    answers = List.generate(questions.length,
        (index) => answersList.sublist(index * 4, (index + 1) * 4));
  } catch (e) {
    print('Error loading quiz: $e');
  }
}

  String getQuestion() {
    return questions[currentIndex];
  }

  List<String> getAnswers() {
    return answers[currentIndex];
  }

  void nextQuestion() {
    currentIndex++;
  }

  bool checkAnswer(int answerIndex) {
    if (correctAnswers[currentIndex] == answerIndex) {
      return true;
    } else {
      return false;
    }
  }

  int getCorrectAnswer() {
    return correctAnswers[currentIndex];
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
