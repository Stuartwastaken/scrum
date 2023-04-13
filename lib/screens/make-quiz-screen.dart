import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MakeQuizScreen extends StatefulWidget {
  const MakeQuizScreen({Key? key}) : super(key: key);

  @override
  _MakeQuizScreenState createState() => _MakeQuizScreenState();
}

class _MakeQuizScreenState extends State<MakeQuizScreen> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _unfocusNode = FocusNode();
  final _quizTitleController = TextEditingController();
  final _questionController = TextEditingController();
  final _correctAnswerController = TextEditingController();
  final _incorrectAnswer1Controller = TextEditingController();
  final _incorrectAnswer2Controller = TextEditingController();
  final _incorrectAnswer3Controller = TextEditingController();

  final List<String> questions = [];
  final List<String> answers = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _unfocusNode.dispose();
    super.dispose();
  }

  void _addQuestionDialog() {
    bool _validateFields() {
      if (_questionController.text.isEmpty ||
          _correctAnswerController.text.isEmpty ||
          _incorrectAnswer1Controller.text.isEmpty ||
          _incorrectAnswer2Controller.text.isEmpty ||
          _incorrectAnswer3Controller.text.isEmpty) {
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
        return AlertDialog(
          title: const Text('Add Question'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: _questionController,
                  decoration: const InputDecoration(
                    labelText: 'Question',
                  ),
                ),
                TextField(
                  controller: _correctAnswerController,
                  decoration: const InputDecoration(
                    labelText: 'Correct Answer',
                  ),
                ),
                TextField(
                  controller: _incorrectAnswer1Controller,
                  decoration: const InputDecoration(
                    labelText: 'Incorrect Answer 1',
                  ),
                ),
                TextField(
                  controller: _incorrectAnswer2Controller,
                  decoration: const InputDecoration(
                    labelText: 'Incorrect Answer 2',
                  ),
                ),
                TextField(
                  controller: _incorrectAnswer3Controller,
                  decoration: const InputDecoration(
                    labelText: 'Incorrect Answer 3',
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                if (_validateFields()) {
                  setState(() {
                    questions.add(_questionController.text);
                    answers.add(_correctAnswerController.text);
                    answers.add(_incorrectAnswer1Controller.text);
                    answers.add(_incorrectAnswer2Controller.text);
                    answers.add(_incorrectAnswer3Controller.text);
                    _questionController.clear();
                    _correctAnswerController.clear();
                    _incorrectAnswer1Controller.clear();
                    _incorrectAnswer2Controller.clear();
                    _incorrectAnswer3Controller.clear();
                  });
                  Navigator.pop(context);
                } else {
                  _showErrorDialog(
                      'Please fill out all fields before confirming.');
                }
              },
              child: const Text('Confirm'),
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
                                  hintText: '[A wacky and creative title...]',
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
                            _addQuestionDialog();
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
                                      Text(
                                          'Correct Answer: ${questionAnswers[0]}'),
                                      SizedBox(height: 8.0),
                                      Text(
                                          'Incorrect Answer #1: ${questionAnswers[1]}'),
                                      SizedBox(height: 8.0),
                                      Text(
                                          'Incorrect Answer #2: ${questionAnswers[2]}'),
                                      SizedBox(height: 8.0),
                                      Text(
                                          'Incorrect Answer #3: ${questionAnswers[3]}'),
                                    ],
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      // Remove the question and its answers from the lists
                                      setState(() {
                                        questions.removeAt(index);
                                        answers.removeRange(
                                            answerIndex, answerIndex + 4);
                                      });
                                    },
                                    child: Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                    ),
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
                          onPressed: () {},
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
