import 'package:attt/utils/size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget repsWidget(
    BuildContext context, int isReps, var reps, String exerciseTime) {
  return Container(
    child: Text(
      reps.toString().length <= 2 ? 'x ' + reps.toString() : reps.toString(),
      style: TextStyle(
        color: Colors.white,
        fontSize: MediaQuery.of(context).orientation == Orientation.landscape
            ? SizeConfig.blockSizeVertical * 7
            : SizeConfig.safeBlockHorizontal * 7,
        fontWeight: FontWeight.bold,
        fontStyle: FontStyle.italic,
      ),
    ),
  );
}
