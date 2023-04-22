import 'dart:async';
import 'package:firebase_database/firebase_database.dart';
import 'package:scrum/utils/fire_RTdatabase.dart';
import 'package:rxdart/rxdart.dart';

class QuizStream {
  final DatabaseReference _databaseReference = FirebaseDatabase.instance.ref();
  final StreamController<int> _timeStreamController = BehaviorSubject<int>();
  final _startStreamController = StreamController<bool>();
  Timer? _timer;
  StreamSubscription<DatabaseEvent>? _subscription;

  void startTimer(String quizID) {
    if (_timer != null && _timer!.isActive) {
      _timer!.cancel();
    }
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      ScrumRTdatabase.decrementTimer(quizID);
    });
  }

  void cancelTimer() {
    _timer?.cancel();
  }

  void listenToQuizTime(String quizId) {
    _subscription =
        _databaseReference.child('$quizId/time').onValue.listen((event) {
      try {
        final value = event.snapshot.value;
        if (value is int) {
          final int time = value;
          _timeStreamController.add(time);
        } else {
          throw StateError('Unexpected data type');
        }
      } catch (e) {
        _timeStreamController.addError(e);
      }
    });
  }

  void listenForStart(String quizId) {
    _subscription =
        _databaseReference.child('$quizId/start').onValue.listen((event) {
      try {
        final value = event.snapshot.value;
        if (value is bool) {
          final bool start = value;
          _startStreamController.add(start);
        } else {
          throw StateError('Unexpected data type');
        }
      } catch (e) {
        _startStreamController.addError(e);
      }
    });
  }

  Stream<int> get timeStream => _timeStreamController.stream;
  Stream<bool> get isTimeZeroStream => timeStream.map((time) => time == 0);

  Stream<bool> get startStream => _startStreamController.stream;
  Stream<bool> get isStartTrueStream =>
      startStream.map((start) => start == true);

  void dispose() {
    _timeStreamController.close();
    _subscription?.cancel();
    cancelTimer();
  }
}
