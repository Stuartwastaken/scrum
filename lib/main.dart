import 'package:flutter/material.dart';

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
  @override
  Widget build(BuildContext context) {
    // ignore: dead_code
    return Scaffold(
      body: Row(
        children: [
          //Column 1
          Column(
            children: [
              //title
              Text(
                "SCRUM",
                style: TextStyle(
                  decoration: TextDecoration.underline,
                  fontSize: 45,
                ),
              ),
              ElevatedButton(
                onPressed: () {},
                child: const Text("Back"),
              ),
            ],
          ),
          //Column 2
          Column(
            children: [
              const Text("Sign Up"),
              Container(
                width: 500,
                height: 500,
                color: Colors.purple,
                //Form
                child: Column(
                  children: [
                    //sign up text
                    Row(
                      // ignore: prefer_const_literals_to_create_immutables
                      children: [
                        const Text(
                          "Register",
                          selectionColor: Colors.white,
                          style: TextStyle(
                            fontSize: 40,
                          ),
                        ),
                      ],
                    ),
                    //username field
                    Row(
                      // ignore: prefer_const_literals_to_create_immutables
                      children: [
                        Expanded(
                          child: const TextField(
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: "Email",
                              hintText: "Enter your email",
                            ),
                          ),
                        ),
                      ],
                    ),
                    //password field
                    Row(
                      // ignore: prefer_const_literals_to_create_immutables
                      children: [
                        Expanded(
                          child: const TextField(
                            obscureText: true,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: "Password",
                              hintText: "Enter your password",
                            ),
                          ),
                        ),
                      ],
                    ),
                    //register button
                    Row(
                      children: [
                        ElevatedButton(
                          child: const Text("Sign Up"),
                          onPressed: () {},
                        )
                      ],
                    ),
                    //divider
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.only(left: 10.0, right: 20.0),
                            child: Divider(
                              color: Colors.black,
                            ),
                          ),
                        ),
                        Text("OR"),
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.only(left: 10.0, right: 20.0),
                            child: Divider(
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                    //already have account
                    Row(
                      children: [
                        const Text("Alreay have an account? "),
                        GestureDetector(
                          onTap: () {},
                          child: const Text(
                            "Log in",
                            style: TextStyle(
                              color: Colors.blue,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
