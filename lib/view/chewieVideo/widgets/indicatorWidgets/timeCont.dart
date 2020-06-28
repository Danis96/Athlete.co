import 'package:attt/utils/colors.dart';
import 'package:attt/utils/emptyContainer.dart';
import 'package:attt/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Widget timeCont(String exerciseTime, reps, BuildContext context) {
  return Container(
    alignment: Alignment.center,
    height: SizeConfig.blockSizeHorizontal * 9,
    child: exerciseTime == null
        ? EmptyContainer()
        : Text(
            exerciseTime,
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontStyle: FontStyle.italic,
                fontSize: SizeConfig.safeBlockHorizontal * 4),
            textAlign: TextAlign.center,
          ),
  );
}
