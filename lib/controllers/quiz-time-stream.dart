import 'dart:async';
import 'package:firebase_database/firebase_database.dart';
import 'package:rxdart/rxdart.dart';

class QuizTimeStream {
  final DatabaseReference _databaseReference = FirebaseDatabase.instance.ref();
  final StreamController<int> _timeStreamController = BehaviorSubject<int>();

  Future<int?> listenToQuizTime(String quizId) {
    final completer = Completer<int?>();

    _databaseReference.child('$quizId/time').onValue.listen((event) {
      final int? time = event.snapshot.value as int?;
      if (time != null) {
        _timeStreamController.add(time);
        completer.complete(time);
      }
    }, onError: (error) {
      completer.completeError(error);
    });

    return completer.future;
  }

  Stream<int> get timeStream => _timeStreamController.stream;

  void dispose() {
    _timeStreamController.close();
  }
}
