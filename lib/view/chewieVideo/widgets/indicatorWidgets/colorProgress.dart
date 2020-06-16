import 'package:attt/utils/size_config.dart';
import 'package:flutter/material.dart';

Widget colorProgress(
    AnimationController controllerColor, BuildContext context) {
  return Container(
      margin: EdgeInsets.only(
          top: MediaQuery.of(context).orientation == Orientation.portrait
              ? SizeConfig.blockSizeVertical * 0
              : SizeConfig.blockSizeVertical * 0,

          left: MediaQuery.of(context).orientation == Orientation.portrait
              ? SizeConfig.blockSizeHorizontal * 0
              : SizeConfig.blockSizeHorizontal * 0),
      color: Colors.blueAccent,
      height: MediaQuery.of(context).orientation == Orientation.portrait
          ? SizeConfig.blockSizeVertical * 0.5
          : SizeConfig.blockSizeVertical * 1,
//      width: SizeConfig.blockSizeHorizontal * 35 ,
      width: MediaQuery.of(context).orientation == Orientation.portrait
          ? controllerColor.value * SizeConfig.blockSizeHorizontal * 36
          : controllerColor.value * SizeConfig.blockSizeHorizontal * 17);
}
