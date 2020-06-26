import 'dart:async';
import 'dart:ui';
import 'package:attt/utils/colors.dart';
import 'package:attt/utils/emptyContainer.dart';
import 'package:attt/utils/globals.dart';
import 'package:attt/utils/sound.dart';
import 'package:attt/view/chewieVideo/widgets/indicatorWidgets/asManyReps.dart';
import 'package:attt/view/chewieVideo/widgets/indicatorWidgets/clearButton.dart';
import 'package:attt/view/chewieVideo/widgets/indicatorWidgets/customTextAnimation.dart';
import 'package:attt/view/chewieVideo/widgets/indicatorWidgets/exerciseTypes/repsAndTimeType.dart';
import 'package:attt/view/chewieVideo/widgets/indicatorWidgets/exerciseTypes/repsType.dart';
import 'package:attt/view/chewieVideo/widgets/indicatorWidgets/exerciseTypes/timeType.dart';
import 'package:attt/view/chewieVideo/widgets/indicatorWidgets/infoIcon.dart';
import 'package:attt/view/chewieVideo/widgets/indicatorWidgets/nameWidget.dart';
import 'package:attt/view/chewieVideo/widgets/indicatorWidgets/nextbutton.dart';
import 'package:attt/view/chewieVideo/widgets/indicatorWidgets/noteButton.dart';
import 'package:attt/view/chewieVideo/widgets/indicatorWidgets/previousButton.dart';
import 'package:attt/view/chewieVideo/widgets/indicatorWidgets/repsWidget.dart';
import 'package:attt/view/chewieVideo/widgets/indicatorWidgets/setsWidget.dart';
import 'package:attt/view/chewieVideo/widgets/indicatorWidgets/timerWidget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_picker/flutter_picker.dart';
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
      onWill,
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
  final bool ctrl;
  final List<dynamic> tips;

  IndicatorsOnVideo(
      {this.controller,
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
      this.onWill,
      this.exerciseTime,
      this.showTimerDialog,
      this.checkTime,
      this.exSecs,
      this.exMinutes});

  @override
  _IndicatorsOnVideoState createState() => _IndicatorsOnVideoState();
}

class _IndicatorsOnVideoState extends State<IndicatorsOnVideo>
    with TickerProviderStateMixin, WidgetsBindingObserver {
  AnimationController _controller;
  AnimationController controllerColor;
  Animation<Offset> _offsetAnimation;
  bool isOrientation = false;
  int _counter = 0;

  String exSecs, exMinutes;
  int minutes, seconds, minutesInSec;
  bool isMinutes, isSeconds, isPausedTimer = true;

  /// we check is [exerciseTime] different than null
  /// we get it, and split it by empty space
  /// than check is [1] secs or min and by that we
  /// set the time to seconds or minutes
  ///
  /// we have booleans that are set to true, based on min or secs
  checkAndArrangeTime() {
    if (widget.exerciseTime != null) {
      var exerciseTimeSplit = widget.exerciseTime.split(' ');
      if (exerciseTimeSplit[1] == 'secs') {
        exSecs = exerciseTimeSplit[0];
        seconds = int.parse(exSecs);
        isSeconds = true;
        isMinutes = false;
        print(seconds.toString() + ' EXERCISE TIME IN SECONDS');
      } else if (exerciseTimeSplit[1] == 'min') {
        exMinutes = exerciseTimeSplit[0];
        minutes = int.parse(exMinutes);
        minutesInSec = minutes * 60;
        isMinutes = true;
        isSeconds = false;
        print(minutesInSec.toString() + ' EXERCISE TIME IN Seconds converted');
      }
    }
  }

//  void showFancyCustomDialog(BuildContext context) {
//    Dialog fancyDialog = Dialog(
//      shape: RoundedRectangleBorder(
//        borderRadius: BorderRadius.circular(12.0),
//      ),
//      child: Container(
//        decoration: BoxDecoration(
//          borderRadius: BorderRadius.circular(20.0),
//        ),
//        height: 300.0,
//        width: 300.0,
//        child: Stack(
//          children: <Widget>[
//            Container(
//              width: double.infinity,
//              height: 300,
//              decoration: BoxDecoration(
//                color: Colors.grey[100],
//                borderRadius: BorderRadius.circular(12.0),
//              ),
//            ),
//            Container(
//              child: Row(
//                mainAxisAlignment: MainAxisAlignment.center,
//                crossAxisAlignment: CrossAxisAlignment.center,
//                children: <Widget>[
//                  Column(
//                    mainAxisAlignment: MainAxisAlignment.center,
//                    crossAxisAlignment: CrossAxisAlignment.center,
//                    children: <Widget>[
//                      Container(
//                        child: NumberPicker.integer(
//                            initialValue: minutes != null ? minutes : 0,
//                            minValue: 0,
//                            maxValue: 59,
//                            onChanged: (val) {
//                              setState(() {
//                                min = val;
//                              });
//                            }),
//                      ),
//                      Container(
//                        child: Text('minutes'),
//                      )
//                    ],
//                  ),
//                  Column(
//                    mainAxisAlignment: MainAxisAlignment.center,
//                    crossAxisAlignment: CrossAxisAlignment.center,
//                    children: <Widget>[
//                      Container(
//                        child: NumberPicker.integer(
//                            initialValue: seconds,
//                            minValue: 0,
//                            maxValue: 59,
//                            onChanged: (val) {
//                              setState(() {
//                                sec = val;
//                              });
//                            }),
//                      ),
//                      Container(
//                        child: Text('seconds'),
//                      )
//                    ],
//                  ),
//                ],
//              ),
//            ),
//            Container(
//              width: double.infinity,
//              height: 50,
//              alignment: Alignment.bottomCenter,
//              decoration: BoxDecoration(
//                color: MyColors().lightBlack,
//                borderRadius: BorderRadius.only(
//                  topLeft: Radius.circular(12),
//                  topRight: Radius.circular(12),
//                ),
//              ),
//              child: Align(
//                alignment: Alignment.center,
//                child: Text(
//                  "Choose time!",
//                  style: TextStyle(
//                      color: Colors.white,
//                      fontSize: 20,
//                      fontWeight: FontWeight.w600),
//                ),
//              ),
//            ),
//            Align(
//              alignment: Alignment.bottomCenter,
//              child: InkWell(
//                onTap: () {
//                  Navigator.pop(context);
//                },
//                child: Container(
//                  width: double.infinity,
//                  height: 50,
//                  decoration: BoxDecoration(
//                    color: MyColors().lightBlack,
//                    borderRadius: BorderRadius.only(
//                      bottomLeft: Radius.circular(12),
//                      bottomRight: Radius.circular(12),
//                    ),
//                  ),
//                  child: Row(
//                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                    children: <Widget>[
//                      RaisedButton(
//                        color: MyColors().error,
//                        onPressed: () {
//                          Navigator.pop(context);
//
//                        },
//                        child: Text(
//                          "Cancel",
//                          style: TextStyle(
//                              color: Colors.white,
//                              fontSize: 20,
//                              fontWeight: FontWeight.w600),
//                        ),
//                      ),
//                      RaisedButton(
//                        color: Colors.green,
//                        onPressed: () {
//                          setState(() {
//                            timeForTimer = (min * 60) + sec;
//                          if (timeForTimer < 60) {
//                            timeToDisplay = timeForTimer.toString();
//                            timeForTimer = timeForTimer - 1;
//                          } else if (timeForTimer < 3600) {
//                            int m = timeForTimer ~/ 60;
//                            int s = timeForTimer - (60 * m);
//                            timeToDisplay = m.toString() + ':' + s.toString();
//                            timeForTimer = timeForTimer - 1;
//                          }
//                          timePaused = null;
//                          checkTimer = true;
//                          });
//                          Navigator.pop(context);
//                        },
//                        child: Text(
//                          "Done",
//                          style: TextStyle(
//                              color: Colors.white,
//                              fontSize: 20,
//                              fontWeight: FontWeight.w600),
//                        ),
//                      ),
//                    ],
//                  ),
//                ),
//              ),
//            ),
//          ],
//        ),
//      ),
//    );
//    showDialog(
//        context: context, builder: (BuildContext context) => fancyDialog);
//  }

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
    controllerColor = AnimationController(
      vsync: this,
      duration: Duration(minutes: 0, seconds: 0),
    );
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
        pauseTimer();
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
        if (!widget.controller.value.isPlaying) widget.controller.play();
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

  /// TIMER
  /// interval in which we will decrease our time
  final interval = const Duration(seconds: 1);

  /// boolean with which we will toggle between _timer.isActive & !_timer.isActive
  bool isPausedT = false;
  String colorStatePaused = 'black';

  /// the main variable for time, it must be int, and converted in seconds
  final int timerMaxSeconds = 30;

  /// instance of Timer, with which we will pause and start timer
  Timer _timer;

  /// variable with which we will insert the timer.tick value [0,1,2,3...]
  int currentSeconds = 0;

  /// variable in which we will add the time that was paused on
  int pausedTime = 0;

  /// getters
  ///
  /// [timerText] - getter with which we will get time and show it in string type,
  /// but before we will format it, and then do math operations to get rounded number, module,
  /// this is geter for initial start
  String get timerText =>
      '${((timerMaxSeconds - currentSeconds) ~/ 60).toString().padLeft(2, '0')}: ${((timerMaxSeconds - currentSeconds) % 60).toString().padLeft(2, '0')}';

  /// [timerTextPaused] - getter with which we will get time and show it in string type,
  //  /// but before we will format it, and then do math operations to get rounded number, module,
  //  /// this is geter which we use tos tart timer again after is being paused
  String get timerTextPaused =>
      '${((pausedTime - currentSeconds) ~/ 60).toString().padLeft(2, '0')}: ${((pausedTime - currentSeconds) % 60).toString().padLeft(2, '0')}';

  /// function for starting the timer,
  /// it gets interval as an duration
  /// then we create an isnstance of [_timer] and assing to it [Timer.perodic]
  /// then in periodic we will setState to add [timer.tick] into our currentSeconds variable
  /// and then just check is timer.tick bigger or equal to timerMaxSeconds, and cancel it
  startTimeout([int milliseconds]) {
    var duration = interval;
    _timer = Timer.periodic(duration, (timer) {
      setState(() {
        print(timer.tick);
        currentSeconds = timer.tick;
        if (timer.tick >= timerMaxSeconds) {
          timer.cancel();
          colorStatePaused = 'green';
          print(colorStatePaused + ' Boja buttona');
        }
      });
    });
    colorStatePaused = 'red';
    print(colorStatePaused + ' Boja buttona');
  }

  /// function for starting the paused timer,
  /// it gets interval as an duration
  /// then we create an isnstance of [_timer] and assing to it [Timer.perodic]
  /// then in periodic we will setState to add [timer.tick] into our currentSeconds variable
  /// and then just check is timer.tick bigger or equal to pausedTime, and cancel it
  startPausedTimer([int milliseconds]) {
    var duration = interval;
    _timer = Timer.periodic(duration, (timer) {
      setState(() {
        print(timer.tick);
        currentSeconds = timer.tick;
        if (timer.tick >= pausedTime) {
          timer.cancel();
          colorStatePaused = 'green';
          print(colorStatePaused + ' Boja buttona');
        }
      });
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
    _timer != null
        ? isPaused ? startPausedTimer() : startTimeout()
        : startTimeout();
    print('Timer ====>  play');
  }

  /// function for pausing the timer
  ///
  /// here I set [pausedTime] to
  /// (if isPaused true then I do pausedTime - currentSeconds,
  /// if it is false then I do timerMaxSeconds - currentSeconds)
  /// and I do this only if it is [_timer.isActive] true
  /// then set isPaused to true,
  /// then I activate the methods
  /// if _timer is not equal to null is true, then check is _timer active,
  /// if it is true then do _timer.cancel() if it is not then print something
  /// if _timer is equal to null just print something
  void pauseTimer() {
    _timer.isActive
        ? pausedTime = isPaused
            ? pausedTime - currentSeconds
            : timerMaxSeconds - currentSeconds
        : print('Nije timer aktivan');
    isPaused = true;
    print('Timer is paused $isPaused on : ' + pausedTime.toString());
    _timer != null ? _timer.cancel() : print('Nije timer aktivan');
    print('Timer ====>  paused');
    colorStatePaused = 'black';
    print(colorStatePaused + ' Boja buttona');
  }

  /// function for reset timer
  ///
  /// here I am just setting the state
  /// isPaused to false,
  /// currentSeconds to zero
  /// and pausedTime to zero
  /// then canceling the _timer
  void resetTimer() {
    setState(() {
      isPaused = false;
      currentSeconds = 0;
      pausedTime = 0;
      _timer.cancel();
    });
    print('Timer ====>  restart');
    colorStatePaused = 'black';
    print(colorStatePaused + ' Boja buttona');
  }

  /// activates every time the widget is changed
  @override
  void didUpdateWidget(IndicatorsOnVideo oldWidget) {
    print('DOLAZIM IZ DIDUPDATEWIDGET ');
    super.didUpdateWidget(oldWidget);
    checkAndArrangeTime();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SlideTransition(
        position: _offsetAnimation,
        child: Padding(
          padding: EdgeInsets.only(
              top: SizeConfig.blockSizeVertical * 3,
              left: SizeConfig.blockSizeHorizontal * 3,
              right: SizeConfig.blockSizeHorizontal * 3),
          child: widget.isReps == 0
              ? repsType(
                  context,
                  widget.onWill,
                  pauseAndPlayFunction,
                  widget.playNext,
                  widget.playPrevious,
                  resetTimer,
                  pauseTimer,
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
                  widget.controller,
                  widget.tips,
                  widget.userDocument,
                  widget.userTrainerDocument,
                  _timer)

              /// ISREPS = 1  - ako su vjezbe na time
              : widget.isReps == 1
                  ? timeType(
                      context,
                      widget.onWill,
                      pauseAndPlayFunction,
                      widget.playNext,
                      widget.playPrevious,
                      widget.showTimerDialog,
                      playTimer,
                      pauseTimer,
                      resetTimer,
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
                      timerTextPaused,
                      colorStatePaused,
                      isTips,
                      infoClicked,
                      goBackToChewie,
                      isFromPortrait,
                      noteClicked,
                      isPausedT,
                      widget.controller,
                      widget.tips,
                      widget.userDocument,
                      widget.userTrainerDocument,
                      _timer)

                  /// isReps == 2
                  : widget.isReps == 2
                      ?
//                      repsAndTimeType(
//                          context,
//                          widget.onWill,
//                          pauseAndPlayFunction,
//                          widget.playNext,
//                          widget.playPrevious,
//                          widget.showTimerDialog,
//                          startPausedTimer,
//                          startTimer,
//                          pauseTimer,
//                          _counter,
//                          widget.index,
//                          widget.isReps,
//                          widget.listLenght,
//                          widget.reps,
//                          widget.sets,
//                          timePaused,
//                          name,
//                          widget.video,
//                          widget.repsDescription,
//                          widget.exerciseTime,
//                          widget.workoutID,
//                          widget.weekID,
//                          widget.currentSet,
//                          timeToDisplay,
//                          isTips,
//                          infoClicked,
//                          goBackToChewie,
//                          isFromPortrait,
//                          noteClicked,
//                          isPausedTimer,
//                          widget.controller,
//                          widget.tips,
//                          widget.userDocument,
//                          widget.userTrainerDocument,
//                          _timer)
                      EmptyContainer()
                      : EmptyContainer(),
        ));
  }

  pauseAndPlayFunction() {
    /// if controller is playing - pause it, else play it
    if (widget.controller.value.isPlaying) {
      widget.controller.pause();
    } else {
      widget.controller.play();
      if (isTimeChoosed) {
        controllerColor.reverse(
            from: controllerColor.value == 0.0 ? 1.0 : controllerColor.value);
      }
      if (isTimerPaused) {
        controllerColor.reverse(
            from: controllerColor.value == 0.0 ? 1.0 : controllerColor.value);
      }
    }
  }

  rotateScreen() {
    Future.delayed(Duration(milliseconds: 400)).then((value) => {
          MediaQuery.of(context).orientation == Orientation.landscape
              ? SystemChrome.setPreferredOrientations(
                  [DeviceOrientation.portraitUp])
              : SystemChrome.setPreferredOrientations([
                  DeviceOrientation.landscapeRight,
                  DeviceOrientation.landscapeLeft,
                ]),
        });
  }
}
