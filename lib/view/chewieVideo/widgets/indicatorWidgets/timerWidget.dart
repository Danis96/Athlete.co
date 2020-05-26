import 'dart:async';

import 'package:attt/utils/globals.dart';
import 'package:attt/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:video_box/video.controller.dart';
import 'package:quiver/async.dart';

Widget timerWidget(
  BuildContext context,
  Function showTimerDialog,
  format,
  VideoController controller,
  bool isTimerPaused,
  Duration _current,
  _pausedOn,
  CountdownTimer countDownTimer,
  AnimationController controllerColor,
) {
  pressTimer() {
    showTimerDialog(context);
    controller.pause();
    _pausedOn = _current;
    countDownTimer.cancel();
    isTimerPaused = true;
    reseted = false;
  }

  return Container(
    margin: EdgeInsets.only(
      top: MediaQuery.of(context).orientation == Orientation.landscape
          ? SizeConfig.blockSizeVertical * 0
          : SizeConfig.blockSizeVertical * 19,
      left: MediaQuery.of(context).orientation == Orientation.landscape
          ? SizeConfig.blockSizeHorizontal * 0
          : SizeConfig.blockSizeHorizontal * 30,
    ),
    child: RaisedButton(
      color: Colors.white,
      onPressed: () => pressTimer(),
      child: Text(
        format(_current),
        style: TextStyle(
            fontSize:
                MediaQuery.of(context).orientation == Orientation.landscape
                    ? SizeConfig.safeBlockHorizontal * 5
                    : SizeConfig.safeBlockHorizontal * 12,
            color: Colors.black),
      ),
    ),
  );
}
