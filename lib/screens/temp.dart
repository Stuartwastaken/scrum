import 'package:flutter/material.dart';

class Quiz extends StatefulWidget {
  const Quiz({super.key});

  @override
  State<Quiz> createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  final List<String> entries = <String>['1', '2', '3', '4'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
          padding: const EdgeInsets.all(8),
          itemCount: entries.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              height: 50,
              color: Colors.amber[600],
              child: Row(
                children: [
                  Text("Title ${entries[index]}"),
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
            );
          }),
    );
  }
}
