
import 'package:attt/utils/size_config.dart';
import 'package:flutter/material.dart';

Widget colorProgress(AnimationController controllerColor, BuildContext context) {
  return Container(
    margin: EdgeInsets.only(
        top: MediaQuery.of(context).orientation == Orientation.portrait ?
        SizeConfig.blockSizeVertical * 25.4 : SizeConfig.blockSizeVertical * 12.5,
        left: MediaQuery.of(context).orientation == Orientation.portrait ? SizeConfig.blockSizeHorizontal *
            30 : SizeConfig.blockSizeHorizontal *
            0
    ),
    color: Colors.blueAccent,
    height: SizeConfig.blockSizeVertical * 1,
    width: MediaQuery.of(context).orientation == Orientation.portrait ? controllerColor.value *
        SizeConfig.blockSizeHorizontal *
        42.1 : controllerColor.value *
        SizeConfig.blockSizeHorizontal *
        18.4
  );
}