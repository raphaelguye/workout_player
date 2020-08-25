import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:workout_player/bloc/workout-bloc.dart';
import 'package:workout_player/model/chrono.dart';
import 'package:workout_player/model/profile-repository.dart';
import 'package:workout_player/model/repository.dart';
import 'package:workout_player/shared/material-circle-button.dart';

class ChronoSelector extends StatefulWidget {
  ChronoSelector(
      {Key key,
      @required WorkoutBloc workoutBloc,
      @required Repository repository,
      @required ProfileRepository profileRepository,
      @required double maxHeight})
      : _workoutBloc = workoutBloc,
        _repository = repository,
        _profileRepository = profileRepository,
        _maxHeight = maxHeight,
        super(key: key);

  final WorkoutBloc _workoutBloc;
  final Repository _repository;
  final ProfileRepository _profileRepository;
  final double _maxHeight;

  @override
  _ChronoSelectorState createState() => _ChronoSelectorState(
      workoutBloc: _workoutBloc,
      repository: _repository,
      profileRepository: _profileRepository,
      maxHeight: _maxHeight);
}

class _ChronoSelectorState extends State<ChronoSelector> {
  _ChronoSelectorState(
      {@required WorkoutBloc workoutBloc,
      @required Repository repository,
      @required ProfileRepository profileRepository,
      @required double maxHeight})
      : _workoutBloc = workoutBloc,
        _repository = repository,
        _profileRepository = profileRepository,
        _timersContainerHeightOpened = maxHeight;

  final WorkoutBloc _workoutBloc;
  final Repository _repository;
  final ProfileRepository _profileRepository;
  final double _timersContainerHeightOpened;
  final _chronoTitleTextController = TextEditingController();
  final _workoutTitleTextController = TextEditingController();
  int _chronoTimeMinutes = 0;
  int _chronoTimeSeconds = 0;

  static const double _timersContainerHeightClosed = 90;
  double _timersContainerHeight = _timersContainerHeightClosed;
  bool _isTimersContainerOpened = false;
  bool _isListTimersVisible = false;
  IconData _openCloseIcon = Icons.keyboard_arrow_up;

  @override
  void dispose() {
    _chronoTitleTextController.dispose();
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
                              title = 'My Workout';
                              textStyle = TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white);
                            } else {
                              var nextChrono = _repository.nextChrono(
                                  selectedChrono,
                                  _workoutBloc.isRestartPlaylistEnabled);
                              title = nextChrono == null
                                  ? 'Fin de la série'
                                  : 'À suivre : ${nextChrono.name} (${nextChrono.hoursMinutesFormatted})';
                            }
                            return Row(
                              children: <Widget>[
                                Text(title, style: textStyle),
                                MaterialCircleButton(
                                  buttonDiameter: 40,
                                  color: (Theme.of(context).primaryColor
                                      as MaterialColor)[800],
                                  iconColor: Colors.white,
                                  icon: Icons.save,
                                  onTap: _saveWorkout,
                                  isDisabled: false,
                                  isVisible: _isListTimersVisible,
                                ),
                              ],
                            );
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
                            isVisible: _isListTimersVisible,
                          ),
                          MaterialCircleButton(
                            buttonDiameter: 40,
                            color: (Theme.of(context).primaryColor
                                as MaterialColor)[800],
                            iconColor: Colors.white,
                            icon: Icons.add,
                            onTap: _openNewChronoDialog,
                            isDisabled: false,
                            isVisible: _isListTimersVisible,
                          ),
                          MaterialCircleButton(
                            buttonDiameter: 40,
                            color: (Theme.of(context).primaryColor
                                as MaterialColor)[800],
                            iconColor: Colors.white,
                            icon: _openCloseIcon,
                            onTap: _openTimersList,
                            isDisabled: false,
                            isVisible: true,
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
                  itemCount: _repository.numberOfChronos,
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

  void _saveWorkout() {
    print("saveWorkout");

    showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Sauver votre profile'),
          content: SingleChildScrollView(
              child: Column(children: <Widget>[
            Container(
              child: TextField(
                  controller: _workoutTitleTextController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), labelText: 'Titre')),
              padding: EdgeInsets.only(top: 8),
            ),
          ])),
          actions: <Widget>[
            FlatButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text('Save'),
              onPressed: () {
                var title = _workoutTitleTextController.text ?? 'My Workout';
                _workoutBloc.saveProfile(title);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
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
    var profileTitleSelected = await showDialog<String>(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: const Text('Charger un profile'),
            children: _profileDialogOptions()
          );
        });
    setState(() {
      _workoutBloc.loadProfile(profileTitleSelected);
    });
  }

  List<SimpleDialogOption> _profileDialogOptions() {
    var dialogOptions = new List<SimpleDialogOption>();
    for (var profile in _profileRepository.all()) {
      var dialogOption = new SimpleDialogOption(
        onPressed: () {
          Navigator.pop(context, profile.title);
        },
        child: Text(profile.title),
      );
      dialogOptions.add(dialogOption);
    }
    return dialogOptions;
  }

  Future<void> _openNewChronoDialog() async {
    _chronoTitleTextController.text =
        'Exercice ${_workoutBloc.numberOfChronos + 1}';

    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Ajouter un nouveau chrono'),
          content: SingleChildScrollView(
              child: Column(children: <Widget>[
            Container(
              child: Row(children: <Widget>[
                NumberPicker.integer(
                  initialValue: _chronoTimeMinutes,
                  minValue: 0,
                  maxValue: 59,
                  zeroPad: true,
                  highlightSelectedValue: false,
                  decoration: getNumberPickerBoxDecoration(),
                  listViewWidth: 100,
                  infiniteLoop: true,
                  onChanged: (value) {
                    _chronoTimeMinutes = value;
                  },
                ),
                NumberPicker.integer(
                  initialValue: _chronoTimeSeconds,
                  minValue: 0,
                  maxValue: 59,
                  zeroPad: true,
                  step: 5,
                  highlightSelectedValue: false,
                  decoration: getNumberPickerBoxDecoration(),
                  listViewWidth: 100,
                  infiniteLoop: true,
                  onChanged: (value) {
                    _chronoTimeSeconds = value;
                  },
                ),
              ], mainAxisAlignment: MainAxisAlignment.spaceBetween),
              padding: EdgeInsets.only(bottom: 8),
            ),
            Container(
              child: TextField(
                  controller: _chronoTitleTextController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), labelText: 'Titre')),
              padding: EdgeInsets.only(top: 8),
            ),
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
                var title = _chronoTitleTextController.text ?? 'n/a';
                var newChrono = new Chrono(
                    name: title,
                    minutes: _chronoTimeMinutes,
                    seconds: _chronoTimeSeconds);
                if (newChrono != null) {
                  setState(() {
                    _workoutBloc.addNewChrono(newChrono);
                  });
                }
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  BoxDecoration getNumberPickerBoxDecoration() {
    return BoxDecoration(
      border: Border(
        top: BorderSide(
          style: BorderStyle.solid,
          color: Colors.indigo,
        ),
        bottom: BorderSide(
          style: BorderStyle.solid,
          color: Colors.indigo,
        ),
      ),
    );
  }
}
