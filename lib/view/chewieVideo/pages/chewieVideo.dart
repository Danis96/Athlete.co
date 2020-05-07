import 'package:attt/storage/storage.dart';
import 'package:attt/utils/alertDialog.dart';
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

  nextPlay()  {
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
     setState(() {
        isReady = true;  
     });
  }

  showRest(BuildContext context) async {

    if(isTimerDone) {
      vc.pause();
      isReady = false;
      print('GOTOV SAM BRUDA');
        Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                maintainState: false,
                builder: (_) => TrainingPlan(
                  userDocument: widget.userDocument,
                  userTrainerDocument: widget.userTrainerDocument,
                ),
              ),
            );
      isTimerDone = false;
    } 
    else {
       print('INDEX JE: ' + index.toString());
       print('LISTA JE: ' + (source.length - 1).toString());

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
        nextPlay();
    }    
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
    if (_index == 0 && isReady == false) {
      Timer(Duration(seconds: 1), () {
        vc.pause();
        showGetReady(context);
      });
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
                  showRest: showRest),
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
          ),
        ) ??
        true;
  }
}
