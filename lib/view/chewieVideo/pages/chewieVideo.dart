import 'package:attt/interface/chewieVideoInterface.dart';
import 'package:attt/storage/storage.dart';
import 'package:attt/utils/alertDialog.dart';
import 'package:attt/utils/emptyContainer.dart';
import 'package:attt/utils/fullTrainingStopwatch/fullTrainingStopwatch.dart';
import 'package:attt/utils/globals.dart';
import 'package:attt/utils/screenOrientation/landscapeMode.dart';
import 'package:attt/utils/screenOrientation/portraitMode.dart';
import 'package:attt/view/chewieVideo/widgets/indicatorsOnVideo.dart';
import 'package:attt/view/chewieVideo/widgets/rest.dart';
import 'package:attt/view/chewieVideo/widgets/getReady.dart';
import 'package:attt/view/chewieVideo/widgets/finishWorkout.dart';
import 'package:chewie/chewie.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_box/video_box.dart';
import 'dart:async';
import 'package:attt/utils/size_config.dart';
import 'package:video_box/widgets/buffer_slider.dart';

class ChewieVideo extends StatefulWidget {
  final DocumentSnapshot userDocument, userTrainerDocument;
  final Storage storage;
  final String workoutID, weekID;
  ChewieVideo({
    this.userDocument,
    this.weekID,
    this.userTrainerDocument,
    this.storage,
    this.workoutID,
  });
  @override
  _ChewieVideoState createState() => _ChewieVideoState();
}

class _ChewieVideoState extends State<ChewieVideo>
    implements ChewieVideoInterface {
  List<String> source = [
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
    'assets/video/C.mp4',
    'assets/video/C.mp4',
    'assets/video/C.mp4',
    'assets/video/C.mp4',
    'assets/video/C.mp4',
    'assets/video/C.mp4',
  ];
  VideoController vc;
  VideoPlayerController controller;
  bool _isFull = false;
  int exerciseDuration,
      exerciseIsReps,
      exerciseReps,
      exerciseSets,
      exerciseRest;
  String exerciseName;
  String exerciseSet;
  int _index = 0;
  int get index => _index;
  set index(int nv) {
    if (nv > _index) {
      // +
      nv = nv % source.length;
      vc.autoplay = true;
      controller = VideoPlayerController.asset(source[nv]);
      vc.setSource(controller);
      vc.looping = true;
      vc.bufferColor = Colors.black;
      vc.controllerWidgets = true;

      vc.initialize();
    }
    _index = nv;
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
    print('AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAALLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLL');
    print(exerciseDuration);
    print(exerciseIsReps);
    print(exerciseReps);
    print(exerciseSets);
    print(exerciseRest);
    print(exerciseName);
    print(exerciseSet);
  }

  /// when we want to play next video, we simply set index to increment
  nextPlay() {
    setState(() {
      index++;
    });
  }

  /// getReady Screen taht shows after video start 1 sec
  /// when getReady start we activate [WidgetsBinding.instance.addPostFrameCallback]
  /// this method will set readyGoing variable to true, but after function is built,
  /// because that variable is controll variable for back when ready is on
  ///
  /// then we create overlayState, overlayEntry is [GetReady] screen
  /// then insert GetReady into overlayState
  /// after 5 seconds we remove entry, then set controll variable [getReady] to false
  showGetReady(BuildContext context) async {
    WidgetsBinding.instance.addPostFrameCallback((_) => readyGoing = true);

    /// create overlay
    OverlayState overlayState = Overlay.of(context);
    OverlayEntry overlayEntry = OverlayEntry(
        builder: (BuildContext context) =>
            Visibility(visible: true, child: GetReady()));

    /// add to overlay overlayEntry that is getReady widget
    overlayState.insert(overlayEntry);

    /// wait for [getReady] time and then remove the overlay widget
    await Future.delayed(Duration(seconds: 5));
    overlayEntry.remove();
    isReady = true;
    readyGoing = false;
  }

  /// showRest screen that is showed every time video is changed
  /// here we firstly check for [isTimerDone] (are all videos done playing)
  /// if it is true, we then pause the video, clear all lists, set [alertQuit] to true,
  /// then navigate to TrainingPlan
  /// if it is false,
  /// when showRest start we activate [WidgetsBinding.instance.addPostFrameCallback]
  /// this method will set restGoing variable to true, but after function is built,
  /// because that variable is controll variable for back when ready is on
  ///
  /// then we create overlayState, overlayEntry is [Rest] screen
  /// then insert Rest into overlayState
  /// after time that is predictet for rest, we remove entry,
  /// then set controll variable [restGoing] to false
  /// then call [nextPlay] to play enxt video
  showRest(BuildContext context) async {
    if (isTimerDone) {
      vc.pause();
      print('GOTOV SAM BRUDA');
      restGoing = false;
      onlineExercises = [];
      onlineWarmup = [];
      onlineVideos = [];
      exerciseSnapshots = [];
      alertQuit = true;
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          maintainState: false,
          builder: (_) => FinishWorkout(
            weekID: widget.weekID,
            close: dispose,
            workoutID: widget.workoutID,
            userDocument: widget.userDocument,
            userTrainerDocument: widget.userTrainerDocument,
          ),
        ),
      );
      isReady = false;
      isTimerDone = false;
    } else {
      WidgetsBinding.instance.addPostFrameCallback((_) => restGoing = true);
      print('INDEX JE: ' + index.toString());
      print('LISTA JE: ' + (source.length - 1).toString());

      vc.pause();

      /// create overlay
      OverlayState overlayState = Overlay.of(context);
      OverlayEntry overlayEntryRest;
      overlayEntryRest = OverlayEntry(
          builder: (BuildContext context) => Visibility(
              visible: true,
              child: Rest(
                rest: exerciseRest,
                overlayEntry: overlayEntryRest,
                playNext: nextPlay,
              )));

      /// add to overlay overlayEntry that is rest widget
      if (alertQuit) {
        print('No rest, alertQuit');
      } else {
        overlayState.insert(overlayEntryRest);
      }

      if (isRestSkipped) {
        print('Rest is skipped');
      } else {
        /// wait for [rest] time and then remove the overlay widget
        await Future.delayed(Duration(seconds: exerciseRest));
        overlayEntryRest.remove();
        restGoing = false;
        nextPlay();
      }
    }
  }

  @override
  void initState() {
    super.initState();
    // source = onlineVideos;
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    /// initializing VideoController and giving him source (videos)
    vc = VideoController(
        controllerWidgets: true,
        looping: true,
        autoplay: true,
        source: VideoPlayerController.asset(source[index]))
      // ..addFullScreenChangeListener((c, isFullScreen) async {
      //   print('FULL SCREEN CHANGED TO : ' + isFullScreen.toString());
      //   !isFullScreen
      //       ? SystemChrome.setPreferredOrientations(
      //           [DeviceOrientation.portraitUp])
      //       : SystemChrome.setPreferredOrientations(
      //           [DeviceOrientation.landscapeLeft]);
      // })
      ..initialize();
  }

  /// dispose whole widget and [vc] controller
  @override
  void dispose() {
    super.dispose();
    vc.dispose();
    print('CHEWIE VIDEO DISPOSED');
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    initializeVariables();
    if (alertQuit) {
      print('NO READY, QUIT');
      dispose();
    } else {
      if (_index == 0 && isReady == false) {
        Timer(Duration(seconds: 1), () {
          vc.pause();
          showGetReady(context);
        });
      }
    }

    return Scaffold(
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
                height: SizeConfig.blockSizeVertical * 90,
                child: IndicatorsOnVideo(
                  controller: vc,
                  listLenght: source.length,
                  userDocument: widget.userDocument,
                  userTrainerDocument: widget.userTrainerDocument,
                  index: _index,
                  duration: exerciseDuration,
                  isReps: exerciseIsReps,
                  reps: exerciseReps,
                  sets: exerciseSets,
                  name: exerciseName,
                  showRest: showRest,
                  workoutID: widget.workoutID,
                  weekID: widget.weekID,
                  ctrl: true,
                  rest: exerciseRest,
                  currentSet: exerciseSet,
                  playNext: nextPlay,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  

  DateTime currentBackPressTime;
  /// [_onWillPop]
  ///
  /// async funstion that creates an exit dialog for our screen
  /// CONTINUE / CANCEL
  Future<bool> _onWillPop() async {
    if (restGoing || readyGoing)
      print('Back button is disabled because REST || READY is active');
    else {
      vc.pause();
      DateTime now = DateTime.now();
    if (currentBackPressTime == null || 
        now.difference(currentBackPressTime) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
      return Future.value(false);
    }
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
  }
}
