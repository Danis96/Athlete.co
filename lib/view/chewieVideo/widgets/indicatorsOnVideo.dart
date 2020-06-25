import 'dart:async';
import 'dart:ui';
import 'package:attt/utils/colors.dart';
import 'package:attt/utils/emptyContainer.dart';
import 'package:attt/utils/globals.dart';
import 'package:attt/utils/sound.dart';
import 'package:attt/view/chewieVideo/widgets/indicatorWidgets/asManyReps.dart';
import 'package:attt/view/chewieVideo/widgets/indicatorWidgets/clearButton.dart';
import 'package:attt/view/chewieVideo/widgets/indicatorWidgets/customTextAnimation.dart';
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
  Timer _timer;
  int _start;

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

//  List<dynamic> time = [];
//  String timeToSplit;
//  var ms;
//  onConfirm(Picker picker) {
//    timeToSplit = picker.getSelectedValues().toString();
//    String min = timeToSplit[1] + (timeToSplit[2] == ',' ? '' : timeToSplit[2]);
//    setState(() {
//      minutesForIndicators = int.parse(min);
//    });
//    print('Minutes: ' + minutesForIndicators.toString());
//    String sec = minutesForIndicators > 10
//        ? timeToSplit[5] + (timeToSplit[6] == ']' ? '' : timeToSplit[6])
//        : timeToSplit[4] + (timeToSplit[5] == ']' ? '' : timeToSplit[5]);
//    setState(() {
//      secondsForIndicators = int.parse(sec);
//      seconds = secondsForIndicators;
//    });
//  }

  void showFancyCustomDialog(BuildContext context) {
    Dialog fancyDialog = Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
        ),
        height: 300.0,
        width: 300.0,
        child: Stack(
          children: <Widget>[
            Container(
              width: double.infinity,
              height: 300,
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
                      Container(
                        child: NumberPicker.integer(
                            initialValue: minutes != null ? minutes : 0,
                            minValue: 0,
                            maxValue: 59,
                            onChanged: (val) {
                              setState(() {
                                min = val;
                              });
                            }),
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
                      Container(
                        child: NumberPicker.integer(
                            initialValue: seconds,
                            minValue: 0,
                            maxValue: 59,
                            onChanged: (val) {
                              setState(() {
                                sec = val;
                              });
                            }),
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
                          setState(() {
                            timeForTimer = (min * 60) + sec;
                          if (timeForTimer < 60) {
                            timeToDisplay = timeForTimer.toString();
                            timeForTimer = timeForTimer - 1;
                          } else if (timeForTimer < 3600) {
                            int m = timeForTimer ~/ 60;
                            int s = timeForTimer - (60 * m);
                            timeToDisplay = m.toString() + ':' + s.toString();
                            timeForTimer = timeForTimer - 1;
                          }
                          timePaused = null;
                          checkTimer = true;
                          });
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
    controllerColor = AnimationController(
      vsync: this,
      duration: Duration(minutes: 0, seconds: 0),
    );

    /// check if countDown is running ,
    /// if it is RESET IT
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
        break;

      /// if app is in background we want to
      /// pause timer if it is going and
      /// pause the video
      case AppLifecycleState.paused:
        print('Paused');
        if (widget.controller.value.isPlaying) widget.controller.pause();
        _timer.cancel();
        break;

      /// when the app is back into foreground
      /// we want to start the timer  and
      /// start the video
      case AppLifecycleState.resumed:
        print('Resumed');
//        startTimer();
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

  String timeToDisplay = '';
  int timeForTimer = 1;
  bool checkTimer = true;
  int min = 0;
  int sec = 0;
  int timePaused;


  /// pause timer
  ///
  /// potrebno je uzeti trenutno vrijeme
  /// pausedTime = timeForTimer;
  /// setati bool paused na true
  /// ako se aktivira opet start timer potrebno mu je proslijediti trenutno vrijeme
  /// setatu bool paused na false
  ///
  /// ako je paused ? startTimer(pausedTime) : pauseTimer()
  void pauseTimer() {
    setState(() {
      isPausedTimer = true;
      checkTimer = false;
    });
    /// variable where we save current time that is paused on
    timePaused = timeForTimer;
    print('Timer is paused on ' + timePaused.toString());
  }

  void startTimer() {
    timeForTimer = (min * 60) + sec;
    setState(() {
      isPausedTimer = false;
    });
    Timer.periodic(
      const Duration(seconds: 1),
      (Timer timer) => setState(
        () {
          if (timeForTimer < 1 || checkTimer == false) {
            timer.cancel();
            checkTimer = true;
            if (timeForTimer == 0) {
              SoundPlayer().playSound();
            }
          } else if (timeForTimer < 60) {
            timeToDisplay = timeForTimer.toString().length < 2
                ? '0' + timeForTimer.toString()
                : timeForTimer.toString();
            timeForTimer = timeForTimer - 1;
          } else if (timeForTimer < 3600) {
            int m = timeForTimer ~/ 60;
            int s = timeForTimer - (60 * m);
            timeToDisplay = s.toString().length < 2
                ? m.toString() + ':' + '0' + s.toString()
                : m.toString() + ':' + s.toString();
            timeForTimer = timeForTimer - 1;
          }
        },
      ),
    );
  }

  void startPausedTimer() {
    timeForTimer = timePaused;
    setState(() {
      isPausedTimer = false;
    });
    Timer.periodic(
      const Duration(seconds: 1),
          (Timer timer) => setState(
            () {
          if (timeForTimer < 1 || checkTimer == false) {
            timer.cancel();
            checkTimer = true;
            if (timeForTimer == 0) {
              SoundPlayer().playSound();
            }
          } else if (timeForTimer < 60) {
            timeToDisplay = timeForTimer.toString().length < 2
                ? '0' + timeForTimer.toString()
                : timeForTimer.toString();
            timeForTimer = timeForTimer - 1;
          } else if (timeForTimer < 3600) {
            int m = timeForTimer ~/ 60;
            int s = timeForTimer - (60 * m);
            timeToDisplay = s.toString().length < 2
                ? m.toString() + ':' + '0' + s.toString()
                : m.toString() + ':' + s.toString();
            timeForTimer = timeForTimer - 1;
          }
        },
      ),
    );
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
              ? Column(
                  children: <Widget>[
                    Stack(
                      alignment: Alignment.topRight,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            clearIcon(
                              context,
                              widget.onWill,
                            ),
                          ],
                        ),
                        InkWell(
                          onTap: () {
                            if (_counter == 0) {
                              pauseAndPlayFunction();
                              isTips = false;
                              _counter = 1;
                            }
                            Timer(Duration(seconds: 1), () {
                              _counter = 0;
                            });
                          },
                          child: Container(
                            width: SizeConfig.blockSizeHorizontal * 83,
                            height: SizeConfig.blockSizeVertical * 20,
                          ),
                        )
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          top: SizeConfig.blockSizeVertical * 22),
                      child: MarqueeWidget(
                        child: nameWidget(
                          infoClicked,
                          goBackToChewie,
                          isFromPortrait,
                          context,
                          widget.controller,
                          widget.name,
                          widget.video,
                          widget.tips,
                          widget.isReps,
                          widget.index,
                          widget.listLenght,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          top: widget.repsDescription != null &&
                                  widget.repsDescription != ''
                              ? SizeConfig.blockSizeVertical * 6
                              : SizeConfig.blockSizeVertical * 11.5),
                      child: Column(
                        children: <Widget>[
                          widget.repsDescription != null &&
                                  widget.repsDescription != ''
                              ? Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(5.0),
                                        topLeft: Radius.circular(5.0)),
                                    color: Colors.grey,
                                  ),
                                  width: SizeConfig.blockSizeHorizontal * 95,
                                  height: SizeConfig.blockSizeVertical * 5.5,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      asManyReps(
                                        context,
                                        widget.repsDescription,
                                      ),
                                    ],
                                  ),
                                )
                              : EmptyContainer(),
                          Container(
                            width: SizeConfig.blockSizeHorizontal * 95,
                            height: SizeConfig.blockSizeVertical * 20,
                            decoration: BoxDecoration(
                              borderRadius: widget.repsDescription != null &&
                                      widget.repsDescription != ''
                                  ? BorderRadius.only(
                                      bottomLeft: Radius.circular(5.0),
                                      bottomRight: Radius.circular(5.0))
                                  : BorderRadius.all(Radius.circular(5.0)),
                              color: Colors.white,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Container(
                                  height: SizeConfig.blockSizeVertical * 10,
                                  child: repsWidget(
                                    context,
                                    widget.isReps,
                                    widget.reps,
                                    widget.exerciseTime,
                                  ),
                                ),
                                Container(
                                  width: SizeConfig.blockSizeHorizontal * 60,
                                  height: SizeConfig.blockSizeVertical * 5,
                                  child: RaisedButton(
                                    color: MyColors().lightBlack,
                                    child: Text(
                                      widget.index == (widget.listLenght - 1)
                                          ? 'FINISH'
                                          : 'DONE',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600,
                                          fontSize:
                                              SizeConfig.safeBlockHorizontal *
                                                  4),
                                    ),
                                    onPressed: () => widget.playNext(),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                setsWidget(
                                  context,
                                  widget.currentSet,
                                  widget.sets,
                                  widget.isReps,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: SizeConfig.blockSizeVertical * 2,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                widget.index == 0
                                    ? SizedBox(
                                        width:
                                            SizeConfig.blockSizeHorizontal * 10,
                                      )
                                    : previousButton(
                                        context,
                                        widget.playPrevious,
                                      ),
                                Container(
                                  child: Row(
                                    children: <Widget>[
                                      noteButton(
                                        context,
                                        noteClicked,
                                        isFromPortrait,
                                        widget.controller,
                                        widget.userDocument,
                                        widget.userTrainerDocument,
                                        widget.index,
                                        widget.listLenght,
                                        widget.isReps,
                                        widget.sets,
                                        widget.reps.toString(),
                                        widget.name,
                                        widget.workoutID,
                                        widget.weekID,
                                      ),
                                      SizedBox(
                                        width:
                                            SizeConfig.blockSizeHorizontal * 3,
                                      ),
                                      infoIcon(
                                        infoClicked,
                                        goBackToChewie,
                                        isFromPortrait,
                                        context,
                                        widget.controller,
                                        widget.name,
                                        widget.video,
                                        widget.tips,
                                        widget.isReps,
                                        widget.index,
                                        widget.listLenght,
                                      ),
                                    ],
                                  ),
                                ),
                                widget.index == (widget.listLenght - 1)
                                    ? SizedBox(
                                        width:
                                            SizeConfig.blockSizeHorizontal * 10,
                                      )
                                    : nextButton(
                                        context,
                                        widget.playNext,
                                        widget.controller,
                                        _timer,
                                      ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                )

              /// ISREPS = 1  - ako su vjezbe na time
              : widget.isReps == 1
                  ? Column(
                      children: <Widget>[
                        Stack(
                          alignment: Alignment.topRight,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                clearIcon(
                                  context,
                                  widget.onWill,
                                ),
                              ],
                            ),
                            InkWell(
                              onTap: () {
                                if (_counter == 0) {
                                  pauseAndPlayFunction();
                                  isTips = false;
                                  _counter = 1;
                                }
                                Timer(Duration(seconds: 1), () {
                                  _counter = 0;
                                });
                              },
                              child: Container(
                                width: SizeConfig.blockSizeHorizontal * 83,
                                height: SizeConfig.blockSizeVertical * 20,
                              ),
                            )
                          ],
                        ),
                        Container(
                          margin: EdgeInsets.only(
                              top: SizeConfig.blockSizeVertical * 22),
                          child: MarqueeWidget(
                            child: nameWidget(
                              infoClicked,
                              goBackToChewie,
                              isFromPortrait,
                              context,
                              widget.controller,
                              widget.name,
                              widget.video,
                              widget.tips,
                              widget.isReps,
                              widget.index,
                              widget.listLenght,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                              top: widget.repsDescription != null &&
                                      widget.repsDescription != ''
                                  ? SizeConfig.blockSizeVertical * 6
                                  : SizeConfig.blockSizeVertical * 11.5),
                          child: Column(
                            children: <Widget>[
                              widget.repsDescription != null &&
                                      widget.repsDescription != ''
                                  ? Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(5.0),
                                            topLeft: Radius.circular(5.0)),
                                        color: Colors.grey,
                                      ),
                                      width:
                                          SizeConfig.blockSizeHorizontal * 95,
                                      height:
                                          SizeConfig.blockSizeVertical * 5.5,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          asManyReps(
                                            context,
                                            widget.repsDescription,
                                          ),
                                        ],
                                      ),
                                    )
                                  : EmptyContainer(),
                              Container(
                                width: SizeConfig.blockSizeHorizontal * 95,
                                height: SizeConfig.blockSizeVertical * 20,
                                decoration: BoxDecoration(
                                  borderRadius: widget.repsDescription !=
                                              null &&
                                          widget.repsDescription != ''
                                      ? BorderRadius.only(
                                          bottomLeft: Radius.circular(5.0),
                                          bottomRight: Radius.circular(5.0),
                                        )
                                      : BorderRadius.all(Radius.circular(5.0)),
                                  color: Colors.white,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    Container(
                                        height:
                                            SizeConfig.blockSizeVertical * 10,
                                        child: timerWidget(
                                          context,
                                          widget.showTimerDialog,
                                          widget.controller,
                                          timeToDisplay,
                                        )),
                                    Container(
                                      width:
                                          SizeConfig.blockSizeHorizontal * 60,
                                      height: SizeConfig.blockSizeVertical * 5,
                                      child: RaisedButton(
                                        color:  MyColors().lightBlack,
                                        child: Text(
                                          widget.index ==
                                                  (widget.listLenght - 1)
                                              ? 'FINISH'
                                              : 'Start timer'
                                                          .toUpperCase(),
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w600,
                                              fontSize: SizeConfig
                                                      .safeBlockHorizontal *
                                                  4),
                                        ),
                                        onPressed: () {
                                          widget.index ==
                                              (widget.listLenght - 1)
                                              ? widget.playNext()  :
                                          isPausedTimer
                                              ? timePaused != null ?  startPausedTimer() :  startTimer()
                                              : pauseTimer();
                                        },
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment.center,
                                      height: SizeConfig.blockSizeVertical * 5,
                                      child: FlatButton(
                                        onPressed: () {
                                          pauseTimer();
                                          showFancyCustomDialog(context);
                                        },
                                        child: Text(
                                          'EDIT TIMER',
                                          style: TextStyle(
                                              color: MyColors()
                                                  .lightBlack
                                                  .withOpacity(0.5)),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    setsWidget(
                                      context,
                                      widget.currentSet,
                                      widget.sets,
                                      widget.isReps,
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: SizeConfig.blockSizeVertical * 2,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    widget.index == 0
                                        ? SizedBox(
                                            width:
                                                SizeConfig.blockSizeHorizontal *
                                                    10,
                                          )
                                        : previousButton(
                                            context,
                                            widget.playPrevious,
                                          ),
                                    Container(
                                      child: Row(
                                        children: <Widget>[
                                          noteButton(
                                            context,
                                            noteClicked,
                                            isFromPortrait,
                                            widget.controller,
                                            widget.userDocument,
                                            widget.userTrainerDocument,
                                            widget.index,
                                            widget.listLenght,
                                            widget.isReps,
                                            widget.sets,
                                            widget.reps.toString(),
                                            widget.name,
                                            widget.workoutID,
                                            widget.weekID,
                                          ),
                                          SizedBox(
                                            width:
                                                SizeConfig.blockSizeHorizontal *
                                                    3,
                                          ),
                                          infoIcon(
                                            infoClicked,
                                            goBackToChewie,
                                            isFromPortrait,
                                            context,
                                            widget.controller,
                                            widget.name,
                                            widget.video,
                                            widget.tips,
                                            widget.isReps,
                                            widget.index,
                                            widget.listLenght,
                                          ),
                                        ],
                                      ),
                                    ),
                                    widget.index == (widget.listLenght - 1)
                                        ? SizedBox(
                                            width:
                                                SizeConfig.blockSizeHorizontal *
                                                    10,
                                          )
                                        : nextButton(
                                            context,
                                            widget.playNext,
                                            widget.controller,
                                            _timer,
                                          ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    )

                  /// isReps == 2
                  : widget.isReps == 2
                      ? Column(
                          children: <Widget>[
                            Stack(
                              alignment: Alignment.topRight,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    clearIcon(
                                      context,
                                      widget.onWill,
                                    ),
                                  ],
                                ),
                                InkWell(
                                  onTap: () {
                                    if (_counter == 0) {
                                      pauseAndPlayFunction();
                                      isTips = false;
                                      _counter = 1;
                                    }
                                    Timer(Duration(seconds: 1), () {
                                      _counter = 0;
                                    });
                                  },
                                  child: Container(
                                    width: SizeConfig.blockSizeHorizontal * 83,
                                    height: SizeConfig.blockSizeVertical * 20,
                                  ),
                                )
                              ],
                            ),
                            Column(children: <Widget>[
                              Container(
                                margin: EdgeInsets.only(
                                    top: SizeConfig.blockSizeVertical * 22),
                                child: MarqueeWidget(
                                  child: nameWidget(
                                    infoClicked,
                                    goBackToChewie,
                                    isFromPortrait,
                                    context,
                                    widget.controller,
                                    widget.name,
                                    widget.video,
                                    widget.tips,
                                    widget.isReps,
                                    widget.index,
                                    widget.listLenght,
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(3),
                                child: Text(
                                  widget.reps,
                                  style: TextStyle(
                                    color: MyColors().lightWhite,
                                    fontSize:
                                        SizeConfig.safeBlockHorizontal * 4,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ]),
                            Container(
                              margin: EdgeInsets.only(
                                  top: widget.repsDescription != null &&
                                          widget.repsDescription != ''
                                      ? SizeConfig.blockSizeVertical * 6
                                      : SizeConfig.blockSizeVertical * 9),
                              child: Column(
                                children: <Widget>[
                                  widget.repsDescription != null &&
                                          widget.repsDescription != ''
                                      ? Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.only(
                                                topRight: Radius.circular(5.0),
                                                topLeft: Radius.circular(5.0)),
                                            color: Colors.grey,
                                          ),
                                          width:
                                              SizeConfig.blockSizeHorizontal *
                                                  95,
                                          height: SizeConfig.blockSizeVertical *
                                              5.5,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: <Widget>[
                                              asManyReps(
                                                context,
                                                widget.repsDescription,
                                              ),
                                            ],
                                          ),
                                        )
                                      : EmptyContainer(),
                                  Container(
                                    width: SizeConfig.blockSizeHorizontal * 95,
                                    height: SizeConfig.blockSizeVertical * 20,
                                    decoration: BoxDecoration(
                                      borderRadius: widget.repsDescription !=
                                                  null &&
                                              widget.repsDescription != ''
                                          ? BorderRadius.only(
                                              bottomLeft: Radius.circular(5.0),
                                              bottomRight: Radius.circular(5.0),
                                            )
                                          : BorderRadius.all(
                                              Radius.circular(5.0)),
                                      color: Colors.white,
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: <Widget>[
                                        Container(
                                            height:
                                                SizeConfig.blockSizeVertical *
                                                    10,
                                            child: timerWidget(
                                              context,
                                              widget.showTimerDialog,
                                              widget.controller,
                                              timeToDisplay,
                                            )),
                                        Container(
                                          width:
                                              SizeConfig.blockSizeHorizontal *
                                                  60,
                                          height:
                                              SizeConfig.blockSizeVertical * 5,
                                          child: RaisedButton(
                                            color: MyColors().lightBlack,
                                            child: Text(
                                              'start timer'.toUpperCase(),
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: SizeConfig
                                                          .safeBlockHorizontal *
                                                      4),
                                            ),
                                            onPressed: () => startTimer(),
                                          ),
                                        ),
                                        Container(
                                          alignment: Alignment.center,
                                          height:
                                              SizeConfig.blockSizeVertical * 5,
                                          child: FlatButton(
                                            onPressed: () =>
                                                showFancyCustomDialog(context),
                                            child: Text(
                                              'EDIT TIMER',
                                              style: TextStyle(
                                                  color: MyColors()
                                                      .lightBlack
                                                      .withOpacity(0.5)),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Align(
                                alignment: Alignment.bottomCenter,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        setsWidget(
                                          context,
                                          widget.currentSet,
                                          widget.sets,
                                          widget.isReps,
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: SizeConfig.blockSizeVertical * 2,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        widget.index == 0
                                            ? SizedBox(
                                                width: SizeConfig
                                                        .blockSizeHorizontal *
                                                    10,
                                              )
                                            : previousButton(
                                                context,
                                                widget.playPrevious,
                                              ),
                                        Container(
                                          child: Row(
                                            children: <Widget>[
                                              noteButton(
                                                context,
                                                noteClicked,
                                                isFromPortrait,
                                                widget.controller,
                                                widget.userDocument,
                                                widget.userTrainerDocument,
                                                widget.index,
                                                widget.listLenght,
                                                widget.isReps,
                                                widget.sets,
                                                widget.reps.toString(),
                                                widget.name,
                                                widget.workoutID,
                                                widget.weekID,
                                              ),
                                              SizedBox(
                                                width: SizeConfig
                                                        .blockSizeHorizontal *
                                                    3,
                                              ),
                                              infoIcon(
                                                infoClicked,
                                                goBackToChewie,
                                                isFromPortrait,
                                                context,
                                                widget.controller,
                                                widget.name,
                                                widget.video,
                                                widget.tips,
                                                widget.isReps,
                                                widget.index,
                                                widget.listLenght,
                                              ),
                                            ],
                                          ),
                                        ),
                                        widget.index == (widget.listLenght - 1)
                                            ? SizedBox(
                                                width: SizeConfig
                                                        .blockSizeHorizontal *
                                                    10,
                                              )
                                            : nextButton(
                                                context,
                                                widget.playNext,
                                                widget.controller,
                                                _timer),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        )
                      : EmptyContainer(),

          // MediaQuery.of(context).orientation == Orientation.portrait
          //     ? Column(
          //         children: <Widget>[
          //           Row(
          //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //             children: <Widget>[
          //               noteButton(
          //                   context,
          //                   noteClicked,
          //                   isFromPortrait,
          //                   widget.controller,
          //                   checkIsOnTimeAndPauseTimer,
          //                   widget.userDocument,
          //                   widget.userTrainerDocument,
          //                   widget.index,
          //                   widget.listLenght,
          //                   widget.isReps,
          //                   widget.sets,
          //                   widget.reps.toString(),
          //                   widget.name,
          //                   widget.workoutID,
          //                   widget.weekID),
          //               clearIcon(context, checkIsOnTimeAndPauseTimer,
          //                   widget.onWill),
          //             ],
          //           ),
          //           Row(
          //             mainAxisAlignment: MainAxisAlignment.center,
          //             children: <Widget>[
          //               nameWidget(
          //                   infoClicked,
          //                   goBackToChewie,
          //                   isFromPortrait,
          //                   context,
          //                   widget.controller,
          //                   checkIsOnTimeAndPauseTimer,
          //                   widget.name,
          //                   widget.video,
          //                   widget.tips,
          //                   widget.isReps,
          //                   widget.index,
          //                   widget.listLenght),
          //             ],
          //           ),
          //           Row(
          //             mainAxisAlignment: MainAxisAlignment.center,
          //             crossAxisAlignment: CrossAxisAlignment.center,
          //             children: <Widget>[
          //               widget.exerciseTime != null
          //                   ? timeCont(
          //                       widget.exerciseTime, widget.reps, context)
          //                   : SizedBox(
          //                       height: MediaQuery.of(context).orientation ==
          //                               Orientation.landscape
          //                           ? SizeConfig.blockSizeVertical * 9
          //                           : SizeConfig.blockSizeHorizontal * 9,
          //                     ),
          //               (widget.exerciseTime != null && widget.reps != null)
          //                   ? SizedBox(
          //                       width: SizeConfig.blockSizeHorizontal * 20,
          //                     )
          //                   : EmptyContainer(),
          //               widget.reps != null
          //                   ? repsWidget(context, widget.isReps, widget.reps,
          //                       widget.exerciseTime)
          //                   : SizedBox(
          //                       height: MediaQuery.of(context).orientation ==
          //                               Orientation.landscape
          //                           ? SizeConfig.blockSizeVertical * 7
          //                           : SizeConfig.blockSizeHorizontal * 7,
          //                     ),
          //             ],
          //           ),
          //           Row(
          //             mainAxisAlignment: MainAxisAlignment.center,
          //             children: <Widget>[
          //               asManyReps(context, widget.repsDescription),
          //             ],
          //           ),
          //           SizedBox(
          //             height: SizeConfig.blockSizeVertical * 45,
          //           ),
          //           Row(
          //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //             crossAxisAlignment: CrossAxisAlignment.center,
          //             children: <Widget>[
          //               widget.index == 0
          //                   ? SizedBox(
          //                       width: SizeConfig.blockSizeHorizontal * 15,
          //                     )
          //                   : previousButton(
          //                       context, resetTimer, widget.playPrevious),
          //               Stack(
          //                 children: <Widget>[
          //                   Column(
          //                     mainAxisAlignment: MainAxisAlignment.center,
          //                     crossAxisAlignment: CrossAxisAlignment.center,
          //                     children: <Widget>[
          //                       /// reps or timer,
          //                       /// depend on the exercise type
          //                       showTime
          //                           ? timerWidget(
          //                               context,
          //                               widget.showTimerDialog,
          //                               format,
          //                               widget.controller,
          //                               isTimerPaused,
          //                               _current,
          //                               _pausedOn,
          //                               countDownTimer,
          //                               controllerColor,
          //                             )
          //                           : stopIcon(
          //                               pressTimer, context, widget.isReps),
          //                       showTime
          //                           ? colorProgress(controllerColor, context)
          //                           : EmptyContainer(),
          //                     ],
          //                   ),
          //                 ],
          //               ),
          //               widget.index == (widget.listLenght - 1)
          //                   ? SizedBox(
          //                       width: SizeConfig.blockSizeHorizontal * 15,
          //                     )
          //                   : nextButton(context, resetTimer, widget.playNext,
          //                       widget.controller),
          //             ],
          //           ),
          //           Row(
          //             mainAxisAlignment: MainAxisAlignment.center,
          //             children: <Widget>[
          //               infoIcon(
          //                   infoClicked,
          //                   goBackToChewie,
          //                   isFromPortrait,
          //                   context,
          //                   widget.controller,
          //                   checkIsOnTimeAndPauseTimer,
          //                   widget.name,
          //                   widget.video,
          //                   widget.tips,
          //                   widget.isReps,
          //                   widget.index,
          //                   widget.listLenght),
          //             ],
          //           ),
          //           Row(
          //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //             children: <Widget>[
          //               setsWidget(context, widget.currentSet, widget.sets,
          //                   widget.isReps),
          //               fullscreenButton(
          //                   context, widget.isReps, rotateScreen),
          //             ],
          //           ),
          //         ],
          //       )
          //     : Column(
          //         children: <Widget>[
          //           Row(
          //             crossAxisAlignment: CrossAxisAlignment.center,
          //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //             children: <Widget>[
          //               noteButton(
          //                   context,
          //                   noteClicked,
          //                   isFromPortrait,
          //                   widget.controller,
          //                   checkIsOnTimeAndPauseTimer,
          //                   widget.userDocument,
          //                   widget.userTrainerDocument,
          //                   widget.index,
          //                   widget.listLenght,
          //                   widget.isReps,
          //                   widget.sets,
          //                   widget.reps.toString(),
          //                   widget.name,
          //                   widget.workoutID,
          //                   widget.weekID),
          //               widget.repsDescription == null
          //                   ? SizedBox(
          //                       width: SizeConfig.blockSizeHorizontal * 40,
          //                     )
          //                   : asManyReps(context, widget.repsDescription),
          //               setsWidget(context, widget.currentSet, widget.sets,
          //                   widget.isReps),
          //               clearIcon(context, checkIsOnTimeAndPauseTimer,
          //                   widget.onWill),
          //             ],
          //           ),
          //           SizedBox(
          //             height: SizeConfig.blockSizeVertical * 2,
          //           ),
          //           widget.exerciseTime == null
          //               ? SizedBox(
          //                   height: SizeConfig.blockSizeVertical * 9,
          //                 )
          //               : timeCont(widget.exerciseTime, widget.reps, context),
          //           SizedBox(
          //             height: SizeConfig.blockSizeVertical * 9,
          //           ),
          //           Row(
          //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //             crossAxisAlignment: CrossAxisAlignment.center,
          //             children: <Widget>[
          //               widget.index == 0
          //                   ? EmptyContainer()
          //                   : previousButton(
          //                       context, resetTimer, widget.playPrevious),
          //               widget.index == (widget.listLenght - 1)
          //                   ? EmptyContainer()
          //                   : nextButton(context, resetTimer, widget.playNext,
          //                       widget.controller),
          //             ],
          //           ),
          //           SizedBox(
          //             height: SizeConfig.blockSizeVertical * 4,
          //           ),
          //           Padding(
          //             padding: EdgeInsets.only(
          //               left: SizeConfig.blockSizeHorizontal * 3,
          //               right: showTime
          //                   ? SizeConfig.blockSizeHorizontal * 4
          //                   : SizeConfig.blockSizeHorizontal * 0.5,
          //             ),
          //             child: Row(
          //               crossAxisAlignment: CrossAxisAlignment.center,
          //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //               children: <Widget>[
          //                 widget.reps == null
          //                     ? EmptyContainer()
          //                     : repsWidget(context, widget.isReps,
          //                         widget.reps, widget.exerciseTime),
          //                 Stack(
          //                   children: <Widget>[
          //                     Column(
          //                       mainAxisAlignment: MainAxisAlignment.center,
          //                       crossAxisAlignment: CrossAxisAlignment.center,
          //                       children: <Widget>[
          //                         /// reps or timer,
          //                         /// depend on the exercise type
          //                         showTime
          //                             ? timerWidget(
          //                                 context,
          //                                 widget.showTimerDialog,
          //                                 format,
          //                                 widget.controller,
          //                                 isTimerPaused,
          //                                 _current,
          //                                 _pausedOn,
          //                                 countDownTimer,
          //                                 controllerColor,
          //                               )
          //                             : stopIcon(
          //                                 pressTimer, context, widget.isReps),
          //                         showTime
          //                             ? colorProgress(
          //                                 controllerColor, context)
          //                             : EmptyContainer(),
          //                       ],
          //                     ),
          //                   ],
          //                 ),
          //               ],
          //             ),
          //           ),
          //           SizedBox(
          //             height: SizeConfig.blockSizeVertical * 0.5,
          //           ),
          //           Padding(
          //             padding: EdgeInsets.only(
          //               left: SizeConfig.blockSizeHorizontal * 3,
          //             ),
          //             child: Row(
          //               crossAxisAlignment: CrossAxisAlignment.center,
          //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //               children: <Widget>[
          //                 nameWidget(
          //                     infoClicked,
          //                     goBackToChewie,
          //                     isFromPortrait,
          //                     context,
          //                     widget.controller,
          //                     checkIsOnTimeAndPauseTimer,
          //                     widget.name,
          //                     widget.video,
          //                     widget.tips,
          //                     widget.isReps,
          //                     widget.index,
          //                     widget.listLenght),
          //                 fullscreenButton(
          //                     context, widget.isReps, rotateScreen),
          //               ],
          //             ),
          //           ),
          //         ],
          //       ),
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
