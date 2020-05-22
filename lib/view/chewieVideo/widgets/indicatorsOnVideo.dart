import 'dart:async';
import 'package:attt/utils/colors.dart';
import 'package:attt/utils/emptyContainer.dart';
import 'package:attt/utils/globals.dart';
import 'package:attt/view/chewieVideo/widgets/addNote.dart';
import 'package:attt/view/workout/widgets/info.dart';
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
    with TickerProviderStateMixin {
  AnimationController _controller;
  Animation<Offset> _offsetAnimation;
  bool isOrientation = false;

  @override
  void initState() {
    super.initState();
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

  @override
  void dispose() {
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
    if(activatePause) {
      checkIsOnTimeAndPauseTimer();
    }
    if(resetFromChewie) {
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
                        : SizeConfig.blockSizeVertical * 29),
                child: Center(
                  child: Column(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(
                            bottom: MediaQuery.of(context).orientation ==
                                    Orientation.landscape
                                ? SizeConfig.blockSizeVertical * 0
                                : SizeConfig.blockSizeVertical * 10,
                            right: MediaQuery.of(context).orientation ==
                                    Orientation.landscape
                                ? SizeConfig.blockSizeHorizontal * 90
                                : SizeConfig.blockSizeHorizontal * 80),
                        child: IconButton(
                          icon: Icon(Icons.clear),
                          iconSize: MediaQuery.of(context).orientation ==
                                  Orientation.landscape
                              ? SizeConfig.blockSizeHorizontal * 4
                              : SizeConfig.blockSizeHorizontal * 7,
                          onPressed: ()  {
                            checkIsOnTimeAndPauseTimer();
                            widget.onWill();
                          },
                          color: Colors.white,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          widget.index == 0
                              ? EmptyContainer()
                              : Container(
                                  child: IconButton(
                                    icon: Icon(Icons.skip_previous),
                                    iconSize: MediaQuery.of(context)
                                                .orientation ==
                                            Orientation.landscape
                                        ? SizeConfig.blockSizeHorizontal * 6
                                        : SizeConfig.blockSizeHorizontal * 10,
                                    color: Colors.white54,
                                    onPressed: () {
                                      widget.playPrevious();
                                      resetTimer();
                                    },
                                  ),
                                ),
                          widget.index == (widget.listLenght - 1)
                              ? Container(
                                  height: MediaQuery.of(context).orientation ==
                                          Orientation.landscape
                                      ? SizeConfig.blockSizeHorizontal * 10
                                      : SizeConfig.blockSizeHorizontal * 10,
                                  margin: EdgeInsets.only(
                                      top: MediaQuery.of(context).orientation ==
                                              Orientation.landscape
                                          ? SizeConfig.blockSizeVertical * 0
                                          : SizeConfig.blockSizeVertical * 5,
                                      left: MediaQuery.of(context)
                                                  .orientation ==
                                              Orientation.landscape
                                          ? 0
                                          : SizeConfig.blockSizeHorizontal * 5),
                                  child: FlatButton(
                                    child: Text('Finish Workout'),
                                    onPressed: () {
                                      widget.playNext();
                                      resetTimer();
                                    },
                                    color: Colors.white,
                                  ),
                                )
                              : Container(
                                  child: IconButton(
                                    icon: Icon(Icons.skip_next),
                                    iconSize: MediaQuery.of(context)
                                                .orientation ==
                                            Orientation.landscape
                                        ? SizeConfig.blockSizeHorizontal * 6
                                        : SizeConfig.blockSizeHorizontal * 10,
                                    color: Colors.white54,
                                    onPressed: () {
                                      widget.playNext();
                                      resetTimer();
                                    },
                                  ),
                                ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MediaQuery.of(context).orientation ==
                                Orientation.landscape
                            ? MainAxisAlignment.spaceBetween
                            : MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          /// number of reps
                          GestureDetector(
                            onTap: () {
                              if (infoClicked) {
                                 checkIsOnTimeAndPauseTimer();
                                  setState(() {
                                    goBackToChewie = true;
                                    infoClicked = false;
                                  });
                                  widget.controller.pause();

                                  if (MediaQuery.of(context).orientation ==
                                      Orientation.portrait)
                                    isFromPortrait = true;
                                  else
                                    isFromPortrait = false;
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (_) => InfoExercise(
                                      vc: widget.controller,
                                      exerciseNameForInfo: widget.name,
                                      exerciseTips: exTips,
                                      exerciseVideoForInfo: exVideo,
                                    ),
                                  ));
                              } else {
                                print('NE MOZE VIŠE PAŠA');
                              }
                            },
                            child: Container(
                              width: SizeConfig.blockSizeHorizontal * 75,
                              margin: EdgeInsets.only(
                                  top: MediaQuery.of(context).orientation ==
                                          Orientation.landscape
                                      ? SizeConfig.blockSizeVertical * 2
                                      : SizeConfig.blockSizeVertical * 8),
                              child: RichText(
                                overflow: TextOverflow.ellipsis,
                                text: TextSpan(children: [
                                  TextSpan(
                                    text: widget.name + ' ',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: MediaQuery.of(context)
                                                    .orientation ==
                                                Orientation.landscape
                                            ? SizeConfig.safeBlockHorizontal * 3
                                            : SizeConfig.safeBlockHorizontal *
                                                6,
                                        fontWeight: FontWeight.bold,
                                        fontStyle: FontStyle.italic),
                                  ),
                                  WidgetSpan(
                                      alignment: PlaceholderAlignment.bottom,
                                      child: Icon(
                                        Icons.info,
                                        size: MediaQuery.of(context)
                                                    .orientation ==
                                                Orientation.landscape
                                            ? SizeConfig.blockSizeHorizontal * 2
                                            : SizeConfig.blockSizeHorizontal *
                                                3,
                                        color: Colors.white,
                                      ))
                                ]),
                              ),
                            ),
                          ),

                          /// icon note
                          Container(
                            margin: EdgeInsets.only(
                                top: MediaQuery.of(context).orientation ==
                                        Orientation.landscape
                                    ? SizeConfig.blockSizeVertical * 6
                                    : SizeConfig.blockSizeVertical * 8),
                            child: IconButton(
                                color: Colors.white,
                                iconSize: MediaQuery.of(context).orientation ==
                                        Orientation.landscape
                                    ? SizeConfig.blockSizeHorizontal * 4.5
                                    : SizeConfig.blockSizeHorizontal * 7.5,
                                icon: Icon(Icons.comment),
                                onPressed: () {
                                  if (noteClicked) {
                                      checkIsOnTimeAndPauseTimer();
                                      setState(() {
                                        noteClicked = false;
                                      });
                                      widget.controller.pause();
                                      if (MediaQuery.of(context).orientation ==
                                          Orientation.portrait)
                                        isFromPortrait = true;
                                      else
                                        isFromPortrait = false;
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          maintainState: true,
                                          builder: (_) => AddNote(
                                              controller: widget.controller,
                                              listLenght: widget.listLenght,
                                              userDocument: widget.userDocument,
                                              userTrainerDocument:
                                                  widget.userTrainerDocument,
                                              index: widget.index,
                                              isReps: widget.isReps,
                                              reps: widget.reps,
                                              sets: widget.sets,
                                              name: widget.name,
                                              workoutID: widget.workoutID,
                                              weekID: widget.weekID),
                                        ),
                                      );
                                  } else {
                                    print('NE MOZE VIŠE PAŠA 2');
                                  }
                                }),
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              widget.repsDescription ==
                                      'as many reps as possible'
                                  ? Container(
                                      margin: EdgeInsets.only(
                                          top: MediaQuery.of(context)
                                                      .orientation ==
                                                  Orientation.landscape
                                              ? SizeConfig.blockSizeVertical * 0
                                              : SizeConfig.blockSizeVertical *
                                                  3,
                                          right: MediaQuery.of(context)
                                                      .orientation ==
                                                  Orientation.landscape
                                              ? SizeConfig.blockSizeHorizontal *
                                                  2.5
                                              : SizeConfig.blockSizeHorizontal *
                                                  0,
                                          left: MediaQuery.of(context)
                                                      .orientation ==
                                                  Orientation.landscape
                                              ? SizeConfig.blockSizeHorizontal *
                                                  0
                                              : SizeConfig.blockSizeHorizontal *
                                                  35),
                                      width: MediaQuery.of(context)
                                                  .orientation ==
                                              Orientation.landscape
                                          ? SizeConfig.blockSizeHorizontal * 16
                                          : SizeConfig.blockSizeHorizontal * 30,
                                      child: Text(
                                        'AS MANY REPS AS POSSIBLE',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600,
                                            fontStyle: FontStyle.italic,
                                            fontSize: MediaQuery.of(context)
                                                        .orientation ==
                                                    Orientation.landscape
                                                ? SizeConfig.safeBlockVertical *
                                                    4
                                                : SizeConfig.safeBlockVertical *
                                                    2),
                                        textAlign: TextAlign.center,
                                      ),
                                    )
                                  : Container(
                                      margin: EdgeInsets.only(
                                          top: MediaQuery.of(context)
                                                      .orientation ==
                                                  Orientation.landscape
                                              ? SizeConfig.blockSizeVertical * 0
                                              : SizeConfig.blockSizeVertical *
                                                  3,
                                          right: MediaQuery.of(context)
                                                      .orientation ==
                                                  Orientation.landscape
                                              ? SizeConfig.blockSizeHorizontal *
                                                  2.5
                                              : SizeConfig.blockSizeHorizontal *
                                                  0,
                                          left: MediaQuery.of(context)
                                                      .orientation ==
                                                  Orientation.landscape
                                              ? SizeConfig.blockSizeHorizontal *
                                                  0
                                              : SizeConfig.blockSizeHorizontal *
                                                  35),
                                      width: MediaQuery.of(context)
                                                  .orientation ==
                                              Orientation.landscape
                                          ? SizeConfig.blockSizeHorizontal * 16
                                          : SizeConfig.blockSizeHorizontal * 30,
                                    ),
                              widget.isReps == 0
                                  ? Container(
                                      margin: EdgeInsets.only(
                                          top: MediaQuery.of(context)
                                                      .orientation ==
                                                  Orientation.landscape
                                              ? SizeConfig.blockSizeVertical * 0
                                              : widget.isReps == 0
                                                  ? SizeConfig.blockSizeVertical *
                                                      3
                                                  : SizeConfig.blockSizeVertical *
                                                      2,
                                          right: MediaQuery.of(context)
                                                      .orientation ==
                                                  Orientation.landscape
                                              ? SizeConfig.blockSizeHorizontal *
                                                  4
                                              : SizeConfig.blockSizeHorizontal *
                                                  0,
                                          left: MediaQuery.of(context)
                                                      .orientation ==
                                                  Orientation.landscape
                                              ? SizeConfig.blockSizeHorizontal * 0
                                              : SizeConfig.blockSizeHorizontal * 33),
                                      child: Text('x' + widget.reps.toString(),
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: MediaQuery.of(context)
                                                          .orientation ==
                                                      Orientation.landscape
                                                  ? SizeConfig
                                                          .blockSizeVertical *
                                                      10
                                                  : SizeConfig
                                                          .blockSizeVertical *
                                                      5,
                                              fontWeight: FontWeight.bold,
                                              fontStyle: FontStyle.italic)),
                                    )
                                  :
//                              EmptyContainer(),
                                  GestureDetector(
                                      onTap: () {
                                        widget.showTimerDialog(context);
                                        widget.controller.pause();
                                        _pausedOn = _current;
                                        countDownTimer.cancel();
                                        isTimerPaused = true;
                                      },
                                      child: Container(
                                        margin: EdgeInsets.only(
                                            top: SizeConfig.blockSizeVertical *
                                                4,
                                            left:
                                                SizeConfig.blockSizeHorizontal *
                                                    32),
                                        child: Text(
                                          format(_current),
                                          style: TextStyle(
                                              fontSize: SizeConfig
                                                      .safeBlockHorizontal *
                                                  10,
                                              color: Colors.white),
                                        ),
                                      ),
                                    ),
                              Container(
                                padding: MediaQuery.of(context).orientation ==
                                        Orientation.landscape
                                    ? EdgeInsets.all(0)
                                    : EdgeInsets.all(4.0),
                                margin: EdgeInsets.only(
                                    top: MediaQuery.of(context).orientation ==
                                            Orientation.landscape
                                        ? SizeConfig.blockSizeVertical * 1
                                        : SizeConfig.blockSizeVertical * 2,
                                    right: MediaQuery.of(context).orientation ==
                                            Orientation.landscape
                                        ? SizeConfig.blockSizeHorizontal * 4
                                        : SizeConfig.blockSizeHorizontal * 0,
                                    left: MediaQuery.of(context).orientation ==
                                            Orientation.landscape
                                        ? SizeConfig.blockSizeHorizontal * 0
                                        : SizeConfig.blockSizeHorizontal * 30),
                                child: Text(
                                  widget.currentSet +
                                      '/' +
                                      widget.sets.toString() +
                                      ' Sets',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize:
                                          MediaQuery.of(context).orientation ==
                                                  Orientation.landscape
                                              ? 25.0
                                              : SizeConfig.safeBlockHorizontal *
                                                  6.0,
                                      fontWeight: FontWeight.bold,
                                      fontStyle: FontStyle.italic),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: <Widget>[
                              /// done icon
                              widget.isReps == 0
                                  ? EmptyContainer()
                                  : Container(
                                      width: 0,
                                      height: MediaQuery.of(context)
                                                  .orientation ==
                                              Orientation.landscape
                                          ? SizeConfig.blockSizeVertical * 30
                                          : SizeConfig.blockSizeVertical * 20,
                                    ),
                              Container(
                                margin: EdgeInsets.only(
                                    top: MediaQuery.of(context).orientation ==
                                            Orientation.landscape
                                        ? widget.isReps == 0
                                            ? SizeConfig.blockSizeVertical * 6.7
                                            : SizeConfig.blockSizeVertical * 18
                                        : widget.isReps == 0
                                            ? SizeConfig.blockSizeVertical * 7.8
                                            : SizeConfig.blockSizeVertical * 0,
                                    left: MediaQuery.of(context).orientation ==
                                            Orientation.landscape
                                        ? SizeConfig.blockSizeHorizontal * 4
                                        : widget.isReps == 0
                                            ? SizeConfig.blockSizeHorizontal *
                                                12
                                            : SizeConfig.blockSizeHorizontal *
                                                12),
                                child: IconButton(
                                    icon: Icon(Icons.fullscreen),
                                    color: Colors.white,
                                    onPressed: () => rotateScreen()),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            )));
  }

  pauseAndPlayFunction() {
    /// if controller is playing - pause it, else play it
    if (widget.controller.value.isPlaying) {
      widget.controller.pause();
      checkIsOnTimeAndPauseTimer();
    } else {
      widget.controller.play();
         if(reseted) {
            print('Timer has been reseted');
              reseted = false;
         } else {
           if (widget.isReps == 1) {
             if (isTimeChoosed) {
               startTimer(d1);
             }
             if (isTimerPaused) {
               startTimer(_pausedOn);
             }
           }
         }

    }
  }

  resetTimer() {
    if(countDownTimer != null) {
      countDownTimer.cancel();
      _current = Duration(seconds: 0);
      reseted = true;
    }
  }


  /// if exercise is on time, het the paused time,
  /// cancel the timer, set [isTimerPaused] on true
  checkIsOnTimeAndPauseTimer() {
    if (widget.isReps == 1) {
      _pausedOn = _current;
      countDownTimer.cancel();
      isTimerPaused = true;
    }
  }

  checkIsCountDownRunning() {
    if(countDownTimer != null) {
      if(countDownTimer.isRunning) {
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
