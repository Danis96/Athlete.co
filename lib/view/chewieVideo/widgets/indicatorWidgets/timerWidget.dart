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
    Duration _current, _pausedOn,
    CountdownTimer countDownTimer
) {
  return Container(
    margin: EdgeInsets.only(
        top: SizeConfig.blockSizeVertical * 4,
        left: SizeConfig.blockSizeHorizontal * 31),
    child: RaisedButton(
      color: Colors.white,
      onPressed: () {
        showTimerDialog(context);
        controller.pause();
        _pausedOn = _current;
        countDownTimer.cancel();
        isTimerPaused = true;
      },
      child: Text(
        format(_current),
        style: TextStyle(
            fontSize: SizeConfig.safeBlockHorizontal * 10, color: Colors.black),
      ),
    ),
  );
}
