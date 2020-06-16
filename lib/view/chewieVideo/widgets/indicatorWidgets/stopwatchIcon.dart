import 'package:attt/utils/colors.dart';
import 'package:attt/utils/size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget stopIcon(Function pressTimer, BuildContext context, var isReps) {
  return Container(
    height: MediaQuery.of(context).orientation == Orientation.portrait
        ? SizeConfig.blockSizeVertical * 5.5
        : SizeConfig.blockSizeVertical * 10,
    width: MediaQuery.of(context).orientation == Orientation.portrait
        ? SizeConfig.blockSizeHorizontal * 35
        : null,
    margin: EdgeInsets.only(
      top: MediaQuery.of(context).orientation == Orientation.portrait
          ? isReps == 0
              ? SizeConfig.blockSizeVertical * 16
              : SizeConfig.blockSizeVertical * 16
          : SizeConfig.blockSizeVertical * 0,
      left: MediaQuery.of(context).orientation == Orientation.portrait
          ? SizeConfig.blockSizeHorizontal * 0
          : SizeConfig.blockSizeHorizontal * 0,
    ),
    child: GestureDetector(
      onTap: () => pressTimer(),
      child: Container(
        width: SizeConfig.blockSizeHorizontal * 30,
        height: SizeConfig.blockSizeVertical * 30,
        child: Icon(
          Icons.timer,
          color: MyColors().lightWhite,
          size: MediaQuery.of(context).orientation == Orientation.portrait
              ? SizeConfig.safeBlockHorizontal * 13
              : SizeConfig.safeBlockHorizontal * 6,
        ),
      ),
    ),
  );
}
