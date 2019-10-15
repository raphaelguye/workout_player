import 'package:flutter/material.dart';
import 'package:workout_player/widgets/chrono-commander.dart';
import 'package:workout_player/widgets/chrono-selector.dart';
import 'package:workout_player/widgets/chrono-viewer.dart';
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
                  maxHeight: 250,//MediaQuery.of(context).size.height / 2.2,
                ),
              ],
            ),
          ],
        ));
  }
}
