import 'package:attt/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:video_box/video.controller.dart';

Widget nextButton(
    BuildContext context, Function  playNext, resetTimer, VideoController vc) {
  return Container(
    height: SizeConfig.blockSizeHorizontal * 12,
    width: SizeConfig.blockSizeHorizontal * 12,
    child: ClipOval(
        child: Material(
      color: Colors.white,
      child: InkWell(
        onTap: () {
            playNext();
            resetTimer();
        },
        child: Icon(
          Icons.arrow_forward,
          size: SizeConfig.blockSizeHorizontal * 6,
        ),
      ),
    )),
  );
}
