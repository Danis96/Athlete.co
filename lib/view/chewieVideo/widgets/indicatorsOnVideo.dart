import 'dart:async';

import 'package:attt/utils/globals.dart';
import 'package:attt/view/chewieVideo/widgets/globals.dart';
import 'package:attt/view/workout/widgets/info.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:attt/utils/size_config.dart';

class IndicatorsOnVideo extends StatefulWidget {
  final VideoPlayerController controller;
  final DocumentSnapshot userDocument, userTrainerDocument;
  final int index;
  final int duration;
  final int position;
  final Function showRest;

  IndicatorsOnVideo(
      {this.controller,
      this.position,
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
  Timer _timer;
  int time;

  @override
  void initState() {
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

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void startTimer() async {
    time = widget.duration;
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) => setState(
        () {
          if (time < 1) {
            timer.cancel();
          } else {
            time = time - 1;
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
        child: Padding(
          padding: EdgeInsets.only(
              top: SizeConfig.blockSizeVertical * 7,
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
                      // onTap: () => showTips(context),
                      child: Container(
                        child: Text(
                            exerciseSnapshots[widget.index].data['name'],
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
                          iconSize: SizeConfig.blockSizeHorizontal * 5,
                          icon: Icon(Icons.comment),
                          onPressed: () {}),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        /// reps
                        exerciseSnapshots[widget.index].data['isReps'] == 0
                            ? Container(
                                margin: EdgeInsets.only(
                                    top: SizeConfig.blockSizeVertical * 55),
                                child: Text(
                                    'x' +
                                        exerciseSnapshots[widget.index]
                                            .data['reps']
                                            .toString(),
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 32.0,
                                        fontWeight: FontWeight.bold,
                                        fontStyle: FontStyle.italic)),
                              )
                            : Container(
                                margin: EdgeInsets.only(
                                    top: SizeConfig.blockSizeVertical * 55),
                                child: Text(
                                    widget.duration != null
                                        ? '00 : ' +
                                            (widget.duration - widget.position)
                                                .toString()
                                        : '00 : 00',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 32.0,
                                        fontWeight: FontWeight.bold,
                                        fontStyle: FontStyle.italic)),
                              ),
                        Container(
                          padding: EdgeInsets.all(8.0),
                          margin: EdgeInsets.only(
                              top:
                                  // / showText
                                  // ?
                                  SizeConfig.blockSizeVertical * 1
                              // : 0
                              ),
                          child: Text(
                            '1/' +
                                exerciseSnapshots[widget.index]
                                    .data['sets']
                                    .toString(),
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
                    exerciseSnapshots[widget.index].data['isReps'] == 0
                        ? Container(
                            margin: EdgeInsets.only(
                                top: SizeConfig.blockSizeVertical * 55),
                            child: IconButton(
                              icon:
                                  Icon(CupertinoIcons.check_mark_circled_solid),
                              onPressed: () {
                                widget.showRest(context, widget.index);
                              },
                              color: Colors.white,
                              iconSize: 55.0,
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
        ));
  }

  /// [showTips]
  ///
  /// here we show the tips for the exact exercise
  showTips(BuildContext context) async {
    chewieController.pause();

    /// create overlay
    OverlayState overlayState = Overlay.of(context);
    OverlayEntry overlayEntry =
        OverlayEntry(builder: (BuildContext context) => InfoExercise());

    /// add to overlay overlayEntry that is rest widget
    overlayState.insert(overlayEntry);

    overlayEntry.remove();
  }
}
