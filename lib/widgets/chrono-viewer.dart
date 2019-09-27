import 'package:flutter/material.dart';
import 'package:workout_player/bloc/workout-bloc.dart';
import 'package:workout_player/model/chrono.dart';

class ChronoViewer extends StatelessWidget {
  const ChronoViewer({
    Key key,
    @required WorkoutBloc workoutBloc,
  })  : _workoutBloc = workoutBloc,
        super(key: key);

  final WorkoutBloc _workoutBloc;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Container(
      color: (Theme.of(context).primaryColor as MaterialColor)[200],
      child: Align(
          alignment: Alignment.center,
          child: StreamBuilder(
              stream: _workoutBloc.currentChronoObservable,
              builder: (context, AsyncSnapshot<dynamic> snapshot) {
                Chrono currentChrono = snapshot.data;
                return currentChrono == null
                    ? new Text('--:--',
                        style: TextStyle(fontSize: 70, color: Colors.black))
                    : Text('${currentChrono.hoursMinutesFormatted}',
                        style: TextStyle(
                            fontSize: 70,
                            color: currentChrono.isOver
                                ? Colors.white
                                : Colors.black));
              })),
    ));
  }
}
