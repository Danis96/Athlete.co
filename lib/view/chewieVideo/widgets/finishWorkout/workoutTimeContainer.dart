import 'package:attt/utils/size_config.dart';
import 'package:flutter/material.dart';

Widget workoutTimeContainer() {
  return Text(
    'Workout Time',
    style: TextStyle(
      color: Colors.white,
      fontStyle: FontStyle.italic,
      fontWeight: FontWeight.bold,
      fontSize: SizeConfig.blockSizeHorizontal * 7,
    ),
  );
}
