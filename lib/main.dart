import 'dart:io';

import 'package:flutter/material.dart';
import 'package:workout_player/shared/material-circle-button.dart';

import 'ioc-manager.dart';
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
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
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

  static const double _timersContainerHeightOpened = 500;
  static const double _timersContainerHeightClosed = 90;
  double _timersContainerHeight = _timersContainerHeightClosed;
  bool _isTimersContainerOpened = false;
  bool _isListTimersVisible = false;
  String _openCloseLabel = 'open';
  IconData _openCloseIcon = Icons.keyboard_arrow_up;

  _MyHomePageState() {
    _repository = IoCManager.ioc.get<Repository>();
    _repository.addChrono(
        new Chrono(name: 'Program 1, part 1', minutes: 0, seconds: 30));
    _repository.addChrono(new Chrono(name: 'Rest', minutes: 0, seconds: 45));
    _repository.addChrono(
        new Chrono(name: 'Program 1, part 2', minutes: 0, seconds: 30));
    _repository.addChrono(new Chrono(name: 'Rest', minutes: 0, seconds: 45));
    _repository.addChrono(
        new Chrono(name: 'Program 1, part 3', minutes: 0, seconds: 30));
    _repository.addChrono(new Chrono(name: 'Rest', minutes: 0, seconds: 45));
    _repository.addChrono(
        new Chrono(name: 'Program 2, part 1', minutes: 0, seconds: 30));
    _repository.addChrono(new Chrono(name: 'Rest', minutes: 0, seconds: 45));
    _repository.addChrono(
        new Chrono(name: 'Program 2, part 2', minutes: 0, seconds: 30));
    _repository.addChrono(new Chrono(name: 'Rest', minutes: 0, seconds: 45));
    _repository.addChrono(
        new Chrono(name: 'Program 2, part 3', minutes: 0, seconds: 30));
    _repository.addChrono(new Chrono(name: 'Rest', minutes: 0, seconds: 45));
    _repository.addChrono(
        new Chrono(name: 'Program 2, part 1', minutes: 0, seconds: 30));
    _repository.addChrono(new Chrono(name: 'Rest', minutes: 0, seconds: 45));
    _repository.addChrono(
        new Chrono(name: 'Program 3, part 2', minutes: 0, seconds: 30));
    _repository.addChrono(new Chrono(name: 'Rest', minutes: 0, seconds: 45));
    _repository.addChrono(
        new Chrono(name: 'Program 3, part 3', minutes: 0, seconds: 30));
    _repository
        .addChrono(new Chrono(name: 'Recovery', minutes: 12, seconds: 0));
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
                  color: Colors.teal[200],
                  child: Align(
                    alignment: Alignment.center,
                    child: const Text(
                      '00:30',
                      style: TextStyle(fontSize: 70, color: Colors.black),
                    ),
                  ),
                )),
                Expanded(
                  child: Container(
                    color: Colors.teal[400],
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        // LinearProgressIndicator(),
                        Text(
                          'Serie 1 part 1',
                          style: TextStyle(fontSize: 30, color: Colors.white),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            MaterialCircleButton(
                              icon: Icons.replay,
                              buttonDiameter: 70,
                              onTap: () {
                                print('Replay button tapped');
                              },
                            ),
                            MaterialCircleButton(
                              icon: Icons.play_arrow,
                              buttonDiameter: 70,
                              onTap: () {
                                print('Play button tapped');
                              },
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                AnimatedContainer(
                    color: Colors.teal[800],
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
                              Text('Next: Recovery (00:45)',
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.white)),
                              FlatButton.icon(
                                  icon:
                                      Icon(_openCloseIcon, color: Colors.white),
                                  label: Text(_openCloseLabel,
                                      style: TextStyle(color: Colors.white)),
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
                          itemBuilder: _listViewItemWidget,
                          // separatorBuilder: (BuildContext context, int index) =>
                          //     const Divider(),
                        )),
                      ),
                    ])),
              ],
            ),
          ],
        ));
  }

  Widget _listViewItemWidget(BuildContext context, int index) {
    return Container(
        height: 50,
        child: Center(
            child: Text(_repository.getChrono(index).toString(),
                style: TextStyle(color: Colors.white))));
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
