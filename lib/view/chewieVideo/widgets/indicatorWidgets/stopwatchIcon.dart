import 'package:attt/utils/colors.dart';
import 'package:attt/utils/size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget stopIcon(Function pressTimer, BuildContext context, int isReps) {
  return Container(
    height: MediaQuery.of(context).orientation == Orientation.portrait
        ? SizeConfig.blockSizeVertical * 5.5
        : SizeConfig.blockSizeVertical * 10,
    width: MediaQuery.of(context).orientation == Orientation.portrait
        ? SizeConfig.blockSizeHorizontal * 35
        : SizeConfig.blockSizeHorizontal * 17,
    margin: EdgeInsets.only(
      top: MediaQuery.of(context).orientation == Orientation.portrait
          ? isReps == 0
              ? SizeConfig.blockSizeVertical * 16
              : SizeConfig.blockSizeVertical * 16
          : SizeConfig.blockSizeVertical * 8,
      left: MediaQuery.of(context).orientation == Orientation.portrait
          ? SizeConfig.blockSizeHorizontal * 0
          : SizeConfig.blockSizeHorizontal * 68,
    ),
    child: IconButton(
      icon: Icon(Icons.timer),
      onPressed: () => pressTimer(),
      color: MyColors().lightWhite,
      iconSize: MediaQuery.of(context).orientation == Orientation.portrait
          ? SizeConfig.safeBlockHorizontal * 13
          : SizeConfig.safeBlockHorizontal * 6,
    ),
  );
}
