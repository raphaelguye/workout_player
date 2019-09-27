import 'chrono.dart';

abstract class Repository {
  Chrono getChrono(int index);
  bool addChrono(Chrono chrono);
  bool removeChrono(Chrono chrono);
  int get chronoLength;
  Chrono nextChrono(Chrono chrono);
  Chrono previousChrono(Chrono chrono);
}

class RepositoryImplementation extends Repository {
  List<Chrono> _chronos;

  RepositoryImplementation() {
    _chronos = new List<Chrono>();
  }

  Chrono getChrono(int index) {
    if (index == null || index > _chronos.length - 1) {
      return null;
    }
    return _chronos[index];
  }

  bool addChrono(Chrono chrono) {
    try {
      _chronos.add(chrono);
      return true;
    } catch (exception) {
      print(exception);
      return false;
    }
  }

  bool removeChrono(Chrono chrono) {
    try {
      if (_chronos.contains(chrono)) {
        return true;
      }

      return _chronos.remove(chrono);
    } catch (exception) {
      print(exception);
      return false;
    }
  }

  Chrono nextChrono(Chrono chrono) {
    int numberOfChronosWithANext = chronoLength - 1;
    for (var i = 0; i < numberOfChronosWithANext; i++) {
      if (_chronos[i] == chrono) {
        return _chronos[i + 1];
      }
    }
    return null;
  }

  Chrono previousChrono(Chrono chrono) {
    for (var i = 1; i < chronoLength; i++) {
      if (_chronos[i] == chrono) {
        return _chronos[i - 1];
      }
    }
    return null;
  }

  int get chronoLength => _chronos.length;
}
