import 'package:attt/utils/globals.dart';
import 'package:attt/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:video_box/video.controller.dart';
import 'package:quiver/async.dart';

Widget timerWidget(
  BuildContext context,
  Function showTimerDialog,
  VideoController controller,
  String timeToDisplay,
) {
  pressTimer() {
    showTimerDialog(context);
    controller.pause();
    isTimerPaused = true;
    reseted = false;
  }

  return Container(
    height: SizeConfig.blockSizeVertical * 5.5,
    width: SizeConfig.blockSizeHorizontal * 40,
    child: RaisedButton(
      elevation: 0,
      disabledColor: Colors.white.withOpacity(0.8),
      color: Colors.white.withOpacity(0.8),
      onPressed: null,
      child: Text(
        timeToDisplay,
        style: TextStyle(
          fontSize: SizeConfig.safeBlockHorizontal * 10,
          color: Colors.black,
          fontWeight: FontWeight.w400,
        ),
      ),
    ),
  );
}
