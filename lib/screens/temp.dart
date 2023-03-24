import 'package:flutter/material.dart';

class Quiz extends StatefulWidget {
  const Quiz({super.key});

  @override
  State<Quiz> createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(8),
        children: <Widget>[
          Container(
            height: 50,
            color: Colors.amber[600],
            child: Row(
              children: [
                Text("Title 1"),
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    IconData(0xf67a, fontFamily: 'MaterialIcons'),
                    color: Colors.blue,
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    IconData(0xf3e9, fontFamily: 'MaterialIcons'),
                    color: Colors.red,
                  ),
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: const Text("Delete"),
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: const Text("Play"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
