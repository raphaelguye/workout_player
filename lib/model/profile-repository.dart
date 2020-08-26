import 'package:workout_player/model/profile-loader.dart';
import 'package:workout_player/model/profile.dart';

abstract class ProfileRepository {
  List<Profile> all();
  bool saveProfile(Profile profile);
  Profile loadProfile(String title);
}

class ProfileRepositoryImplementation extends ProfileRepository {
  final ProfileLoader _profileLoader;
  List<Profile> _profiles;

  ProfileRepositoryImplementation(this._profileLoader) {
    _profiles = new List<Profile>();
    _profiles.add(
        new Profile(chronos: _profileLoader.loadRockProfile(), title: "Rock"));
    _profiles.add(new Profile(
        chronos: _profileLoader.loadExtensivePhaseProfile(),
        title: "Phase extensive"));
    _profiles.add(
        new Profile(chronos: _profileLoader.loadEmptyProfile(), title: "Vide"));
  }

  List<Profile> all() {
    return _profiles;
  }

  bool saveProfile(Profile profile) {
    try {
      _profiles.add(profile);
      return true;
    } catch (exception) {
      print(exception);
      return false;
    }
  }

  Profile loadProfile(String title) {
    if (_profiles.length > 0) {
      var result = _profiles.where((p) => p.title == title);
      if (result.length > 0) {
        return result.first;
      }
    }
    return null;
  }
}
