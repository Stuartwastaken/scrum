import 'package:flutter/material.dart';
import 'screens/home-screen.dart';
import 'screens/game-pin-screen.dart';

//proper "home" screen should be set when game-pin screen is uploaded
void main() {
  runApp(
    MaterialApp(
      title: "SCRUM",
      home: const gamePinScreen(
        title: 'Game Pin Screen',
      ),
    ),
  );
}
