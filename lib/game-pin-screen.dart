import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
          scaffoldBackgroundColor: Color.fromARGB(255, 255, 255, 255)),
      home: const MyHomePage(title: 'Game Pin Screen'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Color.fromARGB(255, 5, 70, 175),
              Color.fromARGB(255, 180, 203, 240),
            ],
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              top: 16,
              right: 16,
              child: userButton(),
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    'images/SCRUM2.png', // path to your image file
                    width: MediaQuery.of(context).size.width * 0.265,
                    //height: 250,
                    fit: BoxFit.fitWidth,
                  ),
                  SizedBox(height: 12),
                  Container(
                    width: 400,
                    height: 225,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(7),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          offset: Offset(0.0, 1.0),
                          blurRadius: 15.0,
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 12.0, bottom: 12.0, left: 40.0, right: 40.0),
                          child: keyTextField(),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 4.0, bottom: 12.0, left: 40.0, right: 40.0),
                          child: userTextField(),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(top: 4.0, bottom: 12.0),
                          child: enterButton(),
                        ),
                      ],
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

class enterButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      child: Text(
        "Enter",
        style: TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 16,
        ),
      ),
      style: ElevatedButton.styleFrom(
        primary: Color.fromARGB(255, 5, 70, 175),
        onPrimary: Colors.white,
        shadowColor: Colors.grey,
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7.0)),
        minimumSize: Size(330, 50),
      ),
    );
  }
}

class keyTextField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextField(
        style: new TextStyle(
            fontWeight: FontWeight.w400,
            fontFamily: "SegoeUI",
            fontStyle: FontStyle.normal,
            fontSize: 16.0),
        decoration: InputDecoration(
            border: OutlineInputBorder(
              borderSide: BorderSide(
                  color: Color.fromARGB(255, 0, 0,
                      0)), // Set border color to a darker shade of grey
            ),
            hintText: 'Game PIN',
            labelStyle: new TextStyle(color: const Color(0xFF424242))));
  }
}

class userTextField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextField(
      style: TextStyle(
        fontFamily: 'Roboto',
        fontSize: 16,
        color: Colors.black,
      ),
      decoration: InputDecoration(
          border: OutlineInputBorder(),
          hintText: 'Nickname',
          labelStyle: new TextStyle(color: const Color(0xFF424242))),
    );
  }
}

class userButton extends StatelessWidget {
  const userButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
            ),
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Icon(
                Icons.person,
                color: Color.fromARGB(255, 5, 70, 175),
              ),
            ),
          ),
          Positioned(
            right: 0,
            child: PopupMenuButton<String>(
              icon: const SizedBox.shrink(),
              onSelected: choiceAction,
              itemBuilder: (BuildContext context) {
                return Constants.choices.map((String choice) {
                  return PopupMenuItem<String>(
                    value: choice,
                    child: Text(choice),
                  );
                }).toList();
              },
            ),
          ),
        ],
      ),
    );
  }
}

class Constants {
  static const String FirstItem = 'Log In';
  static const String SecondItem = 'Sign Up';

  static const List<String> choices = <String>[
    FirstItem,
    SecondItem,
  ];
}

void choiceAction(String choice) {
  if (choice == Constants.FirstItem) {
    print('I First Item');
  } else if (choice == Constants.SecondItem) {
    print('I Second Item');
  }
}
