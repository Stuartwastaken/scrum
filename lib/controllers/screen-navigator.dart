import 'package:flutter/material.dart';

class ScreenNavigator {
  static navigate(BuildContext context, Widget nextScreen) {
    Navigator.pushReplacement(
        context,
        PageRouteBuilder(
            transitionDuration: const Duration(milliseconds: 100),
            pageBuilder: (context, animation, secondaryAnimation) {
              return nextScreen;
            }));
  }
}
