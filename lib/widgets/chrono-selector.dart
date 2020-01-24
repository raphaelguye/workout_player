import 'package:flutter/material.dart';
import 'package:workout_player/bloc/workout-bloc.dart';
import 'package:workout_player/model/chrono.dart';
import 'package:workout_player/model/profile-loader.dart';
import 'package:workout_player/model/repository.dart';
import 'package:workout_player/shared/material-circle-button.dart';

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

class _ChronoSelectorState extends State<ChronoSelector> {
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
  final _chronoTitleTextController = TextEditingController();
  final _chronoTimeTextController = TextEditingController();

  static const double _timersContainerHeightClosed = 90;
  double _timersContainerHeight = _timersContainerHeightClosed;
  bool _isTimersContainerOpened = false;
  bool _isListTimersVisible = false;
  IconData _openCloseIcon = Icons.keyboard_arrow_up;

  @override
  void dispose() {
    _chronoTitleTextController.dispose();
    _chronoTimeTextController.dispose();
    super.dispose();
  }

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
                            var title = '';

                            if (selectedChrono == null) {
                              title = 'Sélectionnez la suite...';
                            } else if (_isListTimersVisible) {
                              title = 'À suivre';
                              textStyle = TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white);
                            } else {
                              var nextChrono =
                                  _repository.nextChrono(selectedChrono);
                              title = nextChrono == null
                                  ? 'Fin de la série'
                                  : 'À suivre : ${nextChrono.name} (${nextChrono.hoursMinutesFormatted})';
                            }
                            return new Flexible(
                                child: Text(title, style: textStyle));
                          }),
                      Row(
                        children: <Widget>[
                          MaterialCircleButton(
                            buttonDiameter: 40,
                            color: (Theme.of(context).primaryColor
                                as MaterialColor)[800],
                            iconColor: Colors.white,
                            icon: Icons.library_books,
                            onTap: _openLoadProfileDialog,
                            isDisabled: false,
                          ),
                          MaterialCircleButton(
                            buttonDiameter: 40,
                            color: (Theme.of(context).primaryColor
                                as MaterialColor)[800],
                            iconColor: Colors.white,
                            icon: Icons.add,
                            onTap: _openNewChronoDialog,
                            isDisabled: false,
                          ),
                          MaterialCircleButton(
                            buttonDiameter: 40,
                            color: (Theme.of(context).primaryColor
                                as MaterialColor)[800],
                            iconColor: Colors.white,
                            icon: _openCloseIcon,
                            onTap: _openTimersList,
                            isDisabled: false,
                          )
                        ],
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

  Dismissible _listViewItemBuilder(BuildContext context, int index) {
    final chrono = _repository.getChrono(index);

    // Source: https://flutter.dev/docs/cookbook/gestures/dismissible
    return Dismissible(
      key: Key(chrono.hashCode.toString()),
      onDismissed: (direction) {
        setState(() {
          _workoutBloc.remove(chrono);
        });
      },
      background: Container(
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 20.0),
        color: Colors.red,
        child: Icon(
          Icons.delete,
          color: Colors.white,
        ),
      ),
      child: GestureDetector(
          onTap: () {
            print('item $index selected');
            setState(() {
              _workoutBloc.selectedChrono = _repository.getChrono(index);
            });
          },
          child: _listViewItemBuilderChild(index)),
    );
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

  Future<void> _openLoadProfileDialog() async {
    var profileSelected = await showDialog<Profile>(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: const Text('Sélectionnez un profile à charger'),
            children: <Widget>[
              SimpleDialogOption(
                onPressed: () {
                  Navigator.pop(context, Profile.rock);
                },
                child: const Text("Rock'n'roll séries"),
              ),
              SimpleDialogOption(
                onPressed: () {
                  Navigator.pop(context, Profile.fitness);
                },
                child: const Text('Fitness répétitions'),
              ),
              SimpleDialogOption(
                onPressed: () {
                  Navigator.pop(context, Profile.extensivePhase);
                },
                child: const Text('Renforcement phase extensive'),
              ),
              SimpleDialogOption(
                onPressed: () {
                  Navigator.pop(context, Profile.empty);
                },
                child: const Text('Vide'),
              ),
            ],
          );
        });

    setState(() {
      _workoutBloc.loadProfile(profileSelected);
    });
  }

  Future<void> _openNewChronoDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Ajouter un nouveau chrono'),
          content: SingleChildScrollView(
              child: Column(children: <Widget>[
            Container(
              child: TextField(
                  controller: _chronoTitleTextController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), labelText: 'Intitulé')),
              padding: EdgeInsets.only(bottom: 8),
            ),
            Container(
              child: TextField(
                controller: _chronoTimeTextController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Temps (mm:ss ou ss)"),
              ),
              padding: EdgeInsets.only(top: 8),
            )
          ])),
          actions: <Widget>[
            FlatButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text('Add'),
              onPressed: () {
                var rawName = _chronoTitleTextController.text;
                var rawTime = _chronoTimeTextController.text;

                if (rawName != null &&
                    rawName != "" &&
                    rawTime != null &&
                    rawTime != "") {
                  var newChrono = Chrono.fromRawData(rawName, rawTime);
                  if (newChrono != null) {
                    setState(() {
                      _workoutBloc.addNewChrono(newChrono);
                    });
                  }
                }

                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
