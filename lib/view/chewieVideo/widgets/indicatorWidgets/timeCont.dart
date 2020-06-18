import 'package:attt/utils/colors.dart';
import 'package:attt/utils/emptyContainer.dart';
import 'package:attt/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Widget timeCont(String exerciseTime, reps, BuildContext context) {
  return Container(
    height: MediaQuery.of(context).orientation == Orientation.landscape
        ? SizeConfig.blockSizeVertical * 9
        : SizeConfig.blockSizeHorizontal * 9,
    child: exerciseTime == null
        ? EmptyContainer()
        : Text(
            exerciseTime,
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontStyle: FontStyle.italic,
                fontSize:
                    MediaQuery.of(context).orientation == Orientation.landscape
                        ? SizeConfig.safeBlockVertical * 6
                        : SizeConfig.safeBlockHorizontal * 4),
          ),
  );
}
