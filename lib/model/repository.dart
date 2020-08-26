import 'chrono.dart';

abstract class Repository {
  Chrono getChrono(int index);
  bool addChrono(Chrono chrono);
  void addChronos(List<Chrono> chronos);
  bool removeChrono(Chrono chrono);
  int get numberOfChronos;
  List<Chrono> get allChronos;
  List<Chrono> get cloneOfAllChronos;
  bool hasNext(Chrono chrono);
  bool hasPrevious(Chrono chrono);
  Chrono nextChrono(Chrono chrono, bool isRestartPlaylistEnabled);
  Chrono previousChrono(Chrono chrono);
  void clear();
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

  void addChronos(List<Chrono> chronos) {
    if (chronos == null) {
      return;
    }
    for (var chrono in chronos) {
      this.addChrono(chrono);
    }
  }

  bool removeChrono(Chrono chrono) {
    try {
      if (_chronos.contains(chrono)) {
        return _chronos.remove(chrono);
      }
    } catch (exception) {
      print(exception);
    }
    return false;
  }

  void clear() {
    _chronos.clear();
  }

  bool hasNext(Chrono chrono) => nextChrono(chrono, false) != null;
  bool hasPrevious(Chrono chrono) => chrono != _chronos[0];

  Chrono nextChrono(Chrono chrono, bool isRestartPlaylistEnabled) {
    int numberOfChronosWithANext = numberOfChronos - 1;

    Chrono newChrono;
    for (var i = 0; i < numberOfChronosWithANext; i++) {
      if (_chronos[i] == chrono) {
        newChrono = _chronos[i + 1];
        break;
      }
    }

    if (newChrono == null && isRestartPlaylistEnabled) {
      newChrono = _chronos[0];
    }

    return newChrono;
  }

  Chrono previousChrono(Chrono chrono) {
    if (!hasPrevious(chrono)) {
      return _chronos[numberOfChronos - 1];
    }
    for (var i = 1; i < numberOfChronos; i++) {
      if (_chronos[i] == chrono) {
        return _chronos[i - 1];
      }
    }
    return null;
  }

  int get numberOfChronos => _chronos.length;

  List<Chrono> get allChronos => _chronos;

  List<Chrono> get cloneOfAllChronos {
    List<Chrono> clone = new List<Chrono>();
    _chronos.forEach((c) {
      clone.add(c);
    });
    return clone;
  }
}
