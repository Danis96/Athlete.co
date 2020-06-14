import 'package:attt/utils/colors.dart';
import 'package:attt/utils/emptyContainer.dart';
import 'package:attt/utils/size_config.dart';
import 'package:flutter/material.dart';

Widget timeCont(String exerciseTime, reps) {
  return Container(
    margin: EdgeInsets.only(
        top: SizeConfig.blockSizeVertical * 15,
        left: reps == null
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
