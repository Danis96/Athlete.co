import 'dart:async';
import 'dart:ui';
import 'package:attt/utils/colors.dart';
import 'package:attt/utils/emptyContainer.dart';
import 'package:attt/utils/globals.dart';
import 'package:attt/utils/sound.dart';
import 'package:attt/view/chewieVideo/widgets/indicatorWidgets/asManyReps.dart';
import 'package:attt/view/chewieVideo/widgets/indicatorWidgets/clearButton.dart';
import 'package:attt/view/chewieVideo/widgets/indicatorWidgets/colorProgress.dart';
import 'package:attt/view/chewieVideo/widgets/indicatorWidgets/fullscreenButton.dart';
import 'package:attt/view/chewieVideo/widgets/indicatorWidgets/infoIcon.dart';
import 'package:attt/view/chewieVideo/widgets/indicatorWidgets/nameWidget.dart';
import 'package:attt/view/chewieVideo/widgets/indicatorWidgets/nextbutton.dart';
import 'package:attt/view/chewieVideo/widgets/indicatorWidgets/noteButton.dart';
import 'package:attt/view/chewieVideo/widgets/indicatorWidgets/previousButton.dart';
import 'package:attt/view/chewieVideo/widgets/indicatorWidgets/repsWidget.dart';
import 'package:attt/view/chewieVideo/widgets/indicatorWidgets/setsWidget.dart';
import 'package:attt/view/chewieVideo/widgets/indicatorWidgets/stopwatchIcon.dart';
import 'package:attt/view/chewieVideo/widgets/indicatorWidgets/timeCont.dart';
import 'package:attt/view/chewieVideo/widgets/indicatorWidgets/timerWidget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
  final int isReps, sets;
  final reps;
  final String name,
      workoutID,
      weekID,
      currentSet,
      repsDescription,
      video,
      exerciseTime;
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
      this.showTimerDialog});

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
    controllerColor = AnimationController(
      vsync: this,
      duration: Duration(minutes: 0, seconds: 0),
    );

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
    super.dispose();
  }

  /// for displaying the current time
  Duration _current = Duration();

  /// when we pause video/timer we want to get the current time
  Duration _pausedOn = Duration();

  /// initial calue of [d1] => before we choose the time in dialog
  var d1 = Duration();

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
      if (_current.inSeconds != 0) {
        print('Nece biti zvuka');
      } else {
        SoundPlayer().playSound();
      }
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
      controllerColor = AnimationController(
        vsync: this,
        duration: Duration(
            minutes: minutesForIndicators, seconds: secondsForIndicators),
      );
      Timer(Duration(milliseconds: 100), () {
        widget.controller.play();
        startTimer(d1);
        controllerColor.reverse(
            from: controllerColor.value == 0.0 ? 1.0 : controllerColor.value);
        showTime = true;
      });
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
                              checkIsOnTimeAndPauseTimer,
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
                    SizedBox(
                      height: SizeConfig.blockSizeVertical * 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        nameWidget(
                          infoClicked,
                          goBackToChewie,
                          isFromPortrait,
                          context,
                          widget.controller,
                          checkIsOnTimeAndPauseTimer,
                          widget.name,
                          widget.video,
                          widget.tips,
                          widget.isReps,
                          widget.index,
                          widget.listLenght,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: SizeConfig.blockSizeVertical * 8,
                    ),
                    Column(
                      children: <Widget>[
                        widget.repsDescription != null ||
                                widget.repsDescription != ''
                            ? Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(5.0),
                                      topLeft: Radius.circular(5.0)),
                                  color: Colors.grey,
                                ),
                                width: SizeConfig.blockSizeHorizontal * 85,
                                height: SizeConfig.blockSizeVertical * 7,
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
                          width: SizeConfig.blockSizeHorizontal * 85,
                          height: SizeConfig.blockSizeVertical * 22,
                          decoration: BoxDecoration(
                            borderRadius: widget.repsDescription != null ||
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
                                child: RaisedButton(
                                  color: MyColors().lightBlack,
                                  child: Text(
                                    'DONE',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                        fontSize:
                                            SizeConfig.safeBlockHorizontal * 4),
                                  ),
                                  onPressed: () {},
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
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
                                        resetTimer,
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
                                        checkIsOnTimeAndPauseTimer,
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
                                        checkIsOnTimeAndPauseTimer,
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
                                        resetTimer,
                                        widget.playNext,
                                        widget.controller,
                                      ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                )
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
                                  checkIsOnTimeAndPauseTimer,
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
                        SizedBox(
                          height: SizeConfig.blockSizeVertical * 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            nameWidget(
                              infoClicked,
                              goBackToChewie,
                              isFromPortrait,
                              context,
                              widget.controller,
                              checkIsOnTimeAndPauseTimer,
                              widget.name,
                              widget.video,
                              widget.tips,
                              widget.isReps,
                              widget.index,
                              widget.listLenght,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: SizeConfig.blockSizeVertical * 8,
                        ),
                        Column(
                          children: <Widget>[
                            widget.repsDescription != null ||
                                    widget.repsDescription != ''
                                ? Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(5.0),
                                          topLeft: Radius.circular(5.0)),
                                      color: Colors.grey,
                                    ),
                                    width: SizeConfig.blockSizeHorizontal * 85,
                                    height: SizeConfig.blockSizeVertical * 7,
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
                              width: SizeConfig.blockSizeHorizontal * 85,
                              height: SizeConfig.blockSizeVertical * 22,
                              decoration: BoxDecoration(
                                borderRadius: widget.repsDescription != null
                                    ? BorderRadius.only(
                                        bottomLeft: Radius.circular(5.0),
                                        bottomRight: Radius.circular(5.0))
                                    : BorderRadius.all(Radius.circular(5.0)),
                                color: Colors.white,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Container(
                                      height: SizeConfig.blockSizeVertical * 10,
                                      child: timerWidget(
                                          context,
                                          widget.showTimerDialog,
                                          format,
                                          widget.controller,
                                          isTimerPaused,
                                          _current,
                                          _pausedOn,
                                          countDownTimer,
                                          controllerColor)),
                                  Container(
                                    width: SizeConfig.blockSizeHorizontal * 60,
                                    child: RaisedButton(
                                      color: MyColors().lightBlack,
                                      child: Text(
                                        'DONE',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600,
                                            fontSize:
                                                SizeConfig.safeBlockHorizontal *
                                                    4),
                                      ),
                                      onPressed: () {},
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
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
                                            resetTimer,
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
                                            checkIsOnTimeAndPauseTimer,
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
                                            checkIsOnTimeAndPauseTimer,
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
                                            resetTimer,
                                            widget.playNext,
                                            widget.controller,
                                          ),
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
      checkIsOnTimeAndPauseTimer();
    } else {
      widget.controller.play();

      if (isTimeChoosed) {
        startTimer(d1);
        controllerColor.reverse(
            from: controllerColor.value == 0.0 ? 1.0 : controllerColor.value);
      }
      if (isTimerPaused) {
        startTimer(_pausedOn);
        controllerColor.reverse(
            from: controllerColor.value == 0.0 ? 1.0 : controllerColor.value);
      }
    }
  }

  pressTimer() {
    widget.showTimerDialog(context);
    widget.controller.pause();
    _pausedOn = _current;
    if (countDownTimer != null) {
      countDownTimer.cancel();
    }
    isTimerPaused = true;
  }

  resetTimer() {
    if (countDownTimer != null) {
      countDownTimer.cancel();
      setState(() {
        _current = Duration();
        _pausedOn = Duration();
        controllerColor.value = 0.0;
      });
      showTime = false;
    }
  }

  /// if exercise is on time, het the paused time,
  /// cancel the timer, set [isTimerPaused] on true
  checkIsOnTimeAndPauseTimer() {
    if (countDownTimer != null) {
      if (widget.isReps == 1) {
        _pausedOn = _current;
        countDownTimer.cancel();
        controllerColor.stop();
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
              : SystemChrome.setPreferredOrientations([
                  DeviceOrientation.landscapeRight,
                  DeviceOrientation.landscapeLeft,
                ]),
        });
  }
}
