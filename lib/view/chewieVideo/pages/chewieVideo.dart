import 'package:attt/storage/storage.dart';
import 'package:attt/utils/globals.dart';
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
  ChewieVideo({this.userDocument, this.userTrainerDocument, this.storage});
  @override
  _ChewieVideoState createState() => _ChewieVideoState();
}

class _ChewieVideoState extends State<ChewieVideo> {
  List<String> source = [
    'assets/video/C.mp4',
    'assets/video/C.mp4',
    'assets/video/F.mp4',
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
      if (nv > source.length) {
        print('ZADNJIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII');
        exerciseSnapshots = [];
        onlineWarmup = [];
        onlineExercises = [];
        onlineVideos = [];
        Navigator.of(context).push(MaterialPageRoute(
            maintainState: false,
            builder: (_) => TrainingPlan(
                  userTrainerDocument: widget.userTrainerDocument,
                  userDocument: widget.userDocument,
                )));
      } else {
        showRest(context);
      }
      nv = nv % source.length;
      vc.autoplay = true;
      controller = VideoPlayerController.asset(source[nv]);
      vc.setSource(controller);
      vc.looping = true;
      vc.isFullScreen = true;
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
  }

  showRest(BuildContext context) async {
    vc.pause();

    /// create overlay
    OverlayState overlayState = Overlay.of(context);
    OverlayEntry overlayEntry = OverlayEntry(
        builder: (BuildContext context) =>
            Visibility(visible: true, child: Rest(rest: exerciseRest)));

    /// add to overlay overlayEntry that is rest widget
    overlayState.insert(overlayEntry);

    /// wait for [rest] time and then remove the overlay widget
    await Future.delayed(Duration(seconds: exerciseRest));
    overlayEntry.remove();

    /// and play the next video
    //await nextPlay();
  }

  @override
  void initState() {
    super.initState();
    //source = onlineVideos;

    /// when widget inits make that screen rotation
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
    ]);
    vc = VideoController(
        controllerWidgets: false,
        looping: true,
        autoplay: true,
        source: VideoPlayerController.asset(source[index]))
      ..initialize();
  }

  @override
  void dispose() {
    vc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    initializeVariables();
    if (_index == 0) {
      Timer(Duration(seconds: 1), () {
        vc.pause();
        showGetReady(context);
      });
    }
    return Scaffold(
      body: Stack(
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
                showRest: nextPlay),
          ),
        ],
      ),
    );
  }
}
