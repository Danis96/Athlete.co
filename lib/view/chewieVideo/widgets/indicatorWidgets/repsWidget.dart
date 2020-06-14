import 'package:attt/utils/size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget repsWidget(
    BuildContext context, int isReps, var reps, String exerciseTime) {
  return Container(
    height: MediaQuery.of(context).orientation == Orientation.landscape
        ? SizeConfig.blockSizeVertical * 12
        : SizeConfig.blockSizeVertical * 6,
    alignment: MediaQuery.of(context).orientation == Orientation.landscape
        ? Alignment.centerLeft
        : Alignment.center,
    width: SizeConfig.blockSizeHorizontal * 95,
    margin: EdgeInsets.only(
        top: MediaQuery.of(context).orientation == Orientation.landscape
            ? SizeConfig.blockSizeVertical * 62
            : isReps == 0
                ? exerciseTime == null
                    ? SizeConfig.blockSizeVertical * 14
                    : SizeConfig.blockSizeVertical * 13.6
                : SizeConfig.blockSizeVertical * 2,
        left: MediaQuery.of(context).orientation == Orientation.landscape
            ? SizeConfig.blockSizeHorizontal * 1.2
            : exerciseTime == null
                ? SizeConfig.blockSizeHorizontal * 2
                : reps.toString().length <= 2
                    ? SizeConfig.blockSizeHorizontal * 50
                    : SizeConfig.blockSizeHorizontal * 34),
    child: Text(
        reps.toString().length <= 2 ? 'x ' + reps.toString() : reps.toString(),
        style: TextStyle(
            color: Colors.white,
            fontSize:
                MediaQuery.of(context).orientation == Orientation.landscape
                    ? SizeConfig.blockSizeVertical * 10
                    : exerciseTime == null
                        ? SizeConfig.safeBlockHorizontal * 10
                        : SizeConfig.safeBlockHorizontal * 6,
            fontWeight:
                exerciseTime == null ? FontWeight.bold : FontWeight.w400,
            fontStyle:
                exerciseTime == null ? FontStyle.italic : FontStyle.normal)),
  );
}
