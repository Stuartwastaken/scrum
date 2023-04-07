import 'package:flutter/material.dart';
import 'package:scrum/screens/login-screen.dart';
import 'package:scrum/screens/game-pin-screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cool_alert/cool_alert.dart';

class ForgotPasswordWidget extends StatefulWidget {
  const ForgotPasswordWidget({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordWidget> createState() => _ForgotPasswordWidgetState();
}

class _ForgotPasswordWidgetState extends State<ForgotPasswordWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _unfocusNode = FocusNode();
  late final GlobalKey<FormFieldState> textFormFieldKey;
  late final TextEditingController emailController;
  bool emailExists = false;

  @override
  void initState() {
    textFormFieldKey = GlobalKey<FormFieldState>();
    emailController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _unfocusNode.dispose();
    emailController.dispose();
    super.dispose();
  }

  Future<void> checkEmailInUse(String emailAddress) async {
    if (emailAddress.isNotEmpty) {
      await FirebaseFirestore.instance
          .collection("User")
          .where("email", isEqualTo: emailAddress)
          .get()
          .then((value) {
        setState(() {
          emailExists = value.size > 0;
        });
      });
    } else {
      setState(() {
        emailExists = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(_unfocusNode),
          child: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromARGB(255, 147, 119, 221),
                  Color.fromARGB(255, 243, 178, 228)
                ],
                stops: [0, 1],
                begin: AlignmentDirectional(0, -1),
                end: AlignmentDirectional(0, 1),
              ),
              shape: BoxShape.rectangle,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
                        child: Text('Title')),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          SizedBox(
                            height: 45,
                            child: ElevatedButton.icon(
                              onPressed: () {
                                Navigator.pushReplacement(
                                  context,
                                  PageRouteBuilder(
                                    transitionDuration: Duration
                                        .zero, // Set transition duration to zero to remove animation
                                    pageBuilder: (context, animation,
                                            secondaryAnimation) =>
                                        GamePinScreen(),
                                  ),
                                );
                              },
                              icon: Icon(
                                IconData(0xe093,
                                    fontFamily: 'MaterialIcons',
                                    matchTextDirection: true),
                                color: Colors.black,
                              ),
                              style: ButtonStyle(
                                //primary: Colors.white,
                                elevation:
                                    MaterialStateProperty.resolveWith<double>(
                                        (states) {
                                  return 4.0; // Set elevation to 4.0 by default
                                }),
                                backgroundColor:
                                    MaterialStateProperty.resolveWith<Color>(
                                        (states) {
                                  if (states.contains(MaterialState.hovered)) {
                                    return Colors
                                        .grey; // Set background color to black when hovered
                                  }
                                  return Colors
                                      .white; // Set background color to orange by default
                                }),
                              ),
                              label: Text(
                                "Back",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: "Primary Family",
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(top: 50),
                    child: ListView(
                      children: [
                        Align(
                          alignment: AlignmentDirectional(0, 0),
                          child: Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 0, 150, 200),
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.375,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    blurRadius: 5,
                                    color: Color(0x33000000),
                                    offset: Offset(0, 2),
                                  )
                                ],
                                borderRadius: BorderRadius.circular(8),
                                shape: BoxShape.rectangle,
                                border: Border.all(color: Colors.white),
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        20, 20, 20, 20),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Align(
                                          child: Text(
                                            'Reset Your Password',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Expanded(
                                          child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            24, 20, 24, 20),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Expanded(
                                              child: TextFormField(
                                                key: textFormFieldKey,
                                                autofocus: true,
                                                controller: emailController,
                                                obscureText: false,
                                                decoration: InputDecoration(
                                                  labelText: 'Enter email...',
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: Color(0xFF4A4646),
                                                      width: 1,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                  ),
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: Color(0xFF4A4646),
                                                      width: 1,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                  ),
                                                  errorBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: Color(0xFFFF0000),
                                                      width: 1,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                  ),
                                                  focusedErrorBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: Color(0xFFFF0000),
                                                      width: 1,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                  ),
                                                  filled: true,
                                                  fillColor: Colors.white,
                                                ),
                                                keyboardType:
                                                    TextInputType.emailAddress,
                                                validator: (value) {
                                                  if (value == null ||
                                                      value.isEmpty) {
                                                    return "Error: Please enter an email";
                                                  } else if (!emailExists) {
                                                    return "Error: Email does not exist";
                                                  } else {
                                                    return null;
                                                  }
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                      )),
                                    ],
                                  ),
                                  Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          10, 10, 10, 10),
                                      child: ElevatedButton(
                                          onPressed: () async {
                                            await checkEmailInUse(
                                                emailController.text);
                                            if (textFormFieldKey.currentState!
                                                .validate()) {
                                              await CoolAlert.show(
                                                  context: context,
                                                  type: CoolAlertType.success,
                                                  text:
                                                      "Reset link sent! Returning to Login",
                                                  autoCloseDuration: null,
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      .5);
                                              await Navigator.push(
                                                context,
                                                PageRouteBuilder(
                                                  transitionDuration:
                                                      Duration.zero,
                                                  pageBuilder: (context,
                                                          animation,
                                                          secondaryAnimation) =>
                                                      LoginScreen(),
                                                ),
                                              );
                                            }
                                          },
                                          child: Text("Send reset link"))),
                                  Divider(thickness: 1),
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Align(
                                        alignment: AlignmentDirectional(0, 0),
                                        child: Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  20, 20, 20, 20),
                                          child: MouseRegion(
                                            cursor: SystemMouseCursors.click,
                                            child: GestureDetector(
                                              onTap: () {
                                                Navigator.pushReplacement(
                                                  context,
                                                  PageRouteBuilder(
                                                    transitionDuration: Duration
                                                        .zero, // Set transition duration to zero to remove animation
                                                    pageBuilder: (context,
                                                            animation,
                                                            secondaryAnimation) =>
                                                        LoginScreen(),
                                                  ),
                                                );
                                              },
                                              child: Text(
                                                'Return to log in',
                                                style: TextStyle(
                                                  color: Colors.blue,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
