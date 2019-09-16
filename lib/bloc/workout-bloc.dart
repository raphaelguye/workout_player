import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'package:workout_player/model/chrono.dart';
import 'package:workout_player/model/repository.dart';

class WorkoutBloc {
  final Repository _repository;
  Chrono _originalChrono;
  Chrono _chrono;
  bool isTimerRunning = false;
  BehaviorSubject<Chrono> _subjectTimer;
  BehaviorSubject<Chrono> _chronoRunning;

  WorkoutBloc(this._repository) {
    _subjectTimer = new BehaviorSubject<Chrono>.seeded(this._chrono);
    _chronoRunning = new BehaviorSubject<Chrono>.seeded(this._originalChrono);
  }

  Observable<Chrono> get timerObservable => _subjectTimer.stream;
  Observable<Chrono> get chronoRunningObservable => _chronoRunning.stream;

  set selectedChrono(Chrono chrono) {
    _originalChrono = chrono; // We use it as the reference
    _chrono = chrono.clone(); // We will decrease this one
    _subjectTimer.sink.add(chrono);
    _chronoRunning.sink.add(_originalChrono);
  }

  Future<void> startTimer() async {
    isTimerRunning = true;
    while (!_chrono.isOver && isTimerRunning) {
      await Future.delayed(Duration(seconds: 1));
      if (isTimerRunning) {
        _chrono.decrease();
        _subjectTimer.sink.add(_chrono);

        if (_chrono.isOver) {
          var newChrono = _repository.nextChrono(_originalChrono);
          if (newChrono != null) {
            selectedChrono = newChrono;
          }
        }
      }
    }
    isTimerRunning = false;
  }

  void pauseTimer() {
    isTimerRunning = false;
  }

  void dispose() {
    _subjectTimer.close();
    _chronoRunning.close();
  }
}
