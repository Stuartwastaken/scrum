import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:scrum/screens/game-pin-screen.dart';
import 'package:firebase_database/firebase_database.dart';

class LobbyScreen extends StatefulWidget {
  const LobbyScreen({
    Key? key,
    this.gameID,
  }) : super(key: key);

  final String? gameID;

  @override
  State<LobbyScreen> createState() => LobbyScreenState();
}

class LobbyScreenState extends State<LobbyScreen>
    with SingleTickerProviderStateMixin {
  final DatabaseReference databaseRef = FirebaseDatabase.instance.reference();
  late AnimationController _controller;
  late Animation<double> _animation;
  final StreamController<int> playerStreamController = StreamController<int>();

  Future<int?> getPeopleInLobby(String gameID) async {
    final DatabaseReference databaseRef = FirebaseDatabase.instance.reference();

    databaseRef.child(gameID).child('peopleInLobby').onValue.listen((event) {
      final int? numberOfPlayers = event.snapshot.value as int?;
      if (numberOfPlayers != null) {
        playerStreamController.add(numberOfPlayers);
      }
    }, onError: (error) {
      playerStreamController.addError(error);
    });

    // Return null since we don't need to return anything
    return null;
  }

  Stream<int> get playerCountStream => playerStreamController.stream;

  @override
  void dispose() {
    playerStreamController.close();
  }

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3500),
    )..repeat();

    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);

    getPeopleInLobby(widget.gameID!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              stops: [0.0, 0.35, 1.0], // set stops for the gradient
              colors: [
                Color.fromARGB(255, 161, 15, 223),
                Color.fromARGB(255, 251, 153, 42),
                Color.fromARGB(255, 63, 3, 192), // add a third color
              ],
            ),
          ),
          child: Stack(
            children: <Widget>[
              Positioned(
                  top: 16,
                  right: 16,
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        PageRouteBuilder(
                          pageBuilder: (context, animation1, animation2) =>
                              const GamePinScreen(),
                          transitionDuration: Duration.zero,
                          reverseTransitionDuration: Duration.zero,
                        ),
                      );
                    },
                    child: Text(
                      "Leave",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      onPrimary: Color.fromARGB(255, 255, 255, 255),
                      side: BorderSide(
                          width: 2.0,
                          color: Color.fromARGB(
                              255, 255, 255, 255)), // foreground color
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            7), // set the desired border radius here
                      ),
                      minimumSize: Size(90, 35),
                    ),
                  )),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    AnimatedBuilder(
                      animation: _animation,
                      builder: (BuildContext context, Widget? child) {
                        final ellipsis =
                            '.' * (0 + (_animation.value * 4).floor());
                        return Text(
                          "Waiting for Players$ellipsis",
                          style: TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: 72,
                            fontStyle: FontStyle.italic,
                            color: Colors.white,
                          ),
                        );
                      },
                    ),
                    SizedBox(height: 2),
                    StreamBuilder<int>(
                      stream: playerCountStream,
                      builder:
                          (BuildContext context, AsyncSnapshot<int> snapshot) {
                        if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        } else {
                          switch (snapshot.connectionState) {
                            case ConnectionState.none:
                              return Text('Not connected to the stream');
                            case ConnectionState.waiting:
                              return Text('Loading...');
                            case ConnectionState.active:
                              return Text(
                                '${snapshot.data}',
                                style: TextStyle(
                                  fontWeight: FontWeight.w800,
                                  fontSize: 80,
                                  fontStyle: FontStyle.normal,
                                  color: Colors.white,
                                ),
                              );
                            case ConnectionState.done:
                              return Text('Stream has ended');
                          }
                        }
                      },
                    ),
                    Text(
                      "Players Joined",
                      style: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontStyle: FontStyle.normal,
                          fontSize: 32,
                          color: Colors.white),
                    ),
                  ],
                ),
              ),
            ],
          )),
    );
  }
}
