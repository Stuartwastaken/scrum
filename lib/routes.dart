import 'package:flutter/material.dart';
import 'package:scrum/screens/podium-screen.dart';
import 'screens/forgot-password-screen.dart';
import 'screens/game-pin-screen.dart';
import 'screens/login-screen.dart';
import 'screens/mc-screen.dart';
import 'screens/register-screen.dart';
import 'screens/podium-screen.dart';

var routes = <String, WidgetBuilder>{
  "/": (context) => const MultipleChoiceWidget(),
  "/login": (context) => const LoginScreen(),
  "/register": (context) => const Register(),
  "/forgot-password": (context) => const ForgotPasswordWidget(),
  "/podium": (context) => const PodiumScreen(),
};
