import 'package:workout_player/model/repository.dart';

import '../ioc-manager.dart';
import 'chrono.dart';

enum Profile { rock, fitness, extensivePhase, afBlocs, empty }

abstract class ProfileLoader {
  loadRockProfile();
  loadFitnessProfile();
  loadExtensivePhaseProfile();
  loadAFBlocProfile();
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
  loadAFBlocProfile() {
    _repository.clear();
    _repository.addChrono(new Chrono(name: 'Début du bloc 1', minutes: 0, seconds: 5));
    _repository.addChrono(new Chrono(name: 'Fentes sautées alternées', minutes: 0, seconds: 30));
    _repository.addChrono(new Chrono(name: 'Recup', minutes: 0, seconds: 15));
    _repository.addChrono(new Chrono(name: 'Gainage de face', minutes: 1, seconds: 0));
    _repository.addChrono(new Chrono(name: 'Recup', minutes: 0, seconds: 15));
    _repository.addChrono(new Chrono(name: 'Elévations arrière (10x) OU squats sautés', minutes: 0, seconds: 30));
    _repository.addChrono(new Chrono(name: 'Recup', minutes: 0, seconds: 15));
    _repository.addChrono(new Chrono(name: 'Corde à sauter', minutes: 1, seconds: 0));
    _repository.addChrono(new Chrono(name: 'Fin du bloc 1', minutes: 1, seconds: 0));

    _repository.addChrono(new Chrono(name: 'Début du bloc 2', minutes: 0, seconds: 5));
    _repository.addChrono(new Chrono(name: 'Carré évolutif OU gainage bassin', minutes: 0, seconds: 30));
    _repository.addChrono(new Chrono(name: 'Recup', minutes: 0, seconds: 15));
    _repository.addChrono(new Chrono(name: 'Levés de bassin OU pompes tapés', minutes: 0, seconds: 45));
    _repository.addChrono(new Chrono(name: 'Recup', minutes: 0, seconds: 15));
    _repository.addChrono(new Chrono(name: 'Sauts sur place', minutes: 1, seconds: 0));
    _repository.addChrono(new Chrono(name: 'Recup', minutes: 0, seconds: 15));
    _repository.addChrono(new Chrono(name: 'Arbre à singe OU squats profonds', minutes: 0, seconds: 40));
    _repository.addChrono(new Chrono(name: 'Fin du bloc 2', minutes: 1, seconds: 0));

    
    _repository.addChrono(new Chrono(name: 'Début du bloc 3', minutes: 0, seconds: 5));
    _repository.addChrono(new Chrono(name: 'Fentes kick arrière gauche', minutes: 0, seconds: 30));
    _repository.addChrono(new Chrono(name: 'Fentes kick arrière droite', minutes: 0, seconds: 30));
    _repository.addChrono(new Chrono(name: 'Recup', minutes: 0, seconds: 15));
    _repository.addChrono(new Chrono(name: 'Abdos levés de bassin', minutes: 0, seconds: 45));
    _repository.addChrono(new Chrono(name: 'Recup', minutes: 0, seconds: 15));
    _repository.addChrono(new Chrono(name: 'Squats Beta (15x) OU grimpeur', minutes: 0, seconds: 45));
    _repository.addChrono(new Chrono(name: 'Recup', minutes: 0, seconds: 15));
    _repository.addChrono(new Chrono(name: 'Levés de genoux', minutes: 1, seconds: 0));
    _repository.addChrono(new Chrono(name: 'Fin du bloc 3', minutes: 1, seconds: 0));
  }

  @override
  loadEmptyProfile() {
    _repository.clear();
  }
}
