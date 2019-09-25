import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'package:screen/screen.dart';
import 'package:workout_player/model/chrono.dart';
import 'package:workout_player/model/repository.dart';

class WorkoutBloc {
  final Repository _repository;
  Chrono _originalChrono;
  Chrono _chrono;
  bool _isChronoRunning = false;
  BehaviorSubject<Chrono> _currentChronoSubject;
  BehaviorSubject<Chrono> _selectedChronoSubject;
  BehaviorSubject<bool> _isChronoRunningSubject;

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

  set selectedChrono(Chrono chrono) {
    if (chrono == null) {
      return;
    }
    _originalChrono = chrono; // We use it as the reference
    _chrono = chrono.clone(); // We will decrease this one
    _currentChronoSubject.sink.add(chrono);
    _selectedChronoSubject.sink.add(_originalChrono);
  }

  Future<void> startChrono() async {
    Screen.keepOn(true);
    isChronoRunning = true;
    while (!_chrono.isOver && isChronoRunning) {
      await Future.delayed(Duration(seconds: 1));
      if (isChronoRunning) {
        _chrono.decrease();
        _currentChronoSubject.sink.add(_chrono);

        if (_chrono.isOver) {
          next();
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

  void dispose() {
    _currentChronoSubject.close();
    _selectedChronoSubject.close();
    _isChronoRunningSubject.close();
  }
}
