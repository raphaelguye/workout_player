import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:workout_player/bloc/workout-bloc.dart';
import 'package:workout_player/ioc-manager.dart';
import 'package:workout_player/model/profile-loader.dart';
import 'package:workout_player/model/repository.dart';
import 'package:workout_player/widgets/chrono-commander.dart';
import 'package:workout_player/widgets/chrono-selector.dart';
import 'package:workout_player/widgets/chrono-viewer.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  IoCManager.setup();
  runApp(new MyApp());
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
  ProfileLoader _profileLoader;

  static const double _buttonsSizeBig = 70;

  _MyHomePageState() {
    _repository = IoCManager.ioc.get<Repository>();
    _profileLoader = IoCManager.ioc.get<ProfileLoader>();
    _workoutBloc = new WorkoutBloc(_repository, _profileLoader);
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
                  maxHeight: 350, //MediaQuery.of(context).size.height / 2.2,
                ),
              ],
            ),
          ],
        ));
  }
}
