import 'package:attt/utils/colors.dart';
import 'package:attt/utils/size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget repsWidget(
    BuildContext context, int isReps, var reps, String exerciseTime) {
  return Container(
    alignment: Alignment.center,
    child: Text(
      reps.toString().length <= 2 ? 'x ' + reps.toString() : reps.toString(),
      style: TextStyle(
          color: MyColors().lightBlack,
          fontWeight: FontWeight.w400,
          fontSize: reps.toString().length < 13
              ? SizeConfig.safeBlockHorizontal * 12
              : SizeConfig.safeBlockHorizontal * 9),
    ),
  );
}
