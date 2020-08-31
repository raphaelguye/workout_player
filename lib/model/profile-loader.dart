import 'package:workout_player/model/repository.dart';

import '../ioc-manager.dart';
import 'chrono.dart';

enum Profile { rock, fitness, extensivePhase, empty }

abstract class ProfileLoader {
  loadRockProfile();
  loadFitnessProfile();
  loadExtensivePhaseProfile();
  loadEmptyProfile();
}

class ProfileLoaderImplementation extends ProfileLoader {
  Repository _repository;

  ProfileLoaderImplementation() {
    _repository = IoCManager.ioc.get<Repository>();
  }

  @override
  loadRockProfile() {
    _repository.clear();
    _repository.addChrono(
        new Chrono(name: 'Routine - part 1', minutes: 0, seconds: 30));
    _repository
        .addChrono(new Chrono(name: 'Recovery', minutes: 0, seconds: 45));
    _repository.addChrono(
        new Chrono(name: 'Routine - part 2', minutes: 0, seconds: 30));
    _repository
        .addChrono(new Chrono(name: 'Recovery', minutes: 0, seconds: 45));
    _repository.addChrono(
        new Chrono(name: 'Routine - part 3', minutes: 0, seconds: 30));
    _repository
        .addChrono(new Chrono(name: 'Recovery', minutes: 0, seconds: 45));
  }

  @override
  loadFitnessProfile() {
    _repository.clear();
    _repository.addChrono(new Chrono(name: 'Routine 1', minutes: 0, seconds: 30));
    _repository
        .addChrono(new Chrono(name: 'Recovery', minutes: 1, seconds: 0));
    _repository.addChrono(new Chrono(name: 'Routine 2', minutes: 0, seconds: 30));
    _repository
        .addChrono(new Chrono(name: 'Recovery', minutes: 1, seconds: 0));
    _repository.addChrono(new Chrono(name: 'Routine 3', minutes: 0, seconds: 30));
    _repository
        .addChrono(new Chrono(name: 'Go to the next exercice', minutes: 2, seconds: 0));
  }

  @override
  loadExtensivePhaseProfile() {
    _repository.clear();
    _repository.addChrono(new Chrono(name: 'Group 1:  part 1', minutes: 0, seconds: 30));
    _repository.addChrono(new Chrono(name: 'Group 1: part 2', minutes: 0, seconds: 30));
    _repository.addChrono(new Chrono(name: 'group1 -> group2', minutes: 0, seconds: 15));
    _repository.addChrono(new Chrono(name: 'Group 2:  part 1', minutes: 0, seconds: 30));
    _repository.addChrono(new Chrono(name: 'Group 2: part 2', minutes: 0, seconds: 30));
    _repository.addChrono(new Chrono(name: 'Go to the next exercice', minutes: 0, seconds: 15));
  }

  @override
  loadEmptyProfile() {
    _repository.clear();
  }
}
