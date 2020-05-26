


import 'package:attt/utils/size_config.dart';
import 'package:flutter/material.dart';

Widget stopIcon(Function pressTimer, BuildContext context, int isReps) {
  return Container(
    decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
              color: Colors.white
          ),
          bottom: BorderSide(
              color: Colors.white
          ),
        )
    ),
    margin: EdgeInsets.only(
      top: MediaQuery.of(context).orientation ==
          Orientation.portrait
          ? isReps == 0 ? SizeConfig.blockSizeVertical * 18  : SizeConfig.blockSizeVertical * 18
          : SizeConfig.blockSizeVertical * 0,
      left: MediaQuery.of(context).orientation ==
          Orientation.portrait
          ? SizeConfig.blockSizeHorizontal * 42
          : SizeConfig.blockSizeHorizontal * 0,
    ),
    child: IconButton(
        iconSize: MediaQuery.of(context).orientation ==
            Orientation.portrait
            ? SizeConfig.safeBlockHorizontal * 13
            : SizeConfig.safeBlockHorizontal * 6,
        icon: Icon(Icons.timer),
        color: Colors.white,
        onPressed: () {
          pressTimer();
        }),
  );
}