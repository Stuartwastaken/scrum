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

  static void setTimer(String quizID, int time) {
    FirebaseDatabase.instance.ref().child(quizID).update({'time': time});
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

  static Map<String, dynamic> sort(Map<String, dynamic> usersAndScores) {
    List<MapEntry<String, dynamic>> usersList = usersAndScores.entries.toList();
    usersList.sort((a, b) => b.value['score'].compareTo(a.value['score']));
    usersAndScores = Map.fromEntries(usersList);
    return usersAndScores;
  }

  static int getPlayerPosition(
      List<MapEntry<String, dynamic>> users, String uid) {
    int index = 0;
    for (int i = 0; i < users.length; i++) {
      MapEntry<String, dynamic> currentEntry = users[i];
      if (currentEntry.key == uid) {
        index = i;
        break;
      }
    }
    return index + 1;
  }

  static int getPlayerPoints(
      List<MapEntry<String, dynamic>> users, String uid) {
    for (int i = 0; i < users.length; i++) {
      MapEntry<String, dynamic> currentEntry = users[i];
      if (currentEntry.key == uid) {
        return currentEntry.value['score'];
      }
    }
    return 0;
  }

  //VERY POWERFUL FUNCTION! BE CAREFUL WITH ITS USE
  static void deleteLobby(String quizID) {
    FirebaseDatabase.instance.ref().child(quizID).remove();
  }
}
