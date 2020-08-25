import 'chrono.dart';

enum ProfileOld { rock, fitness, extensivePhase, empty }

abstract class ProfileLoader {
  List<Chrono> loadRockProfile();
  List<Chrono> loadFitnessProfile();
  List<Chrono> loadExtensivePhaseProfile();
  List<Chrono> loadEmptyProfile();
}

class ProfileLoaderImplementation extends ProfileLoader {
  ProfileLoaderImplementation();

  @override
  List<Chrono> loadRockProfile() {
    var chronos = List<Chrono>();
    chronos
        .add(new Chrono(name: 'Programme - partie 1', minutes: 0, seconds: 30));
    chronos.add(new Chrono(name: 'Récupération', minutes: 0, seconds: 45));
    chronos
        .add(new Chrono(name: 'Programme - partie 2', minutes: 0, seconds: 30));
    chronos.add(new Chrono(name: 'Récupération', minutes: 0, seconds: 45));
    chronos
        .add(new Chrono(name: 'Programme - partie 3', minutes: 0, seconds: 30));
    chronos.add(new Chrono(name: 'Récupération', minutes: 0, seconds: 45));
    return chronos;
  }

  @override
  List<Chrono> loadFitnessProfile() {
    var chronos = List<Chrono>();
    chronos.add(new Chrono(name: 'Série 1', minutes: 0, seconds: 30));
    chronos.add(new Chrono(name: 'Récupération', minutes: 1, seconds: 0));
    chronos.add(new Chrono(name: 'Série 2', minutes: 0, seconds: 30));
    chronos.add(new Chrono(name: 'Récupération', minutes: 1, seconds: 0));
    chronos.add(new Chrono(name: 'Série 3', minutes: 0, seconds: 30));
    chronos.add(
        new Chrono(name: 'Changement d\'exercice', minutes: 2, seconds: 0));
    return chronos;
  }

  @override
  List<Chrono> loadExtensivePhaseProfile() {
    var chronos = List<Chrono>();
    chronos
        .add(new Chrono(name: 'Filles: 1ère partie', minutes: 0, seconds: 30));
    chronos
        .add(new Chrono(name: 'Filles: 2ème partie', minutes: 0, seconds: 30));
    chronos.add(
        new Chrono(name: 'Chang. filles -> garçons', minutes: 0, seconds: 15));
    chronos
        .add(new Chrono(name: 'Garçons: 1ère partie', minutes: 0, seconds: 30));
    chronos
        .add(new Chrono(name: 'Garçons: 2ème partie', minutes: 0, seconds: 30));
    chronos.add(
        new Chrono(name: 'Changement d\'exercice', minutes: 0, seconds: 15));
    return chronos;
  }

  @override
  List<Chrono> loadEmptyProfile() {
    var chronos = List<Chrono>();
    return chronos;
  }
}
