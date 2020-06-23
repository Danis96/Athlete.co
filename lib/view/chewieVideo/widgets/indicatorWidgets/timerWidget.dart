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
    height: SizeConfig.blockSizeVertical * 5.5 ,
    width: SizeConfig.blockSizeHorizontal * 40 ,
    child: RaisedButton(
      elevation: 0,
        color: Colors.white.withOpacity(0.8),
      onPressed: () => pressTimer(),
      child: Text(
        format(_current),
        style: TextStyle(
            fontSize: SizeConfig.safeBlockHorizontal * 10,
            color: Colors.black,
            fontWeight: FontWeight.w400,
        ),
      ),
    ),
  );
}
