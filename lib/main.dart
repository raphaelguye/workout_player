import 'package:flutter/material.dart';
import 'package:workout_player/shared/material-circle-button.dart';
import 'ioc-manager.dart';
import 'bloc/workout-bloc.dart';
import 'model/chrono.dart';
import 'model/repository.dart';

void main() {
  IoCManager.setup();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.teal),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Repository _repository;
  WorkoutBloc _workoutBloc;

  static const double _timersContainerHeightOpened = 500;
  static const double _timersContainerHeightClosed = 90;
  static const double _buttonsSizeBig = 70;
  double _timersContainerHeight = _timersContainerHeightClosed;
  bool _isTimersContainerOpened = false;
  bool _isListTimersVisible = false;
  String _openCloseLabel = 'open';
  IconData _openCloseIcon = Icons.keyboard_arrow_up;
  bool _visible = true;
  double _openPanelStartingPositionY;

  _MyHomePageState() {
    _repository = IoCManager.ioc.get<Repository>();
    _repository.addChrono(
        new Chrono(name: 'Program 1, part 1', minutes: 0, seconds: 2));
    _repository.addChrono(new Chrono(name: 'Rest', minutes: 0, seconds: 2));
    _repository.addChrono(
        new Chrono(name: 'Program 1, part 2', minutes: 0, seconds: 7));
    _repository.addChrono(new Chrono(name: 'Rest', minutes: 0, seconds: 1));
    _repository.addChrono(
        new Chrono(name: 'Program 1, part 3', minutes: 0, seconds: 1));
    _repository.addChrono(new Chrono(name: 'Rest', minutes: 0, seconds: 1));
    _repository.addChrono(
        new Chrono(name: 'Program 2, part 1', minutes: 0, seconds: 1));
    _repository.addChrono(new Chrono(name: 'Rest', minutes: 0, seconds: 1));
    _repository.addChrono(
        new Chrono(name: 'Program 2, part 2', minutes: 0, seconds: 1));
    _repository.addChrono(new Chrono(name: 'Rest', minutes: 0, seconds: 1));
    _repository.addChrono(
        new Chrono(name: 'Program 2, part 3', minutes: 0, seconds: 1));
    _repository.addChrono(new Chrono(name: 'Rest', minutes: 0, seconds: 1));
    _repository.addChrono(
        new Chrono(name: 'Program 2, part 1', minutes: 0, seconds: 1));
    _repository.addChrono(new Chrono(name: 'Rest', minutes: 0, seconds: 1));
    _repository.addChrono(
        new Chrono(name: 'Program 3, part 2', minutes: 0, seconds: 1));
    _repository.addChrono(new Chrono(name: 'Rest', minutes: 0, seconds: 1));
    _repository.addChrono(
        new Chrono(name: 'Program 3, part 3', minutes: 0, seconds: 1));
    // _repository
    //     .addChrono(new Chrono(name: 'Recovery', minutes: 12, seconds: 0));

    _workoutBloc = new WorkoutBloc(_repository);
    _workoutBloc.selectedChrono = _repository.getChrono(0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Workout Player'),
        ),
        body: new Stack(
          children: <Widget>[
            new Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
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
                                    style: TextStyle(
                                        fontSize: 70, color: Colors.black))
                                : Text('${currentChrono.hoursMinutesFormatted}',
                                    style: TextStyle(
                                        fontSize: 70,
                                        color: currentChrono.isOver
                                            ? Colors.white
                                            : Colors.black));
                          })),
                )),
                Expanded(
                  child: Container(
                    color:
                        (Theme.of(context).primaryColor as MaterialColor)[400],
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        // LinearProgressIndicator(),
                        StreamBuilder(
                            stream: _workoutBloc.currentChronoObservable,
                            builder:
                                (context, AsyncSnapshot<dynamic> snapshot) {
                              return snapshot.data == null
                                  ? new Text('-',
                                      style: TextStyle(
                                          fontSize: 30, color: Colors.white))
                                  : new Text(
                                      '${(snapshot.data as Chrono).name}',
                                      style: TextStyle(
                                          fontSize: 30, color: Colors.white));
                            }),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            StreamBuilder(
                                stream: _workoutBloc.isChronoRunningObservable,
                                builder:
                                    (context, AsyncSnapshot<dynamic> snapshot) {
                                  return MaterialCircleButton(
                                      icon: Icons.replay,
                                      buttonDiameter: _buttonsSizeBig,
                                      color: Colors.white,
                                      iconColor: Colors.black,
                                      isDisabled: snapshot.data == true,
                                      onTap: () => _workoutBloc.reset());
                                }),
                            StreamBuilder(
                                stream: _workoutBloc.isChronoRunningObservable,
                                builder:
                                    (context, AsyncSnapshot<dynamic> snapshot) {
                                  return snapshot.data == true
                                      ? MaterialCircleButton(
                                          icon: Icons.pause,
                                          buttonDiameter: _buttonsSizeBig,
                                          color: Colors.white,
                                          iconColor: Colors.black,
                                          isDisabled: false,
                                          onTap: () =>
                                              _workoutBloc.pauseChrono(),
                                        )
                                      : MaterialCircleButton(
                                          icon: Icons.play_arrow,
                                          buttonDiameter: _buttonsSizeBig,
                                          color: Colors.white,
                                          iconColor: Colors.black,
                                          isDisabled: false,
                                          onTap: () =>
                                              _workoutBloc.startChrono(),
                                        );
                                }),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                    onVerticalDragUpdate: onOpeningPanel,
                    onVerticalDragEnd: onEndingToOpenPanel,
                    child: AnimatedContainer(
                        color: (Theme.of(context).primaryColor
                            as MaterialColor)[800],
                        height: _timersContainerHeight,
                        duration: Duration(milliseconds: 500),
                        curve: Curves.easeOut,
                        alignment: Alignment.bottomCenter,
                        padding: EdgeInsets.all(0),
                        child: Column(children: <Widget>[
                          Container(
                              padding: EdgeInsets.only(left: 20, right: 20),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  StreamBuilder(
                                      stream:
                                          _workoutBloc.selectedChronoObservable,
                                      builder: (context,
                                          AsyncSnapshot<dynamic> snapshot) {
                                        // setState(() {
                                        _visible = !_visible;
                                        _visible = !_visible;
                                        // _visible = true;
                                        // });

                                        var selectedChrono = snapshot.data;
                                        var textStyle = TextStyle(
                                            fontSize: 16, color: Colors.white);

                                        if (selectedChrono == null) {
                                          return new Text(
                                              'Select the next step...',
                                              style: textStyle);
                                        }

                                        if (selectedChrono != null) {
                                          var nextChrono = _repository
                                              .nextChrono(selectedChrono);

                                          if (nextChrono != null) {
                                            return new Text(
                                                'Next: ${nextChrono.name} (${nextChrono.hoursMinutesFormatted})',
                                                style: textStyle);
                                          }
                                        }
                                        return new Text('');
                                      }),
                                  FlatButton.icon(
                                      icon: Icon(_openCloseIcon,
                                          color: Colors.white),
                                      label: Text(_openCloseLabel,
                                          style:
                                              TextStyle(color: Colors.white)),
                                      onPressed: () {
                                        _openTimersList();
                                      })
                                ],
                              )),
                          Visibility(
                            visible: _isListTimersVisible,
                            child: Expanded(
                                child: ListView.builder(
                              padding: const EdgeInsets.all(0),
                              itemCount: _repository.chronoLength,
                              itemBuilder: _listViewItemBuilder,
                            )),
                          ),
                        ]))),
              ],
            ),
          ],
        ));
  }

  void onOpeningPanel(DragUpdateDetails dragUpdateDetails) {
    double delta = dragUpdateDetails.delta.dy * -1;
    double newHeight = delta + _timersContainerHeight;
    if (newHeight > _timersContainerHeightOpened) {
      newHeight = _timersContainerHeightOpened;
    }
    if (newHeight < _timersContainerHeightClosed) {
      newHeight = _timersContainerHeightClosed;
    }

    if (newHeight != _timersContainerHeight) {
      setState(() {
        _timersContainerHeight = newHeight;

        _isListTimersVisible =
            _timersContainerHeight > _timersContainerHeightClosed
                ? true
                : false;
      });
    }
  }

  void onEndingToOpenPanel(DragEndDetails dragEndDetails) {
    setState(() {
      _timersContainerHeight =
          _timersContainerHeight > _timersContainerHeightOpened / 2
              ? _timersContainerHeightOpened
              : _timersContainerHeightClosed;

      _isListTimersVisible =
          _timersContainerHeight > _timersContainerHeightClosed ? true : false;
    });
  }

  GestureDetector _listViewItemBuilder(BuildContext context, int index) {
    return GestureDetector(
        onTap: () {
          print('item $index selected');
          setState(() {
            _workoutBloc.selectedChrono = _repository.getChrono(index);
          });
        },
        child: _listViewItemBuilderChild(index));
  }

  StreamBuilder _listViewItemBuilderChild(int index) {
    return new StreamBuilder(
        stream: _workoutBloc.selectedChronoObservable,
        builder: (context, AsyncSnapshot<dynamic> snapshot) {
          Color itemColor =
              (Theme.of(context).primaryColor as MaterialColor)[800];
          Chrono selectedChrono = snapshot.data;
          if (selectedChrono == _repository.getChrono(index)) {
            itemColor = (Theme.of(context).primaryColor as MaterialColor)[600];
          }
          return new Container(
              color: itemColor,
              height: 50,
              child: Center(
                  child: Text(_repository.getChrono(index).toString(),
                      style: TextStyle(color: Colors.white))));
        });
  }

  void _openTimersList() {
    setState(() {
      _isTimersContainerOpened = !_isTimersContainerOpened;

      if (_isTimersContainerOpened) {
        _isListTimersVisible = true;
        _timersContainerHeight = _timersContainerHeightOpened;
        _openCloseLabel = 'close';
        _openCloseIcon = Icons.keyboard_arrow_down;
      } else {
        _isListTimersVisible = false;
        _timersContainerHeight = _timersContainerHeightClosed;
        _openCloseLabel = 'open';
        _openCloseIcon = Icons.keyboard_arrow_up;
      }
    });
  }
}
