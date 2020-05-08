import 'package:attt/storage/storage.dart';
import 'package:attt/utils/alertDialog.dart';
import 'package:attt/utils/globals.dart';
import 'package:attt/view/chewieVideo/widgets/addNote.dart';
import 'package:attt/utils/screenOrientation/landscapeMode.dart';
import 'package:attt/view/chewieVideo/widgets/indicatorsOnVideo.dart';
import 'package:attt/view/chewieVideo/widgets/rest.dart';
import 'package:attt/view/chewieVideo/widgets/getReady.dart';
import 'package:attt/view/trainingPlan/pages/trainingPlan.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_box/video_box.dart';
import 'dart:async';

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
with LandscapeStatefulModeMixin {
  List<String> source = [
    'assets/video/C.mp4',
    'assets/video/C.mp4',
    'assets/video/C.mp4',
    'assets/video/C.mp4',
    'assets/video/warmDown.mp4',
  ];
  VideoController vc;
  VideoPlayerController controller;
  int exerciseDuration,
      exerciseIsReps,
      exerciseReps,
      exerciseSets,
      exerciseRest;
  String exerciseName;
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
      vc.isFullScreen = false;
      vc.initialize();
    }
    _index = nv;
  }

  initializeVariables() {
    exerciseDuration = exerciseSnapshots[index].data['duration'];
    exerciseIsReps = exerciseSnapshots[index].data['isReps'];
    exerciseReps = exerciseSnapshots[index].data['reps'];
    exerciseSets = exerciseSnapshots[index].data['sets'];
    exerciseRest = exerciseSnapshots[index].data['rest'];
    exerciseName = exerciseSnapshots[index].data['name'];
  }

  nextPlay() {
    setState(() {
      index++;
    });
  }

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
    // restGoing = false;
    print(readyGoing.toString() + ' IZ READY ready ');
  }

  showRest(BuildContext context) async {
    if (isTimerDone) {
      vc.pause();
      print('GOTOV SAM BRUDA');
      restGoing = false;
      onlineExercises = [];
      onlineWarmup = [];
      onlineVideos = [];
      exerciseSnapshots = [];
      userNotes = '';
      alertQuit = true;
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          maintainState: false,
          builder: (_) => TrainingPlan(
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
      OverlayEntry overlayEntry = OverlayEntry(
          builder: (BuildContext context) =>
              Visibility(visible: true, child: Rest(rest: exerciseRest)));
      
     
      if(alertQuit) {
         print('No rest, alertQuit');
      } else {
         overlayState.insert(overlayEntry);
      }
      /// add to overlay overlayEntry that is rest widget
      

      /// wait for [rest] time and then remove the overlay widget
      await Future.delayed(Duration(seconds: exerciseRest));
      overlayEntry.remove();
      restGoing = false;
      nextPlay();
    }
  }

  @override
  void initState() {
    super.initState();
    // source = onlineVideos;

    vc = VideoController(
        controllerWidgets: false,
        looping: true,
        autoplay: true, 
        source: VideoPlayerController.asset(source[index]))
      ..initialize();
  }

  @override
  void dispose() {
    super.dispose();
    vc.dispose();
    print('CHEWIE VIDEO DISPOSED');
  }

  @override
  Widget build(BuildContext context) {
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
              child: VideoBox(controller: vc),
            ),
            Positioned(
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
                weekID: widget.weekID
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// [_onWillPop]
  ///
  /// async funstion that creates an exit dialog for our screen
  /// CONTINUE / CANCEL
  Future<bool> _onWillPop() async {
    if (restGoing || readyGoing)
      print('Back button is disabled because REST || READY is active');
    else {
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
            ),
          ) ??
          true;
    }
  }
}
