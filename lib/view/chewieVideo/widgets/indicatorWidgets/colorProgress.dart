
import 'package:attt/utils/size_config.dart';
import 'package:flutter/material.dart';

Widget colorProgress(AnimationController controllerColor, BuildContext context) {
  return Container(
    margin: EdgeInsets.only(
        top: MediaQuery.of(context).orientation == Orientation.portrait ?
        SizeConfig.blockSizeVertical * 15.4 : SizeConfig.blockSizeVertical * 40.2,
        left: MediaQuery.of(context).orientation == Orientation.portrait ? SizeConfig.blockSizeHorizontal *
            15 : SizeConfig.blockSizeHorizontal *
            35
    ),
    color: Colors.amber,
    height: SizeConfig.blockSizeVertical * 1,
    width: MediaQuery.of(context).orientation == Orientation.portrait ? controllerColor.value *
        SizeConfig.blockSizeHorizontal *
        42.1 : controllerColor.value *
        SizeConfig.blockSizeHorizontal *
        18.4
  );
}