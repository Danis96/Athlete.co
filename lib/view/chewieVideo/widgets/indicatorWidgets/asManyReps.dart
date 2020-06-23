import 'package:attt/utils/size_config.dart';
import 'package:flutter/material.dart';

Widget asManyReps(BuildContext context, String repsDescription) {
  return Container(
    alignment: Alignment.center,
    child: Text(
      repsDescription == null ? "" :  repsDescription,
      style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w600,
          fontSize: SizeConfig.safeBlockHorizontal * 4.5),
      textAlign: TextAlign.center,
    ),
  );
}
