import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Chrono {
  final String name;
  int minutes;
  int seconds;

  NumberFormat _formatter;

  Chrono(
      {@required this.name, @required this.minutes, @required this.seconds}) {
    this._formatter = new NumberFormat("00");
  }

  bool get isOver => minutes == 0 && seconds == 0;

  void decrease() {
    if (seconds > 0) {
      seconds--;
    } else if (minutes > 0) {
      minutes--;
      seconds = 59;
    }
  }

  @override
  String toString() => "$name - $hoursMinutesFormatted";

  String get hoursMinutesFormatted =>
      "${this._formatter.format(minutes)}:${this._formatter.format(seconds)}";

  Chrono clone() => new Chrono(name: name, minutes: minutes, seconds: seconds);
}
