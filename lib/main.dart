import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:scrum/screens/game-pin-screen.dart';
import 'package:scrum/screens/post-question-screen.dart';
import 'package:scrum/screens/podium-screen.dart';

//proper "home" screen should be set when game-pin screen is uploaded
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MaterialApp(
      title: "SCRUM",
      home: PostQuestionScreenWidget(
          uid: "uid2", isCorrect: true, pointsGained: 456),
    ),
  );
}
