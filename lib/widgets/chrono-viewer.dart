import 'package:flutter/material.dart';
import 'package:workout_player/bloc/workout-bloc.dart';
import 'package:workout_player/model/chrono.dart';

class ChronoViewer extends StatefulWidget {
  ChronoViewer({Key key, @required WorkoutBloc workoutBloc})
      : _workoutBloc = workoutBloc,
        super(key: key);

  final WorkoutBloc _workoutBloc;

  @override
  _ChronoViewerState createState() =>
      _ChronoViewerState(workoutBloc: _workoutBloc);
}

class _ChronoViewerState extends State<ChronoViewer> {
  _ChronoViewerState({@required WorkoutBloc workoutBloc})
      : _workoutBloc = workoutBloc;

  final WorkoutBloc _workoutBloc;

  @override
  Widget build(BuildContext context) {
    const buttonIconHeight = 35.0;
    const buttonIconMargin = buttonIconHeight / 4;
    return Expanded(
        child: Container(
      color: (Theme.of(context).primaryColor as MaterialColor)[200],
      child: Column(
        children: <Widget>[
          Container(height: buttonIconHeight),
          Expanded(
            child: Align(
                alignment: Alignment.center,
                child: StreamBuilder(
                    stream: _workoutBloc.currentChronoObservable,
                    builder: (context, AsyncSnapshot<dynamic> snapshot) {
                      Chrono currentChrono = snapshot.data;
                      const textStyle =
                          TextStyle(fontSize: 70, color: Colors.black);
                      return currentChrono == null
                          ? new Text('--:--', style: textStyle)
                          : Text('${currentChrono.hoursMinutesFormatted}',
                              style: textStyle);
                    })),
          ),
          Container(
            padding: EdgeInsets.only(right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                GestureDetector(
                  child: Container(
                    color: Colors.transparent,
                    padding: EdgeInsets.all(buttonIconMargin),
                    child: Icon(Icons.all_inclusive,
                        size: buttonIconHeight,
                        color: _workoutBloc.isRestartPlaylistEnabled
                            ? (Theme.of(context).primaryColor
                                as MaterialColor)[800]
                            : (Theme.of(context).primaryColor
                                as MaterialColor)[400]),
                  ),
                  onTap: () {
                    setState(() {
                      _workoutBloc.isRestartPlaylistEnabled =
                          !_workoutBloc.isRestartPlaylistEnabled;
                    });
                  },
                ),
                GestureDetector(
                  child: Container(
                    color: Colors.transparent,
                    padding: EdgeInsets.all(buttonIconMargin),
                    child: Icon(Icons.playlist_play,
                        size: buttonIconHeight,
                        color: _workoutBloc.isAutoPlayEnabled
                            ? (Theme.of(context).primaryColor
                                as MaterialColor)[800]
                            : (Theme.of(context).primaryColor
                                as MaterialColor)[400]),
                  ),
                  onTap: () {
                    setState(() {
                      _workoutBloc.isAutoPlayEnabled =
                          !_workoutBloc.isAutoPlayEnabled;
                    });
                  },
                ),
                GestureDetector(
                  child: Container(
                    color: Colors.transparent,
                    padding: EdgeInsets.all(buttonIconMargin),
                    child: Icon(Icons.vibration,
                        size: buttonIconHeight,
                        color: _workoutBloc.isVibrateEnabled
                            ? (Theme.of(context).primaryColor
                                as MaterialColor)[800]
                            : (Theme.of(context).primaryColor
                                as MaterialColor)[400]),
                  ),
                  onTap: () {
                    setState(() {
                      _workoutBloc.isVibrateEnabled =
                          !_workoutBloc.isVibrateEnabled;
                    });
                  },
                ),
              ],
            ),
          )
        ],
      ),
    ));
  }
}
