import 'package:workout_player/model/repository.dart';

import '../ioc-manager.dart';
import 'chrono.dart';

enum Profile { rock, fitness, empty }

abstract class ProfileLoader {
  loadRockProfile();
  loadFitnessProfile();
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
        new Chrono(name: 'Programme 1 - partie 1', minutes: 0, seconds: 30));
    _repository
        .addChrono(new Chrono(name: 'Récupération', minutes: 0, seconds: 45));
    _repository.addChrono(
        new Chrono(name: 'Programme 1 - partie 2', minutes: 0, seconds: 30));
    _repository
        .addChrono(new Chrono(name: 'Récupération', minutes: 0, seconds: 45));
    _repository.addChrono(
        new Chrono(name: 'Programme 1 - partie 3', minutes: 0, seconds: 30));
    _repository
        .addChrono(new Chrono(name: 'Récupération', minutes: 0, seconds: 45));
    _repository.addChrono(
        new Chrono(name: 'Programme 2 - partie 1', minutes: 0, seconds: 30));
    _repository
        .addChrono(new Chrono(name: 'Récupération', minutes: 0, seconds: 45));
    _repository.addChrono(
        new Chrono(name: 'Programme 2 - partie 2', minutes: 0, seconds: 30));
    _repository
        .addChrono(new Chrono(name: 'Récupération', minutes: 0, seconds: 45));
    _repository.addChrono(
        new Chrono(name: 'Programme 2 - partie 3', minutes: 0, seconds: 30));
    _repository
        .addChrono(new Chrono(name: 'Récupération', minutes: 0, seconds: 45));
    _repository.addChrono(
        new Chrono(name: 'Programme 3 - partie 1', minutes: 0, seconds: 30));
    _repository
        .addChrono(new Chrono(name: 'Récupération', minutes: 0, seconds: 45));
    _repository.addChrono(
        new Chrono(name: 'Programme 3 - partie 2', minutes: 0, seconds: 30));
    _repository
        .addChrono(new Chrono(name: 'Récupération', minutes: 0, seconds: 45));
    _repository.addChrono(
        new Chrono(name: 'Programme 3 - partie 3', minutes: 0, seconds: 30));
    _repository.addChrono(
        new Chrono(name: 'Récupération longue', minutes: 12, seconds: 0));
  }

  @override
  loadFitnessProfile() {
    _repository.clear();
    _repository.addChrono(new Chrono(name: 'Série 1', minutes: 0, seconds: 30));
    _repository
        .addChrono(new Chrono(name: 'Récupération', minutes: 1, seconds: 0));
    _repository.addChrono(new Chrono(name: 'Série 2', minutes: 0, seconds: 30));
    _repository
        .addChrono(new Chrono(name: 'Récupération', minutes: 1, seconds: 0));
    _repository.addChrono(new Chrono(name: 'Série 3', minutes: 0, seconds: 30));
    _repository
        .addChrono(new Chrono(name: 'Récupération', minutes: 2, seconds: 0));
  }

  @override
  loadEmptyProfile() {
    _repository.clear();
  }
}
