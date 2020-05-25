
import 'package:attt/utils/size_config.dart';
import 'package:flutter/material.dart';

Widget colorProgress(AnimationController controllerColor) {
  return Container(
    margin: EdgeInsets.only(
        top:
        SizeConfig.blockSizeVertical * 15.4,
        left: SizeConfig.blockSizeHorizontal *
            15),
    color: Colors.amber,
    height: SizeConfig.blockSizeVertical * 1,
    width: controllerColor.value *
        SizeConfig.blockSizeHorizontal *
        42.1,
  );
}