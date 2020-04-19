import 'package:attt/utils/globals.dart';
import 'package:attt/utils/size_config.dart';
import 'package:flutter/material.dart';

Widget trainingPlanGuides() {
  return Container(
    width: double.infinity,
    child: Text(
      "Welcome to week $currentWeek\n\nFocus on technique, use the video and coaching tips to help you.",
      style: TextStyle(
          color: Color.fromRGBO(255, 255, 255, 0.8),
          fontFamily: 'Roboto',
          fontSize: SizeConfig.blockSizeVertical * 2.2,
          fontWeight: FontWeight.w400),
    ),
  );
}
