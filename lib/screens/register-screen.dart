import 'package:flutter/material.dart';
import 'package:scrum/screens/login-screen.dart';
import 'game-pin-screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:scrum/screens/home-screen.dart';
import 'package:scrum/utils/fire_auth.dart';
import 'package:scrum/utils/validator.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _registerFormKey = GlobalKey<FormState>();

  final _nameTextController = TextEditingController();
  final _emailTextController = TextEditingController();
  final _passwordTextController = TextEditingController();

  final _focusName = FocusNode();
  final _focusEmail = FocusNode();
  final _focusPassword = FocusNode();

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
      onTap: () {
        _focusName.unfocus();
        _focusEmail.unfocus();
        _focusPassword.unfocus();
      },
      child: Scaffold(
        body: FutureBuilder(
            future: _initializeFirebase(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                          "../../assets/images/shapes-background.jpg"),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      //column 1
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          //title
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "SCRUM",
                                style: TextStyle(
                                  fontFamily: "Primary Family",
                                  fontSize: 46,
                                ),
                              ),
                            ],
                          ),
                          //back button
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(24, 10, 24, 0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
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
                                      elevation: MaterialStateProperty
                                          .resolveWith<double>((states) {
                                        return 4.0; // Set elevation to 4.0 by default
                                      }),
                                      backgroundColor: MaterialStateProperty
                                          .resolveWith<Color>((states) {
                                        if (states
                                            .contains(MaterialState.hovered)) {
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
                      //column 2
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            //white background
                            Align(
                              alignment: AlignmentDirectional(-0.165, 0),
                              child: Material(
                                color: Colors.transparent,
                                elevation: 8,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Container(
                                  width: 475,
                                  height: 625,
                                  constraints: BoxConstraints(
                                    maxHeight: double.infinity,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(5),
                                    shape: BoxShape.rectangle,
                                    border: Border.all(
                                      color: Color(0xFF3C3939),
                                    ),
                                  ),
                                  //form column
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      //reigster text
                                      Padding(
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
                                              child: Align(
                                                alignment:
                                                    AlignmentDirectional(0, 0),
                                                child: Text(
                                                  "Register with your email",
                                                  textAlign: TextAlign.start,
                                                  style: TextStyle(
                                                    fontFamily: "Poppins",
                                                    color: Colors.black,
                                                    fontSize: 24,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),

                                      Form(
                                        key: _registerFormKey,
                                        child: Column(
                                          children: <Widget>[
                                            //username field
                                            Container(
                                              width: 390,
                                              height: 61.6,
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                              ),
                                              child: Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(0, 10, 0, 0),
                                                child: TextFormField(
                                                  controller:
                                                      _nameTextController,
                                                  focusNode: _focusName,
                                                  validator: (value) =>
                                                      Validator.validateName(
                                                    name: value,
                                                  ),
                                                  decoration: InputDecoration(
                                                    hintText: "Name",
                                                    errorBorder:
                                                        UnderlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              6.0),
                                                      borderSide: BorderSide(
                                                        color: Colors.red,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            //email field
                                            Container(
                                              width: 390,
                                              height: 61.6,
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                              ),
                                              child: Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(0, 10, 0, 0),
                                                child: TextFormField(
                                                  controller:
                                                      _emailTextController,
                                                  focusNode: _focusEmail,
                                                  validator: (value) =>
                                                      Validator.validateEmail(
                                                    email: value,
                                                  ),
                                                  decoration: InputDecoration(
                                                    hintText: "Email",
                                                    errorBorder:
                                                        UnderlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              6.0),
                                                      borderSide: BorderSide(
                                                        color: Colors.red,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            //password field
                                            Container(
                                              width: 390,
                                              height: 61.6,
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                              ),
                                              child: Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(0, 10, 0, 0),
                                                child: TextFormField(
                                                  controller:
                                                      _passwordTextController,
                                                  focusNode: _focusPassword,
                                                  obscureText: true,
                                                  validator: (value) =>
                                                      Validator
                                                          .validatePassword(
                                                    password: value,
                                                  ),
                                                  decoration: InputDecoration(
                                                    hintText: "Password",
                                                    errorBorder:
                                                        UnderlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              6.0),
                                                      borderSide: BorderSide(
                                                        color: Colors.red,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            //login button
                                            SizedBox(height: 24.0),
                                            _isProcessing
                                                ? CircularProgressIndicator()
                                                : Row(
                                                    children: [
                                                      Expanded(
                                                        child: ElevatedButton(
                                                          onPressed: () async {
                                                            setState(() {
                                                              _isProcessing =
                                                                  true;
                                                            });

                                                            if (_registerFormKey
                                                                .currentState!
                                                                .validate()) {
                                                              User? user =
                                                                  await FireAuth
                                                                      .registerUsingEmailPassword(
                                                                name:
                                                                    _nameTextController
                                                                        .text,
                                                                email:
                                                                    _emailTextController
                                                                        .text,
                                                                password:
                                                                    _passwordTextController
                                                                        .text,
                                                              );

                                                              setState(() {
                                                                _isProcessing =
                                                                    false;
                                                              });

                                                              if (user !=
                                                                  null) {
                                                                Navigator.of(
                                                                        context)
                                                                    .pushAndRemoveUntil(
                                                                  MaterialPageRoute(
                                                                    builder: (context) =>
                                                                        ProfilePage(
                                                                            user:
                                                                                user),
                                                                  ),
                                                                  ModalRoute
                                                                      .withName(
                                                                          '/'),
                                                                );
                                                              }
                                                            }
                                                          },
                                                          child: Text(
                                                            'Sign up',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0, 0, 0, 10),
                                      ),
                                      Divider(
                                          thickness: 5,
                                          indent: 55,
                                          endIndent: 55,
                                          color: Colors.black),

                                      Align(
                                        alignment: AlignmentDirectional(0, 0),
                                        child: Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0, 0, 0, 0),
                                          child: Container(
                                            width: 351,
                                            height: 44,
                                            child: Stack(
                                              children: [
                                                Align(
                                                  alignment:
                                                      AlignmentDirectional(
                                                          0, 0),
                                                ),
                                                Align(
                                                  alignment:
                                                      AlignmentDirectional(
                                                          -0.83, 0),
                                                  child: Container(
                                                    width: 22,
                                                    height: 22,
                                                    clipBehavior:
                                                        Clip.antiAlias,
                                                    decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      Align(
                                        alignment: AlignmentDirectional(0, 0),
                                        child: Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0, 0, 0, 0),
                                          child: Container(
                                            width: 351,
                                            height: 20,
                                            child: Stack(
                                              children: [
                                                Align(
                                                  alignment:
                                                      AlignmentDirectional(
                                                          0, 0),
                                                ),
                                                Align(
                                                  alignment:
                                                      AlignmentDirectional(
                                                          -0.83, 0),
                                                  child: Container(
                                                    width: 22,
                                                    height: 22,
                                                    clipBehavior:
                                                        Clip.antiAlias,
                                                    decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            24, 10, 24, 10),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Already have an account? ",
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            MouseRegion(
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
                                                  'Log in',
                                                  style: TextStyle(
                                                    color: Colors.blue,
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
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }
              return Center(
                child: CircularProgressIndicator(),
              );
            }),
      ),
    );
  }
}
