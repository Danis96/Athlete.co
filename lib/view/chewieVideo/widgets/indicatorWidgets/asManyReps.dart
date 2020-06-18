import 'package:attt/utils/size_config.dart';
import 'package:flutter/material.dart';

Widget asManyReps(BuildContext context, String repsDescription) {
  return Container(
    alignment: Alignment.center,
    width: MediaQuery.of(context).orientation == Orientation.landscape
        ? SizeConfig.blockSizeHorizontal * 40
        : SizeConfig.blockSizeHorizontal * 90,
    child: Text(
      repsDescription != null ? repsDescription.toUpperCase() : '',
      style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w600,
          fontStyle: FontStyle.italic,
          fontSize: MediaQuery.of(context).orientation == Orientation.landscape
              ? SizeConfig.safeBlockVertical * 4
              : SizeConfig.safeBlockHorizontal * 4),
      textAlign: TextAlign.center,
    ),
  );
}
