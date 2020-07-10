import 'dart:async';

import 'package:attt/utils/globals.dart';
import 'package:attt/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:video_box/video.controller.dart';

int _counter = 0;

Widget nextButton(
    BuildContext context, Function  playNext, resetTimer, checkAndArrangeTime, VideoController vc, int index, listLenght) {
  return Container(
    height: checkIsIosTablet(context) ? SizeConfig.blockSizeHorizontal * 10  :  SizeConfig.blockSizeHorizontal * 12,
    width: checkIsIosTablet(context) ? SizeConfig.blockSizeHorizontal * 10  : SizeConfig.blockSizeHorizontal * 12,
    child: ClipOval(
        child: Material(
      color: Colors.white,
      child: InkWell(
        onTap: () {
          if(_counter == 0) {
            playNext();
            resetTimer();
            isDone = false;
//            checkAndArrangeTime();
            _counter = 1;
            Timer(Duration(seconds: 1), () {
              _counter = 0;
              print('Counter je opet $_counter');
            });
          }

        },
        child: Icon(
          index == (listLenght - 1)
              ? Icons.check  :  Icons.arrow_forward,
          size: SizeConfig.blockSizeHorizontal * 6,
        ),
      ),
    )),
  );
}

/// checking responsive
bool checkIsIosTablet(BuildContext context) {
  if (MediaQuery.of(context).size.width > 1000) {
    return true;
  } else {
    return false;
  }
}