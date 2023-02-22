import 'package:flutter/material.dart';
import 'routes.dart';

//proper "home" screen should be set when game-pin screen is uploaded
void main() {
  runApp(
    MaterialApp(
      title: "SCRUM",
      initialRoute: "/",
      routes: routes,
    ),
  );
}
