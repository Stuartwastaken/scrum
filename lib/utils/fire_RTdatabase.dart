import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class ScrumRTdatabase {
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
          ;
        });
      }
    });
    return usersInLobby;
  }

  static Future<void> writeUserToTree(String nickname, String gamePin) async {
    final databaseRef = FirebaseDatabase.instance.ref();
    final gamePinRef = databaseRef.child(gamePin);
    String? hash = gamePinRef.push().key;
    String? uniqueId = "uid" + hash!;

    await gamePinRef.child(uniqueId!).set({
      'nickname': nickname,
      'score': 0,
    });
  }

  static Future<bool> checkPinExists(String pinID) async {
    final databaseRef = FirebaseDatabase.instance.ref();
    var snapshot = await databaseRef.child(pinID).once();
    return snapshot.snapshot.exists;
  }

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
}
