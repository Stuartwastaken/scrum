import 'dart:async';
import 'package:firebase_database/firebase_database.dart';

class ScrumRTdatabase {
  static final StreamController<int> playerStreamController =
      StreamController<int>();

  static Future<bool> checkPinExists(String pinID) async {
    final databaseRef = FirebaseDatabase.instance.ref();
    var snapshot = await databaseRef.child(pinID).once();
    return snapshot.snapshot.exists;
  }

  //add user to RT database under correct lobbyID
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

  //remove user from RT database under correct lobbyID
  static Future<void> removeUserFromTree(
      String nickname, String gamePin) async {
    final databaseRef = FirebaseDatabase.instance.ref();
    final gamePinRef = databaseRef.child(gamePin);
    DatabaseEvent dataEvent = await gamePinRef.once();
    Map<dynamic, dynamic> users = dataEvent.snapshot.value as Map;
    if (users != null) {
      users.forEach((key, value) {
        if (key.toString().substring(0, 3) == 'uid') {
          if (value['nickname'] == nickname) {
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

  static Future<int?> getPeopleInLobby(String gameID) async {
    final DatabaseReference databaseRef = FirebaseDatabase.instance.ref();

    databaseRef.child(gameID).child('peopleInLobby').onValue.listen((event) {
      final int? numberOfPlayers = event.snapshot.value as int?;
      if (numberOfPlayers != null) {
        playerStreamController.add(numberOfPlayers);
      }
    }, onError: (error) {
      playerStreamController.addError(error);
    });
    return null; // Return null since we don't need to return anything
  }

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
}
