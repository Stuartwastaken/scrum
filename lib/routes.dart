import 'package:flutter/material.dart';
import 'package:scrum/screens/podium-screen.dart';
import 'screens/forgot-password-screen.dart';
import 'screens/game-pin-screen.dart';
import 'screens/lobby_screen.dart';
import 'screens/login-screen.dart';
import 'screens/mc-screen.dart';
import 'screens/register-screen.dart';
import 'screens/podium-screen.dart';

var routes = <String, WidgetBuilder>{
  "/": (context) => const GamePinScreen(),
  "/login": (context) => LoginScreen(),
  "/register": (context) => RegisterScreen(),
  "/forgot-password": (context) => const ForgotPasswordWidget(),
  "/podium": (context) => const PodiumScreen(),
  "/lobby": (context) => const LobbyScreen(gameID: "998765", nickname: "stu"),
};
