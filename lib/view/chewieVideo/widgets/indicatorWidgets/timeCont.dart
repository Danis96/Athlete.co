import 'package:attt/utils/colors.dart';
import 'package:attt/utils/emptyContainer.dart';
import 'package:attt/utils/size_config.dart';
import 'package:flutter/material.dart';

Widget timeCont(String exerciseTime, reps, BuildContext context) {
  return Container(
    height: exerciseTime == null
        ? SizeConfig.safeBlockHorizontal * 5
        : SizeConfig.safeBlockHorizontal * 5,
    margin: EdgeInsets.only(
        top: MediaQuery.of(context).orientation == Orientation.landscape
            ? 0
            : SizeConfig.blockSizeVertical * 15,
        left: MediaQuery.of(context).orientation == Orientation.landscape
            ? 0
            : reps == null
                ? SizeConfig.blockSizeHorizontal * 39
                : SizeConfig.blockSizeHorizontal * 13),
    child: exerciseTime == null
        ? EmptyContainer()
        : Text(
            exerciseTime,
            style: TextStyle(
                color: MyColors().white,
                fontSize: SizeConfig.safeBlockHorizontal * 6),
          ),
  );
}
