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
    height: MediaQuery.of(context).orientation == Orientation.portrait
        ? SizeConfig.blockSizeVertical * 5.5 : SizeConfig.blockSizeVertical * 10,
    width: MediaQuery.of(context).orientation == Orientation.portrait
        ? SizeConfig.blockSizeHorizontal * 35 :  SizeConfig.blockSizeHorizontal * 17 ,
    margin: EdgeInsets.only(
      top: MediaQuery.of(context).orientation == Orientation.landscape
          ? SizeConfig.blockSizeVertical * 22
          : SizeConfig.blockSizeVertical * 18,
      left: MediaQuery.of(context).orientation == Orientation.landscape
          ? SizeConfig.blockSizeHorizontal * 68
          : SizeConfig.blockSizeHorizontal * 27,
    ),
    child: RaisedButton(
        color: Colors.white.withOpacity(0.8),
      onPressed: () => pressTimer(),
      child: Text(
        format(_current),
        style: TextStyle(
            fontSize:
            MediaQuery.of(context).orientation == Orientation.portrait
                ? SizeConfig.safeBlockHorizontal * 7 : SizeConfig.safeBlockHorizontal * 4,
            color: Colors.black),
      ),
    ),
  );
}
