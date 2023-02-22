import 'package:flutter/material.dart';
import 'screens/forgot-password-screen.dart';
import 'screens/game-pin-screen.dart';
import 'screens/login-screen.dart';
import 'screens/register-screen.dart';

var routes = <String, WidgetBuilder>{
  "/": (context) => const gamePinScreen(),
  "/login": (context) => const LoginScreen(),
  "/register": (context) => const Register(),
  "/forgot-password": (context) => const ForgotPasswordWidget(),
};
