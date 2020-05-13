import 'dart:async';
import 'package:attt/utils/customScreenAnimation.dart';
import 'package:attt/utils/globals.dart';
import 'package:attt/view/chewieVideo/widgets/addNote.dart';
import 'package:attt/view/workout/widgets/info.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_box/video.controller.dart';
import 'package:attt/utils/size_config.dart';

class IndicatorsOnVideo extends StatefulWidget {
  final VideoController controller;
  final DocumentSnapshot userDocument, userTrainerDocument;
  final int index, listLenght;
  final int duration;
  final Function showRest, showAddNote, playNext;
  final int isReps, sets, reps, rest;
  final String name, workoutID, weekID, currentSet;
  final bool ctrl;

  IndicatorsOnVideo(
      {this.controller,
      this.currentSet,
      this.showAddNote,
      this.workoutID,
      this.playNext,
      this.listLenght,
      this.rest,
      this.weekID,
      this.name,
      this.sets,
      this.reps,
      this.isReps,
      this.showRest,
      this.index,
      this.userTrainerDocument,
      this.userDocument,
      this.ctrl,
      this.duration,
      });

  @override
  _IndicatorsOnVideoState createState() => _IndicatorsOnVideoState();
}

class _IndicatorsOnVideoState extends State<IndicatorsOnVideo>
    with TickerProviderStateMixin {
  AnimationController _controller;
  Animation<Offset> _offsetAnimation;
  AudioCache audioCache;
  AudioPlayer audioPlayer;

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
    _start = widget.duration;
    _isLessThan10 = false;

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
    _isLessThan10 = false;
    if (widget.index == 0) {
      if (pausedOn == null) {
        _start = widget.duration;
      } else {
        _start = pausedOn;
      }
    }
    if (widget.ctrl == true) {
      _start = widget.duration;
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
    videoTimer.cancel();
    _controller.dispose();
    super.dispose();
  }

  int _start;
  int pausedOn;
  bool timerPaused = false;
  bool _isLessThan10 = false;

  initializeAudioPlayer() async {
    audioPlayer = await audioCache.play('zvuk.mp3');
  }

  void startTimer(int startingValue) async {
    const oneSec = const Duration(seconds: 1);
    videoTimer = new Timer.periodic(
      oneSec,
      (Timer timer) => setState(
        () {
          if (startingValue < 1) {
            if (widget.rest > 0) {
              if (widget.index == widget.listLenght - 1) isTimerDone = true;
              widget.showRest(context);
            } else {
              if (widget.index == widget.listLenght - 1) isTimerDone = true;
              widget.showRest(context);
            }
            setState(() {
              restShowed = true;
              timerPaused = false;
            });
            timer.cancel();
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
                initializeAudioPlayer();
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
          // onDoubleTap: () {
          //     widget.controller.isFullScreen ? 
          //     SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
          //     :
          //     SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeRight]);
          // },
          onTap: () {
            if (!timerPaused) {
              pausedOn = _start;
              widget.controller.pause();
              if (widget.isReps == 1) {
                videoTimer.cancel();
              }
              if (_start <= 5) {
                audioPlayer.pause();
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
              if (pausedOn <= 5) {
                audioPlayer.resume();
              }
            }
            isTips = false;
          },
          child: Padding(
            padding: EdgeInsets.only(
                top: SizeConfig.blockSizeVertical * 3,
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
                          if (infoClicked) {
                            Timer(Duration(seconds: 0), () {
                              if (widget.isReps == 1) {
                                pausedOn = _start;
                                videoTimer.cancel();
                              }
                              if (_start <= 5) {
                                audioPlayer.pause();
                              }
                              setState(() {
                                timerPaused = true;
                                goBackToChewie = true;
                                infoClicked = false;
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
                          } else {
                            print('NE MOZE VIŠE PAŠA');
                          }
                        },
                        child: Container(
                          child: RichText(
                            text: TextSpan(children: [
                              TextSpan(
                                text: widget.name + ' ',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 32.0,
                                    fontWeight: FontWeight.bold,
                                    fontStyle: FontStyle.italic),
                              ),
                              WidgetSpan(
                                  child: Icon(
                                Icons.info,
                                size: SizeConfig.blockSizeHorizontal * 5,
                                color: Colors.white,
                              ))
                            ]),
                          ),
                        ),
                      ),

                      /// icon note
                      Container(
                        child: IconButton(
                            color: Colors.white,
                            iconSize: SizeConfig.blockSizeHorizontal * 5.5,
                            icon: Icon(Icons.comment),
                            onPressed: () {
                              if (noteClicked) {
                                Timer(Duration(seconds: 0), () {
                                  if (widget.isReps == 1) {
                                    pausedOn = _start;
                                    videoTimer.cancel();
                                  }
                                  if (_start <= 5) {
                                    audioPlayer.pause();
                                  }
                                  setState(() {
                                    timerPaused = true;
                                    noteClicked = false;
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
                              } else {
                                print('NE MOZE VIŠE PAŠA 2');
                              }
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
                              width: SizeConfig.blockSizeHorizontal * 24,
                              // decoration: BoxDecoration(
                              //     color: Color.fromRGBO(28, 28, 28, 0.7),
                              //     borderRadius:
                              //         BorderRadius.all(Radius.circular(4.0))),
                              // padding: EdgeInsets.all(20.0),
                            //   child: Text(
                            //     'PAUSED',
                            //     style: TextStyle(
                            //         color: Colors.white,
                            //         fontSize: SizeConfig.blockSizeVertical * 9,
                            //         fontWeight: FontWeight.bold,
                            //         fontStyle: FontStyle.italic),
                            //     textAlign: TextAlign.center,
                            //   ),
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
                                      top: MediaQuery.of(context).orientation == Orientation.portrait ?
                                           SizeConfig.blockSizeVertical * 27
                                           :
                                           SizeConfig.blockSizeVertical * 20
                                           ),
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
                              widget.currentSet + '/' + widget.sets.toString(),
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
                                  top: SizeConfig.blockSizeVertical * 25),
                              child: IconButton(
                                icon: Icon(
                                    CupertinoIcons.check_mark_circled_solid),
                                onPressed: () {
                                  if (widget.rest > 0) {
                                    if (widget.index == widget.listLenght - 1)
                                    isTimerDone = true;
                                    widget.showRest(context);
                                  } else {
                                    if (widget.index == widget.listLenght - 1)
                                    isTimerDone = true;
                                    widget.showRest(context);
                                  }
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
