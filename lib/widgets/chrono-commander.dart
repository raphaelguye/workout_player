import 'package:flutter/material.dart';
import 'package:workout_player/bloc/workout-bloc.dart';
import 'package:workout_player/model/chrono.dart';
import 'package:workout_player/shared/material-circle-button.dart';

class ChronoCommander extends StatelessWidget {
  const ChronoCommander({
    Key key,
    @required WorkoutBloc workoutBloc,
    @required double buttonsSizeBig,
  })  : _workoutBloc = workoutBloc,
        _buttonsSizeBig = buttonsSizeBig,
        super(key: key);

  final WorkoutBloc _workoutBloc;
  final double _buttonsSizeBig;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        color: (Theme.of(context).primaryColor as MaterialColor)[400],
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            // LinearProgressIndicator(),
            StreamBuilder(
                stream: _workoutBloc.currentChronoObservable,
                builder: (context, AsyncSnapshot<dynamic> snapshot) {
                  return snapshot.data == null
                      ? new Text('-',
                          style: TextStyle(fontSize: 30, color: Colors.white))
                      : new Flexible(
                          child: new Container(
                              padding: new EdgeInsets.all(20),
                              child: new Text(
                                  '${(snapshot.data as Chrono).name}',
                                  style: TextStyle(
                                      fontSize: 30, color: Colors.white))));
                }),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                MaterialCircleButton(
                    icon: Icons.skip_previous,
                    buttonDiameter: _buttonsSizeBig,
                    color: Colors.white,
                    iconColor: Colors.black,
                    isDisabled: false,
                    onTap: () => _workoutBloc.previous()),
                StreamBuilder(
                    stream: _workoutBloc.isChronoRunningObservable,
                    builder: (context, AsyncSnapshot<dynamic> snapshot) {
                      return snapshot.data == true
                          ? MaterialCircleButton(
                              icon: Icons.pause,
                              buttonDiameter: _buttonsSizeBig,
                              color: Colors.white,
                              iconColor: Colors.black,
                              isDisabled: false,
                              onTap: () => _workoutBloc.pauseChrono(),
                            )
                          : MaterialCircleButton(
                              icon: Icons.play_arrow,
                              buttonDiameter: _buttonsSizeBig,
                              color: Colors.white,
                              iconColor: Colors.black,
                              isDisabled: false,
                              onTap: () => _workoutBloc.startChrono(),
                            );
                    }),
                MaterialCircleButton(
                    icon: Icons.skip_next,
                    buttonDiameter: _buttonsSizeBig,
                    color: Colors.white,
                    iconColor: Colors.black,
                    isDisabled: false,
                    onTap: () => _workoutBloc.next()),
              ],
            )
          ],
        ),
      ),
    );
  }
}
