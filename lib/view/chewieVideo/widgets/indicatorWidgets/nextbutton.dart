import 'dart:async';

import 'package:attt/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:video_box/video.controller.dart';

Widget nextButton(
    BuildContext context, Function  playNext, VideoController vc, Timer timer) {
  return Container(
    height: SizeConfig.blockSizeHorizontal * 10,
    width: SizeConfig.blockSizeHorizontal * 10,
    child: ClipOval(
        child: Material(
      color: Colors.white,
      child: InkWell(
        onTap: () {
          if(timer == null) {
            print('Timer je null');
            playNext();
          } else {
            timer.cancel();
            playNext();
          }
        },
        child: Icon(
          Icons.arrow_forward,
          size: SizeConfig.blockSizeHorizontal * 5,
        ),
      ),
    )),
  );
}
