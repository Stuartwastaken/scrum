import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:scrum/screens/game-pin-screen.dart';
import 'package:scrum/screens/home-screen.dart';
import 'package:scrum/screens/register-screen.dart';
import 'forgot-password-screen.dart';
import 'package:scrum/utils/fire_auth.dart';
import 'package:scrum/utils/validator.dart';
import 'package:scrum/widgets/underlined-text-form-field.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late final TextEditingController username;
  late final TextEditingController email;
  late final TextEditingController password;
  late final TextEditingController confirmPassword;

  void initState() {
    username = TextEditingController();
    email = TextEditingController();
    password = TextEditingController();
    confirmPassword = TextEditingController();
    super.initState();
  }

  final _formKey = GlobalKey<FormState>();

  bool _isProcessing = false;

  Future<FirebaseApp> _initializeFirebase() async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();

    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => ProfilePage(
            user: user,
          ),
        ),
      );
    }

    return firebaseApp;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Scaffold(
        body: FutureBuilder(
          future: _initializeFirebase(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return Scaffold(
                body: SafeArea(
                  child: GestureDetector(
                    onTap: () {},
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 0, 0, 20),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    //login text
                                    Text(
                                      'Log In',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 80,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              //form elements
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    20, 20, 20, 20),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    //email field
                                    Expanded(
                                      child: underlinedTextFormField(
                                          controller: email,
                                          labelText: "Email",
                                          isObscure: false),
                                    ),
                                  ],
                                ),
                              ),
                              //password field
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    20, 20, 20, 20),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: underlinedTextFormField(
                                          controller: password,
                                          labelText: "Password",
                                          isObscure: true),
                                    ),
                                  ],
                                ),
                              ),
                              //reset password text
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    20, 20, 20, 20),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  //crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Flexible(
                                      child: Text(
                                        'Forgot Password? ',
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: 24,
                                        ),
                                      ),
                                    ),
                                    MouseRegion(
                                      cursor: SystemMouseCursors.click,
                                      child: GestureDetector(
                                        onTap: () {
                                          Navigator.pushReplacement(
                                            context,
                                            PageRouteBuilder(
                                              transitionDuration: Duration.zero,
                                              pageBuilder: (context, animation,
                                                      secondaryAnimation) =>
                                                  ForgotPasswordWidget(),
                                            ),
                                          );
                                        },
                                        child: Flexible(
                                          child: Text(
                                            'Reset your password',
                                            style: TextStyle(
                                              color: Color(0xFF004070),
                                              fontFamily: 'Poppins',
                                              fontSize: 24,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              //login button
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    20, 20, 20, 20),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Flexible(
                                      child: SizedBox(
                                        width: 300,
                                        height: 70,
                                        child: GestureDetector(
                                          onTap: () async {
                                            User? user = await FireAuth
                                                .signInUsingEmailPassword(
                                              email: email.text,
                                              password: password.text,
                                            );

                                            if (user != null) {
                                              Navigator.of(context)
                                                  .pushReplacement(
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      ProfilePage(user: user),
                                                ),
                                              );
                                            }
                                          },
                                          child: TextButton(
                                            onPressed: null,
                                            style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStateProperty.all<
                                                      Color>(Colors.black),
                                              padding: MaterialStateProperty
                                                  .all<EdgeInsets>(
                                                EdgeInsets.all(25.0),
                                              ),
                                              shape: MaterialStateProperty.all<
                                                  RoundedRectangleBorder>(
                                                RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          50.0),
                                                  side: BorderSide(
                                                      color: Colors.black,
                                                      width: 4.0),
                                                ),
                                              ),
                                              foregroundColor:
                                                  MaterialStateProperty.all<
                                                      Color>(Colors.black),
                                            ),
                                            child: Text(
                                              "Log in ",
                                              style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontFamily: 'Poppins',
                                                color: Colors.white,
                                                fontSize: 24,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              //register account text
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    20, 20, 20, 20),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Flexible(
                                      child: Text(
                                        'Don\'t have an account? ',
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: 24,
                                        ),
                                      ),
                                    ),
                                    MouseRegion(
                                      cursor: SystemMouseCursors.click,
                                      child: GestureDetector(
                                        onTap: () {
                                          Navigator.pushReplacement(
                                            context,
                                            PageRouteBuilder(
                                              transitionDuration: Duration.zero,
                                              pageBuilder: (context, animation,
                                                      secondaryAnimation) =>
                                                  RegisterScreen(),
                                            ),
                                          );
                                        },
                                        child: Text(
                                          'Sign Up',
                                          style: TextStyle(
                                            color: Color(0xFF004070),
                                            fontFamily: 'Poppins',
                                            fontSize: 24,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.7,
                          height: MediaQuery.of(context).size.height * 1,
                          constraints: BoxConstraints(
                            maxWidth: MediaQuery.of(context).size.width * 0.7,
                            maxHeight: MediaQuery.of(context).size.height * 1,
                          ),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              stops: [
                                0.0,
                                0.35,
                                1.0
                              ], // set stops for the gradient
                              colors: [
                                Color.fromARGB(255, 161, 15, 223),
                                Color.fromARGB(255, 251, 153, 42),
                                Color.fromARGB(255, 63, 3, 192),
                              ],
                            ),
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(90),
                              bottomRight: Radius.circular(0),
                              topLeft: Radius.circular(90),
                              topRight: Radius.circular(0),
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      200, 0, 200, 0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.bar_chart,
                                            color: Colors.white,
                                            size: 130,
                                          ),
                                        ],
                                      ),
                                      //scrum title
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0, 0, 0, 20),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              'SCRUM',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 80,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      //welcome back text
                                      Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Welcome Back',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 40,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),
                                      //lets pick up text
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            10, 10, 0, 0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Flexible(
                                              child: Text(
                                                'Let\'s pick up where we left off.',
                                                textAlign: TextAlign.end,
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 30,
                                                  letterSpacing: 1.5,
                                                  fontWeight: FontWeight.normal,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      //back button
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0, 10, 0, 0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            MouseRegion(
                                              cursor: SystemMouseCursors.click,
                                              child: GestureDetector(
                                                onTap: () {
                                                  Navigator.pushReplacement(
                                                    context,
                                                    PageRouteBuilder(
                                                      transitionDuration:
                                                          Duration.zero,
                                                      pageBuilder: (context,
                                                              animation,
                                                              secondaryAnimation) =>
                                                          GamePinScreen(),
                                                    ),
                                                  );
                                                },
                                                child: Flexible(
                                                  child: Text(
                                                    'Back To Game Pin',
                                                    style: TextStyle(
                                                      decoration: TextDecoration
                                                          .underline,
                                                      color: Colors.white,
                                                      fontSize: 30,
                                                      letterSpacing: 1.5,
                                                      fontWeight:
                                                          FontWeight.normal,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }

            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}
