import 'package:flutter/material.dart';
import 'package:workout_player/shared/material-circle-button.dart';
import 'package:workout_player/widgets/ChronoCommander.dart';
import 'package:workout_player/widgets/ChronoViewer.dart';
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
      theme: ThemeData(primarySwatch: Colors.indigo),
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

  static const double _buttonsSizeBig = 70;

  _MyHomePageState() {
    _repository = IoCManager.ioc.get<Repository>();
    _repository.addChrono(
        new Chrono(name: 'Programme 1 - partie 1', minutes: 0, seconds: 30));
    _repository
        .addChrono(new Chrono(name: 'Récupération', minutes: 0, seconds: 45));
    _repository.addChrono(
        new Chrono(name: 'Programme 1 - partie 2', minutes: 0, seconds: 30));
    _repository
        .addChrono(new Chrono(name: 'Récupération', minutes: 0, seconds: 45));
    _repository.addChrono(
        new Chrono(name: 'Programme 1 - partie 3', minutes: 0, seconds: 30));
    _repository
        .addChrono(new Chrono(name: 'Récupération', minutes: 0, seconds: 45));
    _repository.addChrono(
        new Chrono(name: 'Programme 2 - partie 1', minutes: 0, seconds: 30));
    _repository
        .addChrono(new Chrono(name: 'Récupération', minutes: 0, seconds: 45));
    _repository.addChrono(
        new Chrono(name: 'Programme 2 - partie 2', minutes: 0, seconds: 30));
    _repository
        .addChrono(new Chrono(name: 'Récupération', minutes: 0, seconds: 45));
    _repository.addChrono(
        new Chrono(name: 'Programme 2 - partie 3', minutes: 0, seconds: 30));
    _repository
        .addChrono(new Chrono(name: 'Récupération', minutes: 0, seconds: 45));
    _repository.addChrono(
        new Chrono(name: 'Programme 3 - partie 1', minutes: 0, seconds: 30));
    _repository
        .addChrono(new Chrono(name: 'Récupération', minutes: 0, seconds: 45));
    _repository.addChrono(
        new Chrono(name: 'Programme 3 - partie 2', minutes: 0, seconds: 30));
    _repository
        .addChrono(new Chrono(name: 'Récupération', minutes: 0, seconds: 45));
    _repository.addChrono(
        new Chrono(name: 'Programme 3 - partie 3', minutes: 0, seconds: 30));
    _repository.addChrono(
        new Chrono(name: 'Récupération longue', minutes: 12, seconds: 0));

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
                new ChronoViewer(workoutBloc: _workoutBloc),
                new ChronoCommander(
                    workoutBloc: _workoutBloc, buttonsSizeBig: _buttonsSizeBig),
                new ChronoSelector(
                  workoutBloc: _workoutBloc,
                  repository: _repository,
                  maxHeight: MediaQuery.of(context).size.height / 2.2,
                ),
              ],
            ),
          ],
        ));
  }
}

class ChronoSelector extends StatefulWidget {
  ChronoSelector(
      {Key key,
      @required WorkoutBloc workoutBloc,
      @required Repository repository,
      @required double maxHeight})
      : _workoutBloc = workoutBloc,
        _repository = repository,
        _maxHeight = maxHeight,
        super(key: key);

  final WorkoutBloc _workoutBloc;
  final Repository _repository;
  final double _maxHeight;

  @override
  _ChronoSelectorState createState() => _ChronoSelectorState(
      workoutBloc: _workoutBloc,
      repository: _repository,
      maxHeight: _maxHeight);
}

class _ChronoSelectorState extends State<MyHomePage> {
  _ChronoSelectorState(
      {@required WorkoutBloc workoutBloc,
      @required Repository repository,
      @required double maxHeight})
      : _workoutBloc = workoutBloc,
        _repository = repository,
        _timersContainerHeightOpened = maxHeight;

  final WorkoutBloc _workoutBloc;
  final Repository _repository;
  final double _timersContainerHeightOpened;

  static const double _timersContainerHeightClosed = 90;
  double _timersContainerHeight = _timersContainerHeightClosed;
  bool _isTimersContainerOpened = false;
  bool _isListTimersVisible = false;
  IconData _openCloseIcon = Icons.keyboard_arrow_up;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onVerticalDragUpdate: onOpeningPanel,
        onVerticalDragEnd: onEndingToOpenPanel,
        child: AnimatedContainer(
            color: (Theme.of(context).primaryColor as MaterialColor)[800],
            height: _timersContainerHeight,
            duration: Duration(milliseconds: 500),
            curve: Curves.easeOut,
            alignment: Alignment.bottomCenter,
            padding: EdgeInsets.all(0),
            child: Column(children: <Widget>[
              Container(
                  padding: EdgeInsets.only(left: 20, right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      StreamBuilder(
                          stream: _workoutBloc.selectedChronoObservable,
                          builder: (context, AsyncSnapshot<dynamic> snapshot) {
                            var selectedChrono = snapshot.data;
                            var textStyle =
                                TextStyle(fontSize: 14, color: Colors.white);

                            if (selectedChrono == null) {
                              return new Text('Sélectionnez la suite...',
                                  style: textStyle);
                            }

                            if (selectedChrono != null) {
                              var nextChrono =
                                  _repository.nextChrono(selectedChrono);

                              if (nextChrono != null) {
                                return new Text(
                                    'A suivre : ${nextChrono.name} (${nextChrono.hoursMinutesFormatted})',
                                    style: textStyle);
                              }
                            }
                            return new Text('');
                          }),
                      MaterialCircleButton(
                        buttonDiameter: 40,
                        color: (Theme.of(context).primaryColor
                            as MaterialColor)[800],
                        iconColor: Colors.white,
                        icon: _openCloseIcon,
                        onTap: _openTimersList,
                        isDisabled: false,
                      ),
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
            ])));
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

      _openCloseIcon = _timersContainerHeight > _timersContainerHeightClosed
          ? Icons.keyboard_arrow_down
          : Icons.keyboard_arrow_up;

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
        _openCloseIcon = Icons.keyboard_arrow_down;
      } else {
        _isListTimersVisible = false;
        _timersContainerHeight = _timersContainerHeightClosed;
        _openCloseIcon = Icons.keyboard_arrow_up;
      }
    });
  }
}
