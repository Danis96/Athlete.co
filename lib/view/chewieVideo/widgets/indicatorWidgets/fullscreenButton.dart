import 'package:attt/utils/size_config.dart';
import 'package:flutter/material.dart';

Widget fullscreenButton(
    BuildContext context, int isReps, Function rotateScreen) {
  return Container(
    margin: EdgeInsets.only(
        top: MediaQuery.of(context).orientation == Orientation.landscape
            ? isReps == 0
                ? SizeConfig.blockSizeVertical * 72
                : SizeConfig.blockSizeVertical * 72
            : isReps == 0
                ? SizeConfig.blockSizeVertical * 0
                : SizeConfig.blockSizeVertical * 0,
        left: MediaQuery.of(context).orientation == Orientation.landscape
            ? SizeConfig.blockSizeHorizontal * 5.5
            : isReps == 0
                ? SizeConfig.blockSizeHorizontal * 12
                : SizeConfig.blockSizeHorizontal * 0),
    child: IconButton(
        icon: Icon(Icons.fullscreen),
        iconSize: MediaQuery.of(context).orientation == Orientation.landscape
            ? SizeConfig.blockSizeHorizontal * 4 :SizeConfig.blockSizeHorizontal * 7 ,
        color: Colors.white,
        onPressed: () => rotateScreen()),
  );
}
