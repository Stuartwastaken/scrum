import 'dart:async';
import 'package:firebase_database/firebase_database.dart';
import 'package:scrum/utils/fire_RTdatabase.dart';
import 'package:rxdart/rxdart.dart';

class QuizTimeStream {
  final DatabaseReference _databaseReference = FirebaseDatabase.instance.ref();
  final StreamController<int> _timeStreamController = BehaviorSubject<int>();
  Timer? _timer;

  void startTimer(String quizID) {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      ScrumRTdatabase.decrementTimer(quizID);
    });
  }
    
  void cancelTimer() {
    _timer?.cancel();
  }

  Future<int?> listenToQuizTime(String quizId) {
    final completer = Completer<int?>();

    _databaseReference.child('$quizId/time').onValue.listen((event) {
      final value = event.snapshot.value;
      if (value is int) {
        final int time = value;
        _timeStreamController.add(time);
        completer.complete(time);
      } else {
        completer.completeError('Unexpected data type');
      }
    }, onError: (error) {
      completer.completeError(error);
    });

    return completer.future;
  }

  Stream<int> get timeStream => _timeStreamController.stream;

  Stream<bool> get isTimeZeroStream => timeStream.map((time) => time == 0);



  void dispose() {
    _timeStreamController.close();
  }
}
