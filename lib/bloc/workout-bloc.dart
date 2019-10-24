import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'package:screen/screen.dart';
import 'package:vibrate/vibrate.dart';
import 'package:workout_player/model/chrono.dart';
import 'package:workout_player/model/repository.dart';

class WorkoutBloc {
  final Repository _repository;
  Chrono _originalChrono;
  Chrono _chrono;
  Chrono _selectedChrono;
  bool _isChronoRunning = false;
  BehaviorSubject<Chrono> _currentChronoSubject;
  BehaviorSubject<Chrono> _selectedChronoSubject;
  BehaviorSubject<bool> _isChronoRunningSubject;

  bool isVibrateEnabled = true;
  bool isAutoPlayEnabled = true;

  WorkoutBloc(this._repository) {
    _currentChronoSubject = new BehaviorSubject<Chrono>.seeded(this._chrono);
    _selectedChronoSubject =
        new BehaviorSubject<Chrono>.seeded(this._originalChrono);
    _isChronoRunningSubject =
        new BehaviorSubject<bool>.seeded(this._isChronoRunning);
  }

  Observable<Chrono> get currentChronoObservable =>
      _currentChronoSubject.stream;
  Observable<Chrono> get selectedChronoObservable =>
      _selectedChronoSubject.stream;
  Observable<bool> get isChronoRunningObservable =>
      _isChronoRunningSubject.stream;

  get isChronoRunning => _isChronoRunning;
  set isChronoRunning(bool value) {
    _isChronoRunning = value;
    _isChronoRunningSubject.sink.add(value);
  }

  set selectedChrono(Chrono value) {
    _originalChrono = value; // We use it as the reference
    _chrono = value != null ? value.clone() : null; // We will decrease this one

    _currentChronoSubject.sink.add(value);
    _selectedChronoSubject.sink.add(_originalChrono);

    _selectedChrono = value;
  }

  Future<void> startChrono() async {
    if (_chrono == null) {
      return;
    }

    Screen.keepOn(true);
    isChronoRunning = true;
    while (_chrono != null && !_chrono.isOver && isChronoRunning) {
      await Future.delayed(Duration(seconds: 1));
      if (isChronoRunning) {
        _chrono.decrease();
        _currentChronoSubject.sink.add(_chrono);

        if (_chrono.isOver) {
          if (isVibrateEnabled && await Vibrate.canVibrate) {
            Vibrate.vibrate();
          }

          if (isAutoPlayEnabled) {
            await Future.delayed(Duration(
                seconds: 1)); // Wait 1 sec before starting the next Chrono
            next();
          } else {
            isChronoRunning = false;
            next(); // Switch directly to the next Chrono without waiting 1 second more
          }
        }
      }
    }
    isChronoRunning = false;
    Screen.keepOn(false);
  }

  void pauseChrono() {
    isChronoRunning = false;
    Screen.keepOn(false);
  }

  void reset() {
    selectedChrono = _originalChrono;
  }

  void next() {
    var newChrono = _repository.nextChrono(_originalChrono);
    selectedChrono = newChrono;
  }

  void previous() {
    var newChrono = _repository.previousChrono(_originalChrono);
    selectedChrono = newChrono;
  }

  void remove(Chrono chrono) {
    if (_selectedChrono == chrono) {
      if (_repository.hasNext(chrono)) {
        next();
      } else if (_repository.hasPrevious(chrono)) {
        previous();
      } else {
        selectedChrono = null;
      }
    }
    _repository.removeChrono(chrono);
  }

  void dispose() {
    _currentChronoSubject.close();
    _selectedChronoSubject.close();
    _isChronoRunningSubject.close();
  }
}
