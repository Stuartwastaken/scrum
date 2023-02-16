import 'package:flutter/material.dart';
import 'text-field.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const Register(),
    );
  }
}

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  late final TextEditingController username;
  late final TextEditingController email;
  late final TextEditingController password;
  late final TextEditingController confirmPassword;

  @override
  void initState() {
    username = TextEditingController();
    email = TextEditingController();
    password = TextEditingController();
    confirmPassword = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
                      "TITLE",
                      style: TextStyle(
                        fontFamily: "Primary Family",
                        fontSize: 46,
                      ),
                    ),
                  ],
                ),
                //back button
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(24, 10, 24, 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 45,
                        child: ElevatedButton.icon(
                          onPressed: () {},
                          icon: Icon(
                            IconData(0xe093,
                                fontFamily: 'MaterialIcons',
                                matchTextDirection: true),
                            color: Colors.black,
                          ),
                          style: ElevatedButton.styleFrom(
                            primary: Colors.white,
                            elevation: 8,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
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
                    alignment: AlignmentDirectional(-0.25, 0),
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
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            //reigster text
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  24, 20, 24, 20),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Align(
                                      alignment: AlignmentDirectional(0, 0),
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
                            //username field
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  24, 20, 24, 20),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: customTextField(
                                      controller: username,
                                      obscure: false,
                                      label: "Username",
                                      borderColor: Color(0xFF4A4646),
                                      errorBorderColor: Color(0xFFFF0000),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            //email field
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  24, 20, 24, 20),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: customTextField(
                                      controller: email,
                                      obscure: false,
                                      label: "Email",
                                      borderColor: Color(0xFF4A4646),
                                      errorBorderColor: Color(0xFFFF0000),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            //password field
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  24, 20, 24, 20),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: customTextField(
                                      controller: password,
                                      obscure: true,
                                      label: "Password",
                                      borderColor: Color(0xFF4A4646),
                                      errorBorderColor: Color(0xFFFF0000),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            //confirm field
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  24, 20, 24, 20),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: customTextField(
                                      controller: confirmPassword,
                                      obscure: true,
                                      label: "Confirm Password",
                                      borderColor: Color(0xFF4A4646),
                                      errorBorderColor: Color(0xFFFF0000),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            //submit button
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  24, 10, 24, 10),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Card(
                                      elevation: 8,
                                      child: SizedBox(
                                        height: 40,
                                        child: TextButton(
                                          onPressed: () {},
                                          child: Text(
                                            "Sign Up",
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                          style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty
                                                    .resolveWith<Color>(
                                                        (Set<MaterialState>
                                                            states) {
                                              if (states.contains(
                                                  MaterialState.hovered))
                                                return Color(0xFF106b03);
                                              return Color(0xFF26890c);
                                            }),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            //or divider
                            Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    margin: EdgeInsets.only(
                                        left: 10.0, right: 20.0),
                                    child: Divider(
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                                Text("or"),
                                Expanded(
                                  child: Container(
                                    margin: EdgeInsets.only(
                                        left: 10.0, right: 20.0),
                                    child: Divider(
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            //login with google
                            //login with microsoft
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
      ),
    );
  }
}
