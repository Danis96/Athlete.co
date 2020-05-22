import 'package:attt/utils/size_config.dart';
import 'package:flutter/material.dart';

Widget fullscreenButton(
    BuildContext context, int isReps, Function rotateScreen) {
  return Container(
    margin: EdgeInsets.only(
        top: MediaQuery.of(context).orientation == Orientation.landscape
            ? isReps == 0
                ? SizeConfig.blockSizeVertical * 6.7
                : SizeConfig.blockSizeVertical * 18
            : isReps == 0
                ? SizeConfig.blockSizeVertical * 7.8
                : SizeConfig.blockSizeVertical * 0,
        left: MediaQuery.of(context).orientation == Orientation.landscape
            ? SizeConfig.blockSizeHorizontal * 4
            : isReps == 0
                ? SizeConfig.blockSizeHorizontal * 12
                : SizeConfig.blockSizeHorizontal * 12),
    child: IconButton(
        icon: Icon(Icons.fullscreen),
        color: Colors.white,
        onPressed: () => rotateScreen()),
  );
}
