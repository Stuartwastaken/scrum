import 'dart:async';
import 'dart:math';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:scrum/screens/game-pin-screen.dart';

class ScrumRTdatabase {
  final StreamController<int> _peopleInLobbyStreamController =
      BehaviorSubject<int>();
  final DatabaseReference _databaseReference = FirebaseDatabase.instance.ref();

  static Future<bool> checkPinExists(String pinID) async {
    final databaseRef = FirebaseDatabase.instance.ref();
    var snapshot = await databaseRef.child(pinID).once();
    return snapshot.snapshot.exists;
  }

  static Future<String> getQuizDoc(String quizID) async {
  final databaseRef = FirebaseDatabase.instance.ref();
  print(1);
  String doc = '';
  await databaseRef.child(quizID).child('document').once().then((DatabaseEvent event) {
    doc = event.snapshot.value as String;
  });
  print(2);
  print("document: $doc");
  return doc;
}

  //add user to RT database under correct lobbyID
  static Future<String?> writeUserToTree(
      String nickname, String gamePin) async {
    final databaseRef = FirebaseDatabase.instance.ref();
    final gamePinRef = databaseRef.child(gamePin);
    String? hash = gamePinRef.push().key;
    String? uniqueId = "uid" + hash!;

    await gamePinRef.child(uniqueId!).set({
      'nickname': nickname,
      'score': 0,
    });

    return uniqueId;
  }

  //remove user from RT database under correct lobbyID
  static Future<void> removeUserFromTree(String hash, String gamePin) async {
    final databaseRef = FirebaseDatabase.instance.ref();
    final gamePinRef = databaseRef.child(gamePin);
    DatabaseEvent dataEvent = await gamePinRef.once();
    Map<dynamic, dynamic> users = dataEvent.snapshot.value as Map;
    if (users != null) {
      users.forEach((key, value) {
        if (key.toString().substring(0, 3) == 'uid') {
          if (key == hash) {
            gamePinRef.child(key).remove();
            return; //break out of forEach loop
          }
        }
      });
    }
  }

  //get all the users. UIDs are keys. Nicknames and scores are values belonging to UID key
  static Future<Map<String, dynamic>> getUsersAndScores(String lobbyID) async {
    final databaseRef = FirebaseDatabase.instance.ref();
    Map<String, dynamic> usersInLobby = {};
    await databaseRef.child(lobbyID).once().then((DatabaseEvent event) {
      Map<dynamic, dynamic> lobbyData = event.snapshot.value as Map;
      if (lobbyData != null) {
        lobbyData.forEach((uid, userData) {
          if (uid.toString().substring(0, 3) == 'uid') {
            String nickname = userData['nickname'];
            int score = userData['score'];
            usersInLobby[uid] = {'nickname': nickname, 'score': score};
          }
        });
      }
    });
    return usersInLobby;
  }

  //increase or decrease lobby population as players enter and leave
  static Future<void> incrementPeopleInLobby(
      String quizID, int incrementBy) async {
    final databaseRef = FirebaseDatabase.instance.ref();
    int peopleInLobby = 0;
    await databaseRef.child(quizID).once().then((DatabaseEvent event) {
      Map<dynamic, dynamic> lobbyData = event.snapshot.value as Map;
      if (lobbyData != null) {
        if (lobbyData.containsKey('peopleInLobby')) {
          peopleInLobby = lobbyData['peopleInLobby'];
        }
      }
      databaseRef
          .child('$quizID/peopleInLobby')
          .set(peopleInLobby + incrementBy);
    });
  }

  Future<int?> listenToPeopleInLobby(String gameId) {
    final completer = Completer<int?>();

    _databaseReference.child('$gameId/peopleInLobby').onValue.listen((event) {
      final int? numberOfPlayers = event.snapshot.value as int?;
      if (numberOfPlayers != null) {
        _peopleInLobbyStreamController.add(numberOfPlayers);
        completer.complete(numberOfPlayers);
      }
    }, onError: (error) {
      completer.completeError(error);
    });

    return completer.future;
  }

  Stream<int> get playerCountStream => _peopleInLobbyStreamController.stream;

  // Grabs the time that is remaining in a specified quiz
  static Future<int?> getTime(String quizID) async {
    final DatabaseReference databaseRef = FirebaseDatabase.instance.ref();
    int remainingTime = 0;

    await databaseRef
        .child(quizID)
        .child('time')
        .once()
        .then((DatabaseEvent event) {
      int quizTime = event.snapshot.value as int;
      if (quizTime != null) {
        remainingTime = quizTime;
      }
    });
    return remainingTime;
  }

  static Future<String> createQuiz(String document) async {
    final DatabaseReference databaseRef = FirebaseDatabase.instance.ref();

    String? quizID = createQuizID();
    bool matchFound = await checkPinExists(quizID);

    while (matchFound) {
      quizID = createQuizID();
      matchFound = await checkPinExists(quizID);
    }

    await databaseRef.child(quizID!).set({
      'document': document,
      'time': 0,
      'peopleInLobby': 0,
      'start': false,
    });

    return quizID;
  }

  static String createQuizID() {
    Random quizID = new Random();
    String result = '';
    for (int i = 0; i < 6; i++) {
      result += quizID.nextInt(10).toString();
    }
    return result;
  }

  static Future<List<String>> getUserNicknames(String lobbyID) async {
    final databaseRef = FirebaseDatabase.instance.ref();
    List<String> nicknames = [];
    await databaseRef.child(lobbyID).once().then((DatabaseEvent event) {
      Map<dynamic, dynamic> lobbyData = event.snapshot.value as Map;
      if (lobbyData != null) {
        lobbyData.forEach((uid, userData) {
          if (uid.toString().substring(0, 3) == 'uid') {
            String nickname = userData['nickname'];
            nicknames.add(nickname);
          }
        });
      }
    });
    return nicknames;
  }

  static DatabaseReference getUserRef(String quizID, String? hash) {
    final DatabaseReference userRef =
        FirebaseDatabase.instance.ref().child(quizID).child(hash!);

    return userRef;
  }

  static void deleteLobby(String quizID) {
    FirebaseDatabase.instance.ref().child(quizID).remove();
  }

  DatabaseReference getDatabaseRef() {
    return _databaseReference;
  }
}
