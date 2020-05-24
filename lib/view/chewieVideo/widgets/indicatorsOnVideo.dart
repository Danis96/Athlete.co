import 'dart:async';
import 'dart:ui';
import 'package:attt/utils/emptyContainer.dart';
import 'package:attt/utils/globals.dart';
import 'package:attt/view/chewieVideo/widgets/indicatorWidgets/asManyReps.dart';
import 'package:attt/view/chewieVideo/widgets/indicatorWidgets/clearButton.dart';
import 'package:attt/view/chewieVideo/widgets/indicatorWidgets/fullscreenButton.dart';
import 'package:attt/view/chewieVideo/widgets/indicatorWidgets/nameWidget.dart';
import 'package:attt/view/chewieVideo/widgets/indicatorWidgets/nextbutton.dart';
import 'package:attt/view/chewieVideo/widgets/indicatorWidgets/noteButton.dart';
import 'package:attt/view/chewieVideo/widgets/indicatorWidgets/previousButton.dart';
import 'package:attt/view/chewieVideo/widgets/indicatorWidgets/repsWidget.dart';
import 'package:attt/view/chewieVideo/widgets/indicatorWidgets/setsWidget.dart';
import 'package:attt/view/chewieVideo/widgets/indicatorWidgets/timerWidget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quiver/async.dart';
import 'package:video_box/video.controller.dart';
import 'package:attt/utils/size_config.dart';

class IndicatorsOnVideo extends StatefulWidget {
  final VideoController controller;
  final DocumentSnapshot userDocument, userTrainerDocument;
  final int index, listLenght;
  final Function showAddNote, playNext, playPrevious, onWill, showTimerDialog;
  final int isReps, sets, reps;
  final String name, workoutID, weekID, currentSet, repsDescription;
  final bool ctrl;

  IndicatorsOnVideo(
      {this.controller,
      this.currentSet,
      this.repsDescription,
      this.showAddNote,
      this.workoutID,
      this.playPrevious,
      this.playNext,
      this.listLenght,
      this.weekID,
      this.name,
      this.sets,
      this.reps,
      this.isReps,
      this.index,
      this.userTrainerDocument,
      this.userDocument,
      this.ctrl,
      this.onWill,
      this.showTimerDialog});

  @override
  _IndicatorsOnVideoState createState() => _IndicatorsOnVideoState();
}

class _IndicatorsOnVideoState extends State<IndicatorsOnVideo>
    with TickerProviderStateMixin, WidgetsBindingObserver {
  AnimationController _controller;
  Animation<Offset> _offsetAnimation;
  bool isOrientation = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    )..forward();

    _offsetAnimation = Tween<Offset>(
      begin: const Offset(0.8, 0.0),
      end: const Offset(0.0, 0.0),
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    /// check if countDown is running ,
    /// if it is RESET IT
    checkIsCountDownRunning();
  }

  /// here it is where we check for the state of the app
  /// as I was doing research for the minimize and working
  /// of the app in the background I
  /// learned that every app has 4 states
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    switch (state) {

      /// this state of the app activates first when the app
      /// is going into the background
      case AppLifecycleState.inactive:
        print('Inactive');
        break;

      /// if app is in background we want to
      /// pause timer if it is going and
      /// pause the video
      case AppLifecycleState.paused:
        print('Paused');
        checkIsOnTimeAndPauseTimer();
        if (widget.controller.value.isPlaying) widget.controller.pause();
        break;

      /// when the app is back into foreground
      /// we want to start the timer  and
      /// start the video
      case AppLifecycleState.resumed:
        print('Resumed');
        if (isTimerPaused) {
          startTimer(_pausedOn);
        }
        if(!widget.controller.value.isPlaying) widget.controller.play();
        break;

        /// when the app is in the foreground but it is not
      case AppLifecycleState.detached:
        print('Detached');
        break;
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _controller.dispose();
    super.dispose();
  }

  /// for displaying the current time
  Duration _current = Duration();

  /// when we pause video/timer we want to get the current time
  Duration _pausedOn = Duration();

  /// initial calue of [d1] => before we choose the time in dialog
  var d1 =
      Duration(minutes: minutesForIndicators, seconds: secondsForIndicators);

  /// function for formating duration
  format(Duration d) => d.toString().substring(2, 7);

  /// instance for [CountDownTimer]
  CountdownTimer countDownTimer;

  /// here we create new instance of [CountDownTimer],
  /// and we set the [d1] variable (after we have choose the time)
  ///
  /// then create listener and add value to [_current] for displaying the time
  void startTimer(Duration dur) {
    countDownTimer = new CountdownTimer(
      new Duration(seconds: dur.inSeconds),
      new Duration(seconds: 1),
    );

    var sub = countDownTimer.listen(null);
    sub.onData((duration) {
      setState(() {
        _current =
            Duration(seconds: dur.inSeconds - duration.elapsed.inSeconds);
      });
    });

    /// when timer is done activate this
    sub.onDone(() {
      print("Done");
      countDownTimer.cancel();
      sub.cancel();
    });
    isTimeChoosed = false;
    isTimerPaused = false;
  }

  /// activates every time the widget is changed
  @override
  void didUpdateWidget(IndicatorsOnVideo oldWidget) {
    print('DOLAZIM IZ DIDUPDATEWIDGET ');
    super.didUpdateWidget(oldWidget);

    /// if time is choosed  set the minutes and seconds that user choosed
    /// into duration [d1] variable
    if (isTimeChoosed) {
      d1 = Duration(
          minutes: minutesForIndicators, seconds: secondsForIndicators);
    }
    if (activatePause) {
      checkIsOnTimeAndPauseTimer();
    }
    if (resetFromChewie) {
      resetTimer();
    }

    resetFromChewie = false;
    activatePause = false;
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SlideTransition(
        position: _offsetAnimation,
        child: InkWell(
          onTap: () {
            pauseAndPlayFunction();
            isTips = false;
          },
          child: Padding(
            padding: EdgeInsets.only(
                top: SizeConfig.blockSizeVertical * 1,
                left: SizeConfig.blockSizeHorizontal * 3,
                right: SizeConfig.blockSizeVertical * 3),
            child: Container(
              margin: EdgeInsets.only(
                  top: MediaQuery.of(context).orientation ==
                          Orientation.landscape
                      ? SizeConfig.blockSizeVertical * 0
                      : SizeConfig.blockSizeVertical * 2),
              child: Center(
                child: Stack(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        /// icon note
                        noteButton(
                            context,
                            noteClicked,
                            isFromPortrait,
                            widget.controller,
                            checkIsOnTimeAndPauseTimer,
                            widget.userDocument,
                            widget.userTrainerDocument,
                            widget.index,
                            widget.listLenght,
                            widget.isReps,
                            widget.sets,
                            widget.reps,
                            widget.name,
                            widget.workoutID,
                            widget.weekID),
                        clearIcon(
                            context, checkIsOnTimeAndPauseTimer, widget.onWill),
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          top: MediaQuery.of(context).orientation ==
                                  Orientation.landscape
                              ? widget.index == (widget.listLenght - 1)
                                  ? SizeConfig.blockSizeVertical * 30
                                  : SizeConfig.blockSizeVertical * 43
                              : SizeConfig.blockSizeVertical * 43),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          widget.index == 0
                              ? EmptyContainer()
                              : previousButton(
                                  context, resetTimer, widget.playPrevious),
                          widget.index == (widget.listLenght - 1)
                              ? EmptyContainer()
                              : nextButton(
                                  context, resetTimer, widget.playNext, widget.controller),
                        ],
                      ),
                    ),
                    Center(
                      child: Container(
                        margin: EdgeInsets.only(
                          top: MediaQuery.of(context).orientation ==
                                  Orientation.landscape
                              ? widget.index == (widget.listLenght - 1)
                                  ? SizeConfig.blockSizeVertical * 30
                                  : SizeConfig.blockSizeVertical * 46
                              : SizeConfig.blockSizeVertical * 43,
                          right: MediaQuery.of(context).orientation ==
                                  Orientation.landscape
                              ? SizeConfig.blockSizeHorizontal * 40
                              : SizeConfig.blockSizeHorizontal * 0,
                        ),
                        child: Stack(
                          children: <Widget>[
                            /// reps or timer,
                            /// depend on the exercise type
                            widget.isReps == 0
                                ? repsWidget(
                                    context, widget.isReps, widget.reps)
                                : timerWidget(
                                    context,
                                    widget.showTimerDialog,
                                    format,
                                    widget.controller,
                                    isTimerPaused,
                                    _current,
                                    _pausedOn,
                                    countDownTimer),

                            /// as many reps description
                            widget.repsDescription == 'as many reps as possible'
                                ? asManyReps(context)
                                : EmptyContainer(),

                            /// name widget,
                            /// here you can click to go on info about specific exercise
                            nameWidget(
                              infoClicked,
                              goBackToChewie,
                              isFromPortrait,
                              context,
                              widget.controller,
                              checkIsOnTimeAndPauseTimer,
                              widget.name,
                              exVideo,
                              exTips,
                              widget.isReps,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        top: MediaQuery.of(context).orientation ==
                                Orientation.landscape
                            ? widget.index == (widget.listLenght - 1)
                                ? SizeConfig.blockSizeVertical * 68
                                : SizeConfig.blockSizeVertical * 80
                            : widget.index == (widget.listLenght - 1)
                                ? SizeConfig.blockSizeVertical * 82
                                : SizeConfig.blockSizeVertical * 87,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          setsWidget(context, widget.currentSet, widget.sets),

                          /// fullScreen button on indicators
                          /// it takes:
                          /// context
                          /// isReps
                          /// and Function rotateScreen
                          fullscreenButton(
                              context, widget.isReps, rotateScreen),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }

  pauseAndPlayFunction() {
    /// if controller is playing - pause it, else play it
    if (widget.controller.value.isPlaying) {
      widget.controller.pause();
      checkIsOnTimeAndPauseTimer();
    } else {
        if (widget.isReps == 1) {
          widget.controller.play();
          if (isTimeChoosed) {
            startTimer(d1);
          }
          if (isTimerPaused) {
            widget.controller.play();
            startTimer(_pausedOn);
          }
      }
    }
  }

  resetTimer() {
    if (countDownTimer != null) {
      countDownTimer.cancel();
      _current = Duration(seconds: 0);
//        reseted = true;
    }
  }

  /// if exercise is on time, het the paused time,
  /// cancel the timer, set [isTimerPaused] on true
  checkIsOnTimeAndPauseTimer() {
    if (countDownTimer != null) {
      if (widget.isReps == 1) {
        _pausedOn = _current;
        countDownTimer.cancel();
        isTimerPaused = true;
      }
    }
  }

  checkIsCountDownRunning() {
    if (countDownTimer != null) {
      if (countDownTimer.isRunning) {
        resetTimer();
      }
    }
  }

  rotateScreen() {
    Future.delayed(Duration(milliseconds: 400)).then((value) => {
          MediaQuery.of(context).orientation == Orientation.landscape
              ? SystemChrome.setPreferredOrientations(
                  [DeviceOrientation.portraitUp])
              : SystemChrome.setPreferredOrientations(
                  [DeviceOrientation.landscapeRight]),
        });
  }
}
