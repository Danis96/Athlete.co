import 'dart:ui';
import 'package:attt/interface/chewieVideoInterface.dart';
import 'package:attt/utils/alertDialog.dart';
import 'package:attt/utils/colors.dart';
import 'package:attt/utils/emptyContainer.dart';
import 'package:attt/utils/fullTrainingStopwatch/fullTrainingStopwatch.dart';
import 'package:attt/utils/globals.dart';
import 'package:attt/view/chewieVideo/widgets/finishButton.dart';
import 'package:attt/view/chewieVideo/widgets/finishWorkout.dart';
import 'package:attt/view/chewieVideo/widgets/indicatorsOnVideo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_box/video_box.dart';
import 'dart:async';
import 'package:attt/utils/size_config.dart';
import 'package:flutter_picker/flutter_picker.dart';

class ChewieVideo extends StatefulWidget {
  final DocumentSnapshot userDocument, userTrainerDocument;
  final String workoutID, weekID;
  final bool finishedWorkout;
  ChewieVideo({
    this.userDocument,
    this.weekID,
    this.userTrainerDocument,
    this.workoutID,
    this.finishedWorkout,
  });
  @override
  _ChewieVideoState createState() => _ChewieVideoState();
}

class _ChewieVideoState extends State<ChewieVideo>
    with WidgetsBindingObserver
    implements ChewieVideoInterface {
  List<String> source = [
    'assets/video/F.mp4',
    'assets/video/C.mp4',
    'assets/video/F.mp4',
    'assets/video/F.mp4',
    'assets/video/C.mp4',
    'assets/video/F.mp4',
    'assets/video/C.mp4',
    'assets/video/C.mp4',
    'assets/video/C.mp4',
    'assets/video/C.mp4',
    'assets/video/C.mp4',
    'assets/video/C.mp4',
    'assets/video/C.mp4',
    'assets/video/C.mp4',
    'assets/video/C.mp4',
    'assets/video/C.mp4',
    'assets/video/C.mp4',
    'assets/video/C.mp4',
    'assets/video/C.mp4',
    'assets/video/C.mp4',
    'assets/video/C.mp4',
  ];
  VideoController vc;
  VideoPlayerController controller;
  int exerciseDuration,
      exerciseIsReps,
      exerciseReps,
      exerciseSets,
      exerciseRest;
  String exerciseName, exerciseRepsDescription;
  String exerciseSet;
  int _index = 0;
  int get index => _index;
  set index(int nv) {
    // if (nv > _index) {
    // +
    nv = nv % source.length;
    vc.autoplay = false;
    controller = VideoPlayerController.asset(source[nv]);
    vc.setSource(controller);
    vc.looping = true;
    vc.bufferColor = Colors.black;
    vc.cover = Container(
      child: Image.asset('assets/images/ar.jpg'),
    );
    vc.controllerWidgets = true;

    vc.initialize();
    // }
    _index = nv;
  }

  /// minutes for timer and seconds
  String _currentMinutes, _currentSeconds;
  List<dynamic> time = [];
  String timeToSplit;
  var ms;

  showPickerNumber(BuildContext context) {
    new Picker(
            textStyle: TextStyle(color: Colors.black),
            adapter: NumberPickerAdapter(data: [
              NumberPickerColumn(
                  onFormatValue: (v) {
                    return v < 10 ? "0$v" : "$v";
                  },
                  begin: 1,
                  end: 59,
                  suffix: Text(
                    'min',
                    style: TextStyle(
                        fontSize: MediaQuery.of(context).orientation ==
                                Orientation.landscape
                            ? SizeConfig.safeBlockHorizontal * 1.5
                            : SizeConfig.safeBlockHorizontal * 3),
                  )),
              NumberPickerColumn(
                  onFormatValue: (v) {
                    return v < 10 ? "0$v" : "$v";
                  },
                  begin: 1,
                  end: 60,
                  suffix: Text(
                    'sec',
                    style: TextStyle(
                        fontSize: MediaQuery.of(context).orientation ==
                                Orientation.landscape
                            ? SizeConfig.safeBlockHorizontal * 1.5
                            : SizeConfig.safeBlockHorizontal * 3),
                  )),
            ]),
            delimiter: [
              PickerDelimiter(
                  child: Container(
                color: MyColors().white,
                width: 30.0,
                alignment: Alignment.center,
                child: Icon(Icons.watch),
              ))
            ],
            cancelText: 'Reset',
            cancelTextStyle: TextStyle(
                color: Colors.red,
                fontSize:
                    MediaQuery.of(context).orientation == Orientation.landscape
                        ? SizeConfig.safeBlockHorizontal * 3
                        : SizeConfig.safeBlockHorizontal * 4),
            confirmText: 'Done',
            confirmTextStyle: TextStyle(
                color: Colors.green,
                fontSize:
                    MediaQuery.of(context).orientation == Orientation.landscape
                        ? SizeConfig.safeBlockHorizontal * 3
                        : SizeConfig.safeBlockHorizontal * 4),
            hideHeader: true,
            title: new Text(
              "Choose your time",
              style: TextStyle(
                  color: MyColors().lightBlack,
                  fontSize: MediaQuery.of(context).orientation ==
                          Orientation.landscape
                      ? SizeConfig.safeBlockHorizontal * 3
                      : SizeConfig.safeBlockHorizontal * 5),
            ),
            onSelect: (Picker picker, int index, List<int> selecteds) {
              this.setState(() {
                resetFromChewie = false;
              });
            },
            onConfirm: (Picker picker, List<int> value) {
              timeToSplit = picker.getSelectedValues().toString();
              String min = timeToSplit[1] +
                  (timeToSplit[2] == ',' ? '' : timeToSplit[2]);
              setState(() => minutesForIndicators = int.parse(min));
              print('Minutes: ' + minutesForIndicators.toString());
              String sec = minutesForIndicators > 10
                  ? timeToSplit[5] +
                      (timeToSplit[6] == ']' ? '' : timeToSplit[6])
                  : timeToSplit[4] +
                      (timeToSplit[5] == ']' ? '' : timeToSplit[5]);
              setState(() {
                secondsForIndicators = int.parse(sec);
                isTimeChoosed = true;
                resetFromChewie = false;
              });
              print('Seconds: ' + secondsForIndicators.toString());
            },
            onCancel: () {
              setState(() => resetFromChewie = true);
            },
            magnification: 1.5)
        .showDialog(context);
  }

  /// [_onWillPop]
  ///
  /// async funstion that creates an exit dialog for our screen
  /// CONTINUE / CANCEL
  Future<bool> _onWillPop() async {
    setState(() {
      activatePause = true;
    });
    vc.pause();
    return showDialog(
          context: context,
          builder: (context) => MyAlertDialog(
            no: 'Cancel',
            yes: 'Continue',
            title: 'Back to Training plan?',
            content: 'If you go back all your progress will be lost',
            userDocument: widget.userDocument,
            userTrainerDocument: widget.userTrainerDocument,
            vc: vc,
            close: dispose,
            isReps: exerciseIsReps,
          ),
        ) ??
        true;
  }

  /// populate variables with exercise info
  initializeVariables() {
    String exerciseNameAndSet = namesWithSet[index];
    exerciseDuration = workoutExercisesWithSets[index].data['duration'];
    exerciseIsReps = workoutExercisesWithSets[index].data['isReps'];
    exerciseReps = workoutExercisesWithSets[index].data['reps'];
    exerciseSets = workoutExercisesWithSets[index].data['sets'];
    exerciseRest = workoutExercisesWithSets[index].data['rest'];
    exerciseName = exerciseNameAndSet.split('_')[1];
    exerciseSet = exerciseNameAndSet.split('_')[0];
    exerciseRepsDescription =
        workoutExercisesWithSets[index].data['repsDescription'];
  }

  /// when we want to play next video, we simply set index to increment
  nextPlay() {
    if (index == source.length - 1) {
      finishWorkout();
    } else {
      setState(() {
        index++;
        isPrevious = true;
      });
    }
  }

  finishWorkout() {
    onlineExercises = [];
    onlineWarmup = [];
    onlineVideos = [];
    exerciseSnapshots = [];
    alertQuit = true;
    FullTrainingStopwatch().stopStopwtach();
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        maintainState: false,
        builder: (_) => FinishWorkout(
          weekID: widget.weekID,
          close: dispose,
          workoutID: widget.workoutID,
          userDocument: widget.userDocument,
          userTrainerDocument: widget.userTrainerDocument,
          finishedWorkout: widget.finishedWorkout,
        ),
      ),
    );
  }

  /// when we want to play previous video, we simply set index to decrement
  previousPlay() {
    setState(() {
      index = index - 1;
    });
  }

  @override
  void initState() {
    super.initState();
    // source = onlineVideos;
    WidgetsBinding.instance.addObserver(this);

    /// initializing VideoController and giving him source (videos)
    vc = VideoController(
        controllerWidgets: true,
        looping: true,
        autoplay: false,
        cover: Container(
          child: Image.asset('assets/images/ar.jpg'),
        ),
        source: VideoPlayerController.asset(source[index]))
      ..initialize();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight
    ]);
  }

  /// dispose whole widget and [vc] controller
  @override
  void dispose() {
    super.dispose();
    vc.dispose();
    WidgetsBinding.instance.removeObserver(this);
    print('CHEWIE VIDEO DISPOSED');
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    initializeVariables();

    return Scaffold(
      bottomNavigationBar: index == source.length - 1
          ? finishButton(nextPlay, context, index, source.length)
          : EmptyContainer(),
      body: WillPopScope(
        onWillPop: () => _onWillPop(),
        child: Stack(
          children: <Widget>[
            Center(
              /// video / beforeChildren / controllerWidgets-> children / afterChildren
              child: VideoBox(
                controller: vc,
              ),
            ),
            Positioned(
              child: Container(
                height:
                    MediaQuery.of(context).orientation == Orientation.portrait
                        ? index == source.length - 1
                            ? SizeConfig.blockSizeVertical * 92
                            : SizeConfig.blockSizeVertical * 95
                        : SizeConfig.blockSizeVertical * 92,
                child: IndicatorsOnVideo(
                  controller: vc,
                  listLenght: source.length,
                  userDocument: widget.userDocument,
                  userTrainerDocument: widget.userTrainerDocument,
                  index: _index,
                  isReps: exerciseIsReps,
                  reps: exerciseReps,
                  sets: exerciseSets,
                  name: exerciseName,
                  workoutID: widget.workoutID,
                  weekID: widget.weekID,
                  ctrl: true,
                  currentSet: exerciseSet,
                  playNext: nextPlay,
                  playPrevious: previousPlay,
                  repsDescription: exerciseRepsDescription,
                  onWill: _onWillPop,
                  showTimerDialog: showPickerNumber,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  showRest(BuildContext context, String toPlay) {
//    // TODO: implement showRest
//    throw UnimplementedError();
  }
}
