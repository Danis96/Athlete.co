import 'dart:async';
import 'package:attt/utils/customScreenAnimation.dart';
import 'package:attt/utils/globals.dart';
import 'package:attt/view/chewieVideo/widgets/addNote.dart';
import 'package:attt/view/trainingPlan/pages/trainingPlan.dart';
import 'package:attt/view/workout/widgets/info.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_box/video.controller.dart';
import 'package:attt/utils/size_config.dart';
import 'package:attt/utils/globals.dart';

class IndicatorsOnVideo extends StatefulWidget {
  final VideoController controller;
  final DocumentSnapshot userDocument, userTrainerDocument;
  final int index, listLenght;
  final int duration;
  final Function showRest, showAddNote;
  final int isReps, sets, reps;
  final String name, workoutID, weekID;

  IndicatorsOnVideo(
      {this.controller,
      this.showAddNote,
      this.workoutID,
      this.listLenght,
      this.weekID,
      this.name,
      this.sets,
      this.reps,
      this.isReps,
      this.showRest,
      this.index,
      this.userTrainerDocument,
      this.userDocument,
      this.duration});

  @override
  _IndicatorsOnVideoState createState() => _IndicatorsOnVideoState();
}

class _IndicatorsOnVideoState extends State<IndicatorsOnVideo>
    with TickerProviderStateMixin {
  AnimationController _controller;
  Animation<Offset> _offsetAnimation;
  AudioCache audioCache;

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeRight]);
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

    _start = widget.duration;

    if (widget.index == 0) {
      if (widget.isReps == 1 && !timerPaused) {
        Timer(Duration(seconds: 6), () {
          startTimer(_start);
          widget.controller.play();
        });
      } else if (widget.isReps == 0) {
        Timer(Duration(seconds: 6), () {
          widget.controller.play();
        });
      }
    } else {
      if (widget.isReps == 1 && !timerPaused) {
        startTimer(_start);
        widget.controller.play();
      } else if (widget.isReps == 0) {
        widget.controller.play();
      }
    }

    audioCache = AudioCache(
        prefix: "audio/",
        fixedPlayer: AudioPlayer()..setReleaseMode(ReleaseMode.STOP));
  }

  @override
  void didUpdateWidget(IndicatorsOnVideo oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.index == 0) {
      if (pausedOn == null) {
        _start = widget.duration;
      } else {
        _start = pausedOn;
      }
    }
    if (widget.index > 0) {
      if (widget.isReps == 1 && !timerPaused) {
        startTimer(_start);
        widget.controller.play();
      } else if (widget.isReps == 0 && !restShowed) {
        widget.controller.play();
      }
    }
  }

  @override
  void dispose() {
    _timer.cancel();
    _controller.dispose();
    super.dispose();
  }

  int _start;
  int pausedOn;
  Timer _timer;
  bool timerPaused = false;
  bool _isLessThan10 = false;

  void startTimer(int startingValue) async {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) => setState(
        () {
          if (startingValue < 1) {
            setState(() {
              restShowed = true;
              timerPaused = false;
            });
            timer.cancel();
            if (widget.index == widget.listLenght - 1) isTimerDone = true;
            widget.showRest(context);
          } else {
            setState(() {
              startingValue = startingValue - 1;
              _start = startingValue;
            });
            if (_start < 10) {
              setState(() {
                _isLessThan10 = true;
              });
              if (startingValue == 5 && widget.isReps == 1) {
                audioCache.play('zvuk.mp3');
              }
            }
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SlideTransition(
        position: _offsetAnimation,
        child: InkWell(
          onTap: () {
            if (!timerPaused) {
              pausedOn = _start;
              widget.controller.pause();
              if (widget.isReps == 1) {
                _timer.cancel();
              }
              setState(() {
                timerPaused = true;
              });
            } else {
              widget.controller.play();
              if (widget.isReps == 1) {
                startTimer(pausedOn);
              }
              setState(() {
                timerPaused = false;
              });
            }
            isTips = false;
          },
          child: Padding(
            padding: EdgeInsets.only(
                top: SizeConfig.blockSizeVertical * 3,
                bottom: SizeConfig.blockSizeVertical * 2,
                left: SizeConfig.blockSizeHorizontal * 3,
                right: SizeConfig.blockSizeVertical * 3),
            child: Center(
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      /// number of reps
                      GestureDetector(
                        onTap: () {
                          Timer(Duration(seconds: 2), () {
                            if (widget.isReps == 1) {
                              pausedOn = _start;
                              _timer.cancel();
                            }
                            setState(() {
                              timerPaused = true;
                              goBackToChewie = true;
                            });
                            widget.controller.pause();
                            _start = pausedOn;
                            Navigator.of(context).push(SlideAnimationTeen(
                              widget: InfoExercise(
                                vc: widget.controller,
                                exerciseNameForInfo: widget.name,
                                exerciseTips: exTips,
                                exerciseVideoForInfo: exVideo,
                              ),
                            ));
                          });
                        },
                        child: Container(
                          child: Text(widget.name,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 32.0,
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FontStyle.italic)),
                        ),
                      ),

                      /// icon note
                      Container(
                        child: IconButton(
                            color: Colors.white,
                            iconSize: SizeConfig.blockSizeHorizontal * 5.5,
                            icon: Icon(Icons.comment),
                            onPressed: () {
                              Timer(Duration(seconds: 2), () {
                                if (widget.isReps == 1) {
                                  pausedOn = _start;
                                  _timer.cancel();
                                }
                                setState(() {
                                  timerPaused = true;
                                });
                                widget.controller.pause();
                                _start = pausedOn;
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
                                        duration: widget.duration,
                                        isReps: widget.isReps,
                                        reps: widget.reps,
                                        sets: widget.sets,
                                        name: widget.name,
                                        showRest: widget.showRest,
                                        workoutID: widget.workoutID,
                                        weekID: widget.weekID),
                                  ),
                                );
                              });
                            }),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      timerPaused || isTips
                          ? Container(
                              height: SizeConfig.blockSizeVertical * 20,
                              width: SizeConfig.blockSizeHorizontal * 27,
                              decoration: BoxDecoration(
                                  color: Color.fromRGBO(28, 28, 28, 0.7),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(4.0))),
                              padding: EdgeInsets.all(20.0),
                              child: Text(
                                'PAUSED',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: SizeConfig.blockSizeVertical * 9,
                                    fontWeight: FontWeight.bold,
                                    fontStyle: FontStyle.italic),
                                textAlign: TextAlign.center,
                              ),
                            )
                          : Container(
                              height: SizeConfig.blockSizeVertical * 20,
                              width: SizeConfig.blockSizeHorizontal * 24,
                            )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          /// reps
                          widget.isReps == 0
                              ? Container(
                                  margin: EdgeInsets.only(
                                      top: SizeConfig.blockSizeVertical * 35),
                                  child: Text('x' + widget.reps.toString(),
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 32.0,
                                          fontWeight: FontWeight.bold,
                                          fontStyle: FontStyle.italic)),
                                )
                              : Container(
                                  margin: EdgeInsets.only(
                                      top: SizeConfig.blockSizeVertical * 35),
                                  child: Text(
                                      _isLessThan10
                                          ? timerPaused
                                              ? '00:0' + pausedOn.toString()
                                              : '00:0' + _start.toString()
                                          : timerPaused
                                              ? '00:' + pausedOn.toString()
                                              : '00:' + _start.toString(),
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 32.0,
                                          fontWeight: FontWeight.bold,
                                          fontStyle: FontStyle.italic)),
                                ),
                          Container(
                            padding: EdgeInsets.all(8.0),
                            margin: EdgeInsets.only(
                                top: SizeConfig.blockSizeVertical * 1),
                            child: Text(
                              '1/' + widget.sets.toString(),
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 25.0,
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FontStyle.italic),
                            ),
                          ),
                        ],
                      ),

                      /// done icon
                      widget.isReps == 0
                          ? Container(
                              margin: EdgeInsets.only(
                                  top: SizeConfig.blockSizeVertical * 10),
                              child: IconButton(
                                icon: Icon(
                                    CupertinoIcons.check_mark_circled_solid),
                                onPressed: () {
                                  if (widget.index == widget.listLenght - 1)
                                    isTimerDone = true;
                                  widget.showRest(context);
                                  setState(() {
                                    restShowed = true;
                                    timerPaused = false;
                                  });
                                },
                                color: Colors.white,
                                iconSize: SizeConfig.blockSizeHorizontal * 7,
                              ),
                            )
                          : Container(
                              width: 0,
                              height: 0,
                            ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
