import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Chrono {
  String name;
  int minutes;
  int seconds;

  NumberFormat _formatter;

  Chrono(
      {@required this.name, @required this.minutes, @required this.seconds}) {
    this._formatter = new NumberFormat("00");
    if (this.minutes > 59 || this.minutes < 0) {
      throw ("minutes must be set between 0 and 59");
    }
    if (this.seconds > 59 || this.seconds < 0) {
      throw ("seconds must be set between 0 and 59");
    }
  }

  static Chrono fromRawData(String rawName, String rawTime) {
    try {
      var array = rawTime.split(":");
      int minutes;
      int seconds;

      if (array.length == 1) {
        minutes = 0;
        seconds = int.parse(rawTime);
      } else if (array.length == 2) {
        minutes = int.parse(array[0]);
        seconds = int.parse(array[1]);
      } else {
        throw ("time format invalid");
      }

      var newChrono = Chrono(name: rawName, minutes: minutes, seconds: seconds);
      return newChrono;
    } catch (e) {
      print(e.toString());
      return null;
    }
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

  bool isEqualTo(Chrono chrono) {
    return chrono is Chrono && chrono.minutes == minutes && chrono.seconds == seconds;
  }

  String get hoursMinutesFormatted =>
      "${this._formatter.format(minutes)}:${this._formatter.format(seconds)}";

  Chrono clone() => new Chrono(name: name, minutes: minutes, seconds: seconds);
}
