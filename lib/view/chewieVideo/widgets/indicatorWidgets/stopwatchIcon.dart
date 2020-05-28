import 'package:attt/utils/size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
                ? SizeConfig.blockSizeVertical * 18
                : SizeConfig.blockSizeVertical * 18
            : SizeConfig.blockSizeVertical * 22,
        left: MediaQuery.of(context).orientation == Orientation.portrait
            ? SizeConfig.blockSizeHorizontal * 27
            : SizeConfig.blockSizeHorizontal * 68,
      ),
      child: RaisedButton(
        onPressed: () => pressTimer(),
        child: Text(
          'Stopwatch'.toUpperCase(),
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic,
              fontSize:
                  MediaQuery.of(context).orientation == Orientation.portrait
                      ? SizeConfig.safeBlockHorizontal * 4
                      : SizeConfig.safeBlockHorizontal * 1.8),
        ),
      ));
}
