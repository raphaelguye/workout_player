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
  loadExtensivePhaseProfile() {
    _repository.clear();
    _repository.addChrono(new Chrono(name: '(f) Exercice 1a', minutes: 0, seconds: 30));
    _repository.addChrono(new Chrono(name: '(f) Exercice 1b', minutes: 0, seconds: 30));
    _repository.addChrono(new Chrono(name: 'Changement (f) -> (g)', minutes: 0, seconds: 15));
    _repository.addChrono(new Chrono(name: '(g) Exercice 1a', minutes: 0, seconds: 30));
    _repository.addChrono(new Chrono(name: '(g) Exercice 1b', minutes: 0, seconds: 30));
    _repository.addChrono(new Chrono(name: 'Changement d\'exercice', minutes: 0, seconds: 15));

    _repository.addChrono(new Chrono(name: '(f) Exercice 2a', minutes: 0, seconds: 30));
    _repository.addChrono(new Chrono(name: '(f) Exercice 2b', minutes: 0, seconds: 30));
    _repository.addChrono(new Chrono(name: 'Changement (f) -> (g)', minutes: 0, seconds: 15));
    _repository.addChrono(new Chrono(name: '(g) Exercice 2a', minutes: 0, seconds: 30));
    _repository.addChrono(new Chrono(name: '(g) Exercice 2b', minutes: 0, seconds: 30));
    _repository.addChrono(new Chrono(name: 'Changement d\'exercice', minutes: 0, seconds: 15));

    _repository.addChrono(new Chrono(name: '(f) Exercice 3a', minutes: 0, seconds: 30));
    _repository.addChrono(new Chrono(name: '(f) Exercice 3b', minutes: 0, seconds: 30));
    _repository.addChrono(new Chrono(name: 'Changement (f) -> (g)', minutes: 0, seconds: 15));
    _repository.addChrono(new Chrono(name: '(g) Exercice 3a', minutes: 0, seconds: 30));
    _repository.addChrono(new Chrono(name: '(g) Exercice 3b', minutes: 0, seconds: 30));
    _repository.addChrono(new Chrono(name: 'Changement d\'exercice', minutes: 0, seconds: 15));

    _repository.addChrono(new Chrono(name: '(f) Exercice 4a', minutes: 0, seconds: 30));
    _repository.addChrono(new Chrono(name: '(f) Exercice 4b', minutes: 0, seconds: 30));
    _repository.addChrono(new Chrono(name: 'Changement (f) -> (g)', minutes: 0, seconds: 15));
    _repository.addChrono(new Chrono(name: '(g) Exercice 4a', minutes: 0, seconds: 30));
    _repository.addChrono(new Chrono(name: '(g) Exercice 4b', minutes: 0, seconds: 30));
    _repository.addChrono(new Chrono(name: 'Changement d\'exercice', minutes: 0, seconds: 15));

    _repository.addChrono(new Chrono(name: '(f) Exercice 5a', minutes: 0, seconds: 30));
    _repository.addChrono(new Chrono(name: '(f) Exercice 5b', minutes: 0, seconds: 30));
    _repository.addChrono(new Chrono(name: 'Changement (f) -> (g)', minutes: 0, seconds: 15));
    _repository.addChrono(new Chrono(name: '(g) Exercice 5a', minutes: 0, seconds: 30));
    _repository.addChrono(new Chrono(name: '(g) Exercice 5b', minutes: 0, seconds: 30));
    _repository.addChrono(new Chrono(name: 'Changement d\'exercice', minutes: 0, seconds: 15));

    _repository.addChrono(new Chrono(name: '(f) Exercice 6a', minutes: 0, seconds: 30));
    _repository.addChrono(new Chrono(name: '(f) Exercice 6b', minutes: 0, seconds: 30));
    _repository.addChrono(new Chrono(name: 'Changement (f) -> (g)', minutes: 0, seconds: 15));
    _repository.addChrono(new Chrono(name: '(g) Exercice 6a', minutes: 0, seconds: 30));
    _repository.addChrono(new Chrono(name: '(g) Exercice 6b', minutes: 0, seconds: 30));
    _repository.addChrono(new Chrono(name: 'Changement d\'exercice', minutes: 0, seconds: 15));

    _repository.addChrono(new Chrono(name: '(f) Exercice 7a', minutes: 0, seconds: 30));
    _repository.addChrono(new Chrono(name: '(f) Exercice 7b', minutes: 0, seconds: 30));
    _repository.addChrono(new Chrono(name: 'Changement (f) -> (g)', minutes: 0, seconds: 15));
    _repository.addChrono(new Chrono(name: '(g) Exercice 7a', minutes: 0, seconds: 30));
    _repository.addChrono(new Chrono(name: '(g) Exercice 7b', minutes: 0, seconds: 30));
    _repository.addChrono(new Chrono(name: 'Changement d\'exercice', minutes: 0, seconds: 15));

    _repository.addChrono(new Chrono(name: '(f) Exercice 8a', minutes: 0, seconds: 30));
    _repository.addChrono(new Chrono(name: '(f) Exercice 8b', minutes: 0, seconds: 30));
    _repository.addChrono(new Chrono(name: 'Changement (f) -> (g)', minutes: 0, seconds: 15));
    _repository.addChrono(new Chrono(name: '(g) Exercice 8a', minutes: 0, seconds: 30));
    _repository.addChrono(new Chrono(name: '(g) Exercice 8b', minutes: 0, seconds: 30));
    _repository.addChrono(new Chrono(name: 'Changement d\'exercice', minutes: 0, seconds: 15));

    _repository.addChrono(new Chrono(name: '(f) Exercice 9a', minutes: 0, seconds: 30));
    _repository.addChrono(new Chrono(name: '(f) Exercice 9b', minutes: 0, seconds: 30));
    _repository.addChrono(new Chrono(name: 'Changement (f) -> (g)', minutes: 0, seconds: 15));
    _repository.addChrono(new Chrono(name: '(g) Exercice 9a', minutes: 0, seconds: 30));
    _repository.addChrono(new Chrono(name: '(g) Exercice 9b', minutes: 0, seconds: 30));
    _repository.addChrono(new Chrono(name: 'Changement d\'exercice', minutes: 0, seconds: 15));

    _repository.addChrono(new Chrono(name: '(f) Exercice 10a', minutes: 0, seconds: 30));
    _repository.addChrono(new Chrono(name: '(f) Exercice 10b', minutes: 0, seconds: 30));
    _repository.addChrono(new Chrono(name: 'Changement (f) -> (g)', minutes: 0, seconds: 15));
    _repository.addChrono(new Chrono(name: '(g) Exercice 10a', minutes: 0, seconds: 30));
    _repository.addChrono(new Chrono(name: '(g) Exercice 10b', minutes: 0, seconds: 30));
    _repository.addChrono(new Chrono(name: 'Changement d\'exercice', minutes: 0, seconds: 15));
  }

  @override
  loadEmptyProfile() {
    _repository.clear();
  }
}
