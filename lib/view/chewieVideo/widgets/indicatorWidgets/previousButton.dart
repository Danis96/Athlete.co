import 'dart:async';

import 'package:attt/utils/globals.dart';
import 'package:attt/utils/size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

int _counter = 0;

Widget previousButton(BuildContext context, Function playPrevious, resetTimer,  checkAndArrangeTime,) {
  return Container(
    height: checkIsIosTablet(context) ? SizeConfig.blockSizeHorizontal * 10  :  SizeConfig.blockSizeHorizontal * 12,
    width: checkIsIosTablet(context) ? SizeConfig.blockSizeHorizontal * 10  : SizeConfig.blockSizeHorizontal * 12,
    child: ClipOval(
        child: Material(
      color: Colors.white,
      child: InkWell(
        onTap: () {
          if (_counter == 0) {
            playPrevious();
            resetTimer();
            isDone = false;
//            checkAndArrangeTime();
            _counter = 1;
            Timer(Duration(seconds: 1), () {
              _counter = 0;
              print('_counter je opet $_counter');
            });
          }
        },
        child: Icon(
          Icons.arrow_back,
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