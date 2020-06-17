import 'package:attt/utils/colors.dart';
import 'package:attt/utils/emptyContainer.dart';
import 'package:attt/utils/size_config.dart';
import 'package:flutter/material.dart';

Widget timeCont(String exerciseTime, reps, BuildContext context) {
  return Container(
    height: exerciseTime == null
        ? SizeConfig.safeBlockHorizontal * 6
        : SizeConfig.safeBlockHorizontal * 6,
    child: exerciseTime == null
        ? EmptyContainer()
        : Text(
            exerciseTime,
            style: TextStyle(
                color: MyColors().white,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
                fontSize:
                    MediaQuery.of(context).orientation == Orientation.landscape
                        ? SizeConfig.blockSizeVertical * 7
                        : SizeConfig.safeBlockHorizontal * 7),
          ),
  );
}
