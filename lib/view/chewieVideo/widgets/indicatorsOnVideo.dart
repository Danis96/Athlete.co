import 'dart:async';
import 'dart:ui';
import 'package:attt/utils/alertDialog.dart';
import 'package:attt/utils/colors.dart';
import 'package:attt/utils/emptyContainer.dart';
import 'package:attt/utils/globals.dart';
import 'package:attt/utils/sound.dart';
import 'package:attt/view/chewieVideo/widgets/indicatorWidgets/borderUpDown.dart';
import 'package:attt/view/chewieVideo/widgets/indicatorWidgets/exerciseTypes/repsAndTimeType.dart';
import 'package:attt/view/chewieVideo/widgets/indicatorWidgets/exerciseTypes/repsType.dart';
import 'package:attt/view/chewieVideo/widgets/indicatorWidgets/exerciseTypes/timeType.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:video_box/video.controller.dart';
import 'package:attt/utils/size_config.dart';

class IndicatorsOnVideo extends StatefulWidget {
  final VideoController controller;
  final DocumentSnapshot userDocument, userTrainerDocument;
  final int index, listLenght;
  final Function showAddNote,
      playNext,
      playPrevious,
      showTimerDialog,
      checkTime;
  final int isReps, sets;
  final reps;
  final String name,
      workoutID,
      weekID,
      currentSet,
      repsDescription,
      video,
      exerciseTime;
  int exSecs, exMinutes;
  final bool ctrl, isOrientationFull;
  final List<dynamic> tips;

  IndicatorsOnVideo({
    this.controller,
    this.tips,
    this.currentSet,
    this.video,
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
    this.exerciseTime,
    this.showTimerDialog,
    this.checkTime,
    this.exSecs,
    this.exMinutes,
    this.isOrientationFull,
  });

  @override
  _IndicatorsOnVideoState createState() => _IndicatorsOnVideoState();
}

class _IndicatorsOnVideoState extends State<IndicatorsOnVideo>
    with TickerProviderStateMixin, WidgetsBindingObserver {
  AnimationController _controller;
  Animation<Offset> _offsetAnimation;
  ScrollController scrollController;
  bool isOrientation = false, isInitial = true;
  int _counter = 0;

  String exSecs, exMinutes;
  int minutes, seconds, minutesInSec;

  /// initial variables for dialog timer
  int min = 0;
  int sec = 0;

  /// TIMER
  /// interval in which we will decrease our time
  final interval = const Duration(seconds: 1);

  /// boolean with which we will toggle between _timer.isActive & !_timer.isActive
  bool running = false, notRunning = true;
  String colorStatePaused = 'black';

  /// the main variable for time, it must be int, and converted in seconds
  int timerMaxSeconds;

  /// instance of Timer, with which we will pause and start timer
  Timer _timer;

  /// getters
  ///
  /// [timerText] - getter with which we will get time and show it in string type,
  /// but before we will format it, and then do math operations to get rounded number, module,
  /// this is geter for initial start
  String get timerText =>
      '${((timerMaxSeconds) ~/ 60).toString().padLeft(2, '0')}:${((timerMaxSeconds) % 60).toString().padLeft(2, '0')}';

  /// we check is [exerciseTime] different than null
  /// we get it, and split it by empty space
  /// than check is [1] secs or min and by that we
  /// set the time to seconds or minutes
  checkAndArrangeTime() {
    print('CHECK AND ARRANGE TIME FUNCTION: ');
    if (widget.exerciseTime != null) {
      var exerciseTimeSplit = widget.exerciseTime.split(' ');
      if (exerciseTimeSplit[1] == 'secs') {
        exSecs = exerciseTimeSplit[0];
        print('EX SECS: ' + exSecs);
        seconds = int.parse(exSecs);
        minutes = 0;
        minutesInSec = 0;
        print(seconds.toString() + ' EXERCISE TIME IN SECONDS');
      }

      if (exerciseTimeSplit[1] == 'min') {
        exMinutes = exerciseTimeSplit[0];
        print('EX MINUTES: ' + exMinutes);
        minutes = int.parse(exMinutes);
        seconds = 0;
        minutesInSec = minutes * 60;
        print(minutesInSec.toString() + ' EXERCISE TIME IN Seconds converted');
      }
    }
    timerMaxSeconds = minutesInSec == null ? seconds : minutesInSec + seconds;
    print('TIMER SECONDS from arrange f:  ' + timerMaxSeconds.toString());
  }

  /// dialog number picker
  void showFancyCustomDialog(BuildContext context) {
    isInitial = true;
    Dialog fancyDialog = Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
        ),
        height: MediaQuery.of(context).size.width < 400
            ? SizeConfig.blockSizeVertical * 50
            : SizeConfig.blockSizeVertical * 40,
        width: SizeConfig.blockSizeHorizontal * 80,
        child: Stack(
          children: <Widget>[
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.width < 400
                  ? SizeConfig.blockSizeVertical * 50
                  : SizeConfig.blockSizeHorizontal * 80,
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(12.0),
              ),
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Stack(
                        children: <Widget>[
                          BorderUpDown().focusTimeBorderUp(context),
                          BorderUpDown().focusTimeBorderDown(context),
                          Container(
                            child: NumberPicker.integer(
                                initialValue: minutes != null ? minutes : 0,
                                minValue: 0,
                                maxValue: 59,
                                highlightSelectedValue: false,
                                onChanged: (val) {
                                  setState(() {
                                    isInitial = false;
                                    min = val;
                                  });
                                }),
                          ),
                        ],
                      ),
                      Container(
                        child: Text('minutes'),
                      )
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Stack(
                        children: <Widget>[
                          BorderUpDown().focusTimeBorderUp(context),
                          BorderUpDown().focusTimeBorderDown(context),
                          Container(
                            child: NumberPicker.integer(
                                initialValue: seconds != null ? seconds : 0,
                                minValue: 0,
                                maxValue: 59,
                                highlightSelectedValue: false,
                                onChanged: (val) {
                                  setState(() {
                                    isInitial = false;
                                    sec = val;
                                  });
                                }),
                          ),
                        ],
                      ),
                      Container(
                        child: Text('seconds'),
                      )
                    ],
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              height: 50,
              alignment: Alignment.bottomCenter,
              decoration: BoxDecoration(
                color: MyColors().lightBlack,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
              ),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  "Choose time!",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  width: double.infinity,
                  height: 50,
                  decoration: BoxDecoration(
                    color: MyColors().lightBlack,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(12),
                      bottomRight: Radius.circular(12),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      RaisedButton(
                        color: MyColors().error,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          "Cancel",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      RaisedButton(
                        color: Colors.green,
                        onPressed: () {
                          if(colorStatePaused == 'green') {
                             colorStatePaused = 'red';
                             print(colorStatePaused + 'CSP');
                          }
                          ///  then convert time that is choosen to seconds in [timerMaxSeconds]
                          setState(() {
                            timerMaxSeconds = isInitial
                                ? minutes != null || minutes != 0
                                    ? (minutes * 60) + seconds
                                    : seconds
                                : min != null || min != 0
                                    ? (min * 60) + sec
                                    : sec;
                          });
                          print(
                              'From DONE: time ' + timerMaxSeconds.toString());
                          Navigator.pop(context);
                        },
                        child: Text(
                          "Done",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
    showDialog(
        context: context, builder: (BuildContext context) => fancyDialog);
  }

  @override
  void initState() {
    super.initState();
    checkAndArrangeTime();
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
  }

  /// here it is where we check for the state of the app
  /// as I was doing research for the minimize and working
  /// of the app in the background I
  /// learned that every app has 4 states
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    switch (state) {
      case AppLifecycleState.detached:
        break;

      /// this state of the app activates first when the app
      /// is going into the background
      case AppLifecycleState.inactive:
        print('Inactive');
        setState(() {});
        if (colorStatePaused == 'green') {
          print('colorStatePaused = $colorStatePaused');
        } else {
          pauseTimer();
        }
        break;

      /// if app is in background we want to
      /// pause timer if it is going and
      /// pause the video
      case AppLifecycleState.paused:
        print('Paused');
        if (widget.controller.value.isPlaying) widget.controller.pause();
        break;

      /// when the app is back into foreground
      /// we want to start the timer  and
      /// start the video
      case AppLifecycleState.resumed:
        print('Resumed');
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
    _timer.cancel();
    super.dispose();
  }

  /// function for starting the timer,
  /// it gets interval as an duration
  /// then we create an isnstance of [_timer] and assing the periodic f
  /// then color the btn to red
  /// in periodic f, I check is running true,
  /// if it is I decrease the timerMaxSeconds
  /// I am also checking is timerMaxSeconds is equal to 0
  /// if it is color the button and cancel the timer
  startTimeout([int milliseconds]) {
    var duration = interval;
    _timer = Timer.periodic(duration, (timer) {
      if (running) {
        setState(() {
          timerMaxSeconds--;
          if (timerMaxSeconds == 0) {
            colorStatePaused = 'green';
            _timer.cancel();
            SoundPlayer().playSound();
          }
        });
        print(timerMaxSeconds);
      }
    });
    colorStatePaused = 'red';
    print(colorStatePaused + ' Boja buttona');
  }

  /// function for playing the timer
  ///
  /// I am checking that _timer is not equal to null,
  /// if it is not, then check is _timer active,
  /// if it is print something,
  /// if it is not active, then check isPaused true or false,
  /// if it is true then [startPausedTimer] - if it is false then just [startTimeout]
  /// and if _timer is equal to null then just [startTimeout]
  void playTimer() {
    running = true;
    notRunning = false;
    _timer != null
        ? _timer.isActive && !notRunning
            ? print('Timer nije aktivan')
            : startTimeout()
        : startTimeout();
    print('Timer ====>  play: ' + timerMaxSeconds.toString());
  }

  /// function for pausing the timer
  ///
  /// running to false
  /// notRunning to true
  /// then check if the timer is not null
  /// if timer is active, then cancel the timer
  /// then color the button
  void pauseTimer() {
    running = false;
    notRunning = true;
    _timer != null
        ? _timer.isActive ? _timer.cancel() : print('Nije timer aktivan')
        : print('Nije timer aktivan');
    print('Timer ====>  paused: ' + timerMaxSeconds.toString());
    colorStatePaused = 'black';
    print(colorStatePaused + ' Boja buttona');
  }

  /// function for reset timer
  ///
  /// here I am just setting the state
  /// running to false
  /// notRunning to true
  /// min to 0
  /// sec to 0
  /// then canceling the _timer
  /// then arrange the time again for the initial value
  /// then color the timer
  void resetTimer() {
    print(timerMaxSeconds.toString() + ' TIMER MAX SECONDS before reset');
    setState(() {
      running = false;
      notRunning = true;
      min = 0;
      sec = 0;
      timerMaxSeconds = 0;
      _timer != null ? _timer.cancel() : print('timer nije aktivan - reset f');
    });
    print(timerMaxSeconds.toString() + ' TIMER MAX SECONDS after reset');
    checkAndArrangeTime();
    print('Timer ====>  restart');
    colorStatePaused = 'black';
    print(colorStatePaused + ' Boja buttona');
  }

  /// activates every time the widget is changed
  @override
  void didUpdateWidget(IndicatorsOnVideo oldWidget) {
    print('DOLAZIM IZ DIDUPDATEWIDGET ');
    super.didUpdateWidget(oldWidget);
    if (widget.isOrientationFull) {
      /// ukoliko je timer zavrsen nemoj ga pauzirati
      if(colorStatePaused == 'green') {
        print('colorStatePaused = $colorStatePaused');
      } else {
        pauseTimer();
      }
    } else {
      isDone ? print('isDone: ' + isDone.toString()) : checkAndArrangeTime();
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SlideTransition(
      position: _offsetAnimation,
      child: WillPopScope(
        onWillPop: () => _onWillPop(),
        child: Padding(
          padding: EdgeInsets.only(
              top: SizeConfig.blockSizeVertical * 3,
              left: SizeConfig.blockSizeHorizontal * 3,
              right: SizeConfig.blockSizeHorizontal * 3),
          child: widget.isReps == 0
              ? repsType(
                  context,
                  _onWillPop,
                  pauseAndPlayFunction,
                  widget.playNext,
                  widget.playPrevious,
                  pauseTimer,
            resetTimer,
            checkAndArrangeTime,
                  _counter,
                  widget.index,
                  widget.isReps,
                  widget.listLenght,
                  widget.reps,
                  widget.sets,
                  widget.name,
                  widget.video,
                  widget.repsDescription,
                  widget.exerciseTime,
                  widget.workoutID,
                  widget.weekID,
                  widget.currentSet,
                  isTips,
                  infoClicked,
                  goBackToChewie,
                  isFromPortrait,
                  noteClicked,
                  widget.isOrientationFull,
                  widget.controller,
                  widget.tips,
                  widget.userDocument,
                  widget.userTrainerDocument,
                  _timer,
                )

              /// isREPS = 1  - ako su vjezbe na time
              : widget.isReps == 1
                  ? timeType(
                      context,
                      _onWillPop,
                      pauseAndPlayFunction,
                      widget.playNext,
                      widget.playPrevious,
                      showFancyCustomDialog,
                      playTimer,
                      pauseTimer,
                      resetTimer,
                      checkAndArrangeTime,
                      _counter,
                      widget.index,
                      widget.isReps,
                      widget.listLenght,
                      widget.reps,
                      widget.sets,
                      widget.name,
                      widget.video,
                      widget.repsDescription,
                      widget.exerciseTime,
                      widget.workoutID,
                      widget.weekID,
                      widget.currentSet,
                      timerText,
                      colorStatePaused,
                      isTips,
                      infoClicked,
                      goBackToChewie,
                      isFromPortrait,
                      noteClicked,
                      widget.isOrientationFull,
                      widget.controller,
                      widget.tips,
                      widget.userDocument,
                      widget.userTrainerDocument,
                      _timer,
                    )

                  /// ako su vjezbe na time i reps
                  : widget.isReps == 2
                      ? repsAndTimeType(
                          context,
                          _onWillPop,
                          pauseAndPlayFunction,
                          widget.playNext,
                          widget.playPrevious,
                          showFancyCustomDialog,
                          playTimer,
                          pauseTimer,
                          resetTimer,
            checkAndArrangeTime,
                          _counter,
                          widget.index,
                          widget.isReps,
                          widget.listLenght,
                          widget.reps,
                          widget.sets,
                          widget.name,
                          widget.video,
                          widget.repsDescription,
                          widget.exerciseTime,
                          widget.workoutID,
                          widget.weekID,
                          widget.currentSet,
                          timerText,
                          colorStatePaused,
                          isTips,
                          infoClicked,
                          goBackToChewie,
                          isFromPortrait,
                          noteClicked,
                          widget.isOrientationFull,
                          widget.controller,
                          widget.tips,
                          widget.userDocument,
                          widget.userTrainerDocument,
                          _timer,
                        )
                      : EmptyContainer(),
        ),
      ),
    );
  }

  pauseAndPlayFunction() {
    /// if controller is playing - pause it, else play it
    if (widget.controller.value.isPlaying) {
      widget.controller.pause();
    } else {
      widget.controller.play();
    }
  }

  /// [_onWillPop]
  ///
  /// async funstion that creates an exit dialog for our screen
  /// CONTINUE / CANCEL
  Future<bool> _onWillPop() async {
    _timer != null ? pauseTimer() : print('Timer nije aktivan');
    setState(() {});
    return showDialog(
          context: context,
          builder: (context) => MyAlertDialog(
            no: 'Cancel',
            yes: 'Continue',
            title: 'Back to Training plan?',
            content: 'If you go back all your progress will be lost',
            userDocument: widget.userDocument,
            userTrainerDocument: widget.userTrainerDocument,
            vc: widget.controller,
            isReps: widget.isReps,
            resetTimer: resetTimer,
            timer: _timer,
          ),
        ) ??
        true;
  }
}

/// checking responsive
bool checkIsIosTablet(BuildContext context) {
  if (MediaQuery.of(context).size.width > 1000) {
    return true;
  } else {
    return false;
  }
}

