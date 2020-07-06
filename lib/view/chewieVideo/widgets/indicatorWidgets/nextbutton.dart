import 'dart:async';

import 'package:attt/utils/globals.dart';
import 'package:attt/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:video_box/video.controller.dart';

int _counter = 0;

Widget nextButton(
    BuildContext context, Function  playNext, resetTimer, VideoController vc, int index, listLenght) {
  return Container(
    height: SizeConfig.blockSizeHorizontal * 12,
    width: SizeConfig.blockSizeHorizontal * 12,
    child: ClipOval(
        child: Material(
      color: Colors.white,
      child: InkWell(
        onTap: () {
          if(_counter == 0) {
            playNext();
            resetTimer();
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
