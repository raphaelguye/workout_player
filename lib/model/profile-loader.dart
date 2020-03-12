import 'package:workout_player/model/repository.dart';

import '../ioc-manager.dart';
import 'chrono.dart';

enum ProfileOld { rock, fitness, extensivePhase, empty }

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
        new Chrono(name: 'Programme - partie 1', minutes: 0, seconds: 30));
    _repository
        .addChrono(new Chrono(name: 'Récupération', minutes: 0, seconds: 45));
    _repository.addChrono(
        new Chrono(name: 'Programme - partie 2', minutes: 0, seconds: 30));
    _repository
        .addChrono(new Chrono(name: 'Récupération', minutes: 0, seconds: 45));
    _repository.addChrono(
        new Chrono(name: 'Programme - partie 3', minutes: 0, seconds: 30));
    _repository
        .addChrono(new Chrono(name: 'Récupération', minutes: 0, seconds: 45));
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
        .addChrono(new Chrono(name: 'Changement d\'exercice', minutes: 2, seconds: 0));
  }

  @override
  loadExtensivePhaseProfile() {
    _repository.clear();
    _repository.addChrono(new Chrono(name: 'Filles: 1ère partie', minutes: 0, seconds: 30));
    _repository.addChrono(new Chrono(name: 'Filles: 2ème partie', minutes: 0, seconds: 30));
    _repository.addChrono(new Chrono(name: 'Chang. filles -> garçons', minutes: 0, seconds: 15));
    _repository.addChrono(new Chrono(name: 'Garçons: 1ère partie', minutes: 0, seconds: 30));
    _repository.addChrono(new Chrono(name: 'Garçons: 2ème partie', minutes: 0, seconds: 30));
    _repository.addChrono(new Chrono(name: 'Changement d\'exercice', minutes: 0, seconds: 15));
  }

  @override
  loadEmptyProfile() {
    _repository.clear();
  }
}
