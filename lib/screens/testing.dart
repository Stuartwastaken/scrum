import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:rxdart/rxdart.dart';

class QuizTimeStream {
  final DatabaseReference _databaseReference =
      FirebaseDatabase.instance.reference();
  final StreamController<String> _timeStreamController =
      BehaviorSubject<String>();

  Future<String?> listenToQuizTime(String quizId) {
    final completer = Completer<String?>();

    _databaseReference.child('quiz/$quizId/time').onValue.listen((event) {
      final String? time = event.snapshot.value as String?;
      if (time != null) {
        _timeStreamController.add(time);
        completer.complete(time);
      }
    }, onError: (error) {
      completer.completeError(error);
    });

    return completer.future;
  }

  Stream<String> get timeStream => _timeStreamController.stream;

  void dispose() {
    _timeStreamController.close();
  }
}
