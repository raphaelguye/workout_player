import 'package:flutter/material.dart';
import 'package:workout_player/model/chrono.dart';

class Profile {
  String title;
  List<Chrono> chronos;

  Profile({@required this.title, @required this.chronos});
}
