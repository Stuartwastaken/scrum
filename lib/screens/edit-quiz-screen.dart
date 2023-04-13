import 'package:flutter/material.dart';

class EditQuizScreen extends StatefulWidget {
  const EditQuizScreen({Key? key}) : super(key: key);

  @override
  _EditQuizScreenState createState() => _EditQuizScreenState();
}

class _EditQuizScreenState extends State<EditQuizScreen> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _unfocusNode = FocusNode();
  final _quizTitleController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _unfocusNode.dispose();
    super.dispose();
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
                          onPressed: () {},
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
                        child: ListView(
                          padding: EdgeInsets.zero,
                          scrollDirection: Axis.vertical,
                          children: [],
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
