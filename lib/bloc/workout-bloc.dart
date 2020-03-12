import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'package:screen/screen.dart';
import 'package:vibrate/vibrate.dart';
import 'package:workout_player/model/chrono.dart';
import 'package:workout_player/model/profile-loader.dart';
import 'package:workout_player/model/profile-repository.dart';
import 'package:workout_player/model/profile.dart';
import 'package:workout_player/model/repository.dart';

class WorkoutBloc {
  final Repository _repository;
  final ProfileRepository _profileRepository;
  final ProfileLoader _profileLoader;
  Chrono _originalChrono;
  Chrono _chrono;
  Chrono _selectedChrono;
  bool _isChronoRunning = false;
  BehaviorSubject<Chrono> _currentChronoSubject;
  BehaviorSubject<Chrono> _selectedChronoSubject;
  BehaviorSubject<bool> _isChronoRunningSubject;

  bool isVibrateEnabled = true;
  bool isAutoPlayEnabled = true;
  bool isRestartPlaylistEnabled = true;

  WorkoutBloc(this._repository, this._profileRepository, this._profileLoader) {
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

  get numberOfChronos => _repository.numberOfChronos;

  Future<void> startChrono() async {
    if (_chrono == null) {
      return;
    }

    Screen.keepOn(true);
    isChronoRunning = true;
    while (_chrono != null && !_chrono.isOver && isChronoRunning) {
      var currentChrono = _chrono;
      await Future.delayed(Duration(seconds: 1));
      if(currentChrono != _chrono) {
        continue;
      }
      if (isChronoRunning) {
        _chrono.decrease();
        _currentChronoSubject.sink.add(_chrono);

        if (_chrono.isOver) {
          if (isVibrateEnabled && await Vibrate.canVibrate) {
            Vibrate.vibrate();
          }

          if (!isAutoPlayEnabled) {
            isChronoRunning = false;
          }
          await Future.delayed(Duration(
              seconds: 1)); // Wait 1 sec before starting the next Chrono
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

  void next() {
    var newChrono = _repository.nextChrono(_originalChrono, isRestartPlaylistEnabled);
    selectedChrono = newChrono;
  }

  void previous() {
    var newChrono;
    if(_originalChrono.isEqualTo(_chrono)) {
      newChrono = _repository.previousChrono(_originalChrono);
    } else {
      newChrono = _originalChrono;
    }
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

  void addNewChrono(Chrono newChrono) {
    _repository.addChrono(newChrono);

    if (_selectedChrono == null) {
      selectedChrono = newChrono;
    }
  }

  void loadProfile(ProfileOld profile) {
    switch (profile) {
      case ProfileOld.rock:
        print('rock profile choosen');
        _profileLoader.loadRockProfile();
        break;
      case ProfileOld.fitness:
        print('fitness profile choosen');
        _profileLoader.loadFitnessProfile();
        break;
      case ProfileOld.extensivePhase:
        print('extensive phase profile choosen');
        _profileLoader.loadExtensivePhaseProfile();
        break;
      case ProfileOld.empty:
        print('empty profile choosen');
        _profileLoader.loadEmptyProfile();
        break;
    }

    selectedChrono =
        _repository.numberOfChronos > 0 ? _repository.getChrono(0) : null;
  }

  void saveProfile(String title) {
    print("save profile $title");
    Profile profile = new Profile(title: title, chronos: _repository.allChronos);
    _profileRepository.saveProfile(profile);
  }

  void dispose() {
    _currentChronoSubject.close();
    _selectedChronoSubject.close();
    _isChronoRunningSubject.close();
  }
}
