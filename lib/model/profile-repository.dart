import 'package:workout_player/model/profile.dart';

abstract class ProfileRepository {
  List<Profile> all();
  bool saveProfile(Profile profile);
  Profile loadProfile(String title);
}

class ProfileRepositoryImplementation extends ProfileRepository {
  ProfileRepositoryImplementation();

  List<Profile> all() {
    return new List<Profile>();
  }

  bool saveProfile(Profile profile) {
    return false;
  }

  Profile loadProfile(String title) {
    return null;
  }
}
