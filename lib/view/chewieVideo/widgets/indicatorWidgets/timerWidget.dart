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
        top:  MediaQuery.of(context).orientation ==
            Orientation.landscape
            ? SizeConfig.blockSizeVertical * 28 : SizeConfig.blockSizeVertical * 9,
        left: MediaQuery.of(context).orientation == Orientation.landscape
            ? SizeConfig.blockSizeHorizontal * 35 : SizeConfig.blockSizeHorizontal * 15,
    ),
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
            fontSize: MediaQuery.of(context).orientation ==
                Orientation.landscape
                ? SizeConfig.safeBlockHorizontal * 5 :  SizeConfig.safeBlockHorizontal * 12, color: Colors.black),
      ),
    ),
  );
}
