import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:scrum/screens/home-screen.dart';

class MakeQuizScreen extends StatefulWidget {
  final User user;
  const MakeQuizScreen({Key? key, required this.user}) : super(key: key);

  @override
  _MakeQuizScreenState createState() => _MakeQuizScreenState();
}

class _MakeQuizScreenState extends State<MakeQuizScreen> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _unfocusNode = FocusNode();
  final _quizTitleController = TextEditingController();
  final _questionController = TextEditingController();
  final _answer1Controller = TextEditingController();
  final _answer2Controller = TextEditingController();
  final _answer3Controller = TextEditingController();
  final _answer4Controller = TextEditingController();
  late final int correctAnswer;

  final List<String> questions = [];
  final List<String> answers = [];
  final List<int> correctAnswers = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _unfocusNode.dispose();
    super.dispose();
  }

  void _addOrEditQuestionDialog({int? index}) {
    bool editingExistingQuestion = index != null;
    String currentQuestion = '';
    String currentAnswer1 = '';
    String currentAnswer2 = '';
    String currentAnswer3 = '';
    String currentAnswer4 = '';
    int correctAnswer = 0;

    if (editingExistingQuestion) {
      currentQuestion = questions[index];
      currentAnswer1 = answers[index * 4];
      currentAnswer2 = answers[index * 4 + 1];
      currentAnswer3 = answers[index * 4 + 2];
      currentAnswer4 = answers[index * 4 + 3];
      correctAnswer = correctAnswers[index];
    }

    bool _validateFields() {
      if (_questionController.text.isEmpty ||
          _answer1Controller.text.isEmpty ||
          _answer2Controller.text.isEmpty ||
          _answer3Controller.text.isEmpty ||
          _answer4Controller.text.isEmpty) {
        return false;
      }
      return true;
    }

    void _showErrorDialog(String errorMessage) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Error'),
            content: SingleChildScrollView(
              child: Text(errorMessage),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        _questionController.text = currentQuestion;
        _answer1Controller.text = currentAnswer1;
        _answer2Controller.text = currentAnswer2;
        _answer3Controller.text = currentAnswer3;
        _answer4Controller.text = currentAnswer4;
        return AlertDialog(
          title:
              Text(editingExistingQuestion ? 'Edit Question' : 'Add Question'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: _questionController,
                  decoration: InputDecoration(
                    labelText: 'Question',
                    hintText: 'Enter the question here',
                  ),
                  autofocus: true,
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _answer1Controller,
                  decoration: const InputDecoration(
                    labelText: 'Answer 1',
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _answer2Controller,
                  decoration: const InputDecoration(
                    labelText: 'Answer 2',
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _answer3Controller,
                  decoration: const InputDecoration(
                    labelText: 'Answer 3',
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _answer4Controller,
                  decoration: const InputDecoration(
                    labelText: 'Answer 4',
                  ),
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<int>(
                  decoration: const InputDecoration(
                    labelText: 'Correct Answer',
                  ),
                  value: correctAnswer,
                  items: [
                    DropdownMenuItem(
                      value: 0,
                      child: Text('Answer 1'),
                    ),
                    DropdownMenuItem(
                      value: 1,
                      child: Text('Answer 2'),
                    ),
                    DropdownMenuItem(
                      value: 2,
                      child: Text('Answer 3'),
                    ),
                    DropdownMenuItem(
                      value: 3,
                      child: Text('Answer 4'),
                    ),
                  ],
                  onChanged: (value) {
                    setState(() {
                      correctAnswer = value!;
                    });
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('CANCEL'),
            ),
            TextButton(
              onPressed: () {
                if (_validateFields()) {
                  setState(() {
                    if (editingExistingQuestion) {
                      // Update the question and its answers with the new contents
                      questions[index] = _questionController.text;
                      answers[index * 4] = _answer1Controller.text;
                      answers[index * 4 + 1] = _answer2Controller.text;
                      answers[index * 4 + 2] = _answer3Controller.text;
                      answers[index * 4 + 3] = _answer4Controller.text;
                      correctAnswers[index] = correctAnswer;
                    } else {
                      // Add the new question and its answers
                      questions.add(_questionController.text);
                      answers.add(_answer1Controller.text);
                      answers.add(_answer2Controller.text);
                      answers.add(_answer3Controller.text);
                      answers.add(_answer4Controller.text);
                      correctAnswers.add(correctAnswer);
                    }
                    _questionController.clear();
                    _answer1Controller.clear();
                    _answer2Controller.clear();
                    _answer3Controller.clear();
                    _answer4Controller.clear();
                  });
                  Navigator.pop(context);
                } else {
                  _showErrorDialog("All fields are required.");
                }
              },
              child: Text('SAVE'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: const Color(0xFF39D2C0),
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(_unfocusNode),
          child: Align(
            child: Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(20, 20, 20, 20),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.8,
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Container(
                      width: 350,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text('Quiz Title',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 40,
                                fontWeight: FontWeight.bold,
                              )),
                        ],
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.7,
                            height: 75,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                            ),
                            child: TextFormField(
                              controller: _quizTitleController,
                              autofocus: true,
                              obscureText: false,
                              decoration: InputDecoration(
                                  hintText: '[Quiz title...]',
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: Colors.white,
                                      width: 0,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: Color(0x00000000),
                                      width: 0,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: Color(0x00000000),
                                      width: 0,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: Color(0x00000000),
                                      width: 0,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  filled: true,
                                  fillColor: const Color(0xFFEDEDED),
                                  contentPadding:
                                      const EdgeInsetsDirectional.all(10.0)),
                              style: const TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 28,
                                fontWeight: FontWeight.normal,
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(5, 5, 5, 5),
                      child: Container(
                        width: 350,
                        height: 50,
                        decoration: const BoxDecoration(
                            color: Color(0xFF39D2C0),
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        child: ElevatedButton(
                          onPressed: () {
                            _addOrEditQuestionDialog();
                            setState(() {});
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF39D2C0),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 30, vertical: 10),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Text(
                            'Add Question',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              color: Colors.white,
                              fontSize: 40,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                        ),
                        child: ListView.builder(
                          padding: EdgeInsets.zero,
                          scrollDirection: Axis.vertical,
                          itemCount: questions.length,
                          itemBuilder: (context, index) {
                            // Calculate the indices of the answers based on the question index
                            final int answerIndex = index * 4;
                            final List<String> questionAnswers =
                                answers.sublist(answerIndex, answerIndex + 4);
                            // Build the question box
                            return Container(
                              margin: EdgeInsets.symmetric(
                                  vertical: 8.0, horizontal: 40.0),
                              padding: EdgeInsets.all(16.0),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('Question ${index + 1}'),
                                      SizedBox(height: 8.0),
                                      Text(questions[index]),
                                      SizedBox(height: 16.0),
                                      Text('Answer #1: ${questionAnswers[0]}'),
                                      SizedBox(height: 8.0),
                                      Text('Answer #2: ${questionAnswers[1]}'),
                                      SizedBox(height: 8.0),
                                      Text('Answer #3: ${questionAnswers[2]}'),
                                      SizedBox(height: 8.0),
                                      Text('Answer #4: ${questionAnswers[3]}'),
                                      SizedBox(height: 8.0),
                                      Text(
                                          'Correct Answer: Answer #${(correctAnswers[index]) + 1}'),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          _addOrEditQuestionDialog(
                                              index: index);
                                          setState(() {});
                                        },
                                        child: Icon(
                                          Icons.edit,
                                          color: Colors.blue,
                                        ),
                                      ),
                                      SizedBox(width: 16.0),
                                      GestureDetector(
                                        onTap: () {
                                          // Remove the question and its answers from the lists
                                          setState(() {
                                            questions.removeAt(index);
                                            answers.removeRange(
                                                answerIndex, answerIndex + 4);
                                            correctAnswers.removeAt(index);
                                          });
                                        },
                                        child: Icon(
                                          Icons.delete,
                                          color: Colors.red,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
                      child: Container(
                        width: 350,
                        height: 50,
                        decoration: const BoxDecoration(
                            color: Color(0xFF39D2C0),
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        child: ElevatedButton(
                          onPressed: () async {
                            // Get the quiz data from the text controllers
                            final quizTitle = _quizTitleController.text;
                            final questionsList =
                                questions.map((q) => q).toList();
                            final answersList = answers.map((a) => a).toList();
                            final correctAnswersList =
                                correctAnswers.map((a) => a).toList();

                            // Save the quiz data to Firebase
                            final quizRef = FirebaseFirestore.instance
                                .collection('Quiz')
                                .doc();
                            await quizRef.set({
                              'Title': quizTitle,
                              'Questions': questionsList,
                              'Answers': answersList,
                              'CorrectAnswers': correctAnswersList,
                            });

                            // Update the user's document to reference the newly created quiz
                            final userRef = FirebaseFirestore.instance
                                .collection('User')
                                .doc(widget.user.uid);
                            await userRef.update({
                              'Quizzes': FieldValue.arrayUnion([quizRef]),
                            });

                            // Navigate back to the previous screen
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (context) =>
                                    ProfilePage(user: widget.user),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFFF3355),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 30, vertical: 10),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Text(
                            'Save and Exit',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              color: Colors.white,
                              fontSize: 40,
                            ),
                          ),
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
