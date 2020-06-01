import 'package:attt/utils/size_config.dart';
import 'package:attt/view/chewieVideo/widgets/finishWorkout/timerContainer.dart';
import 'package:attt/view/chewieVideo/widgets/finishWorkout/workoutTimeContainer.dart';
import 'package:flutter/material.dart';

Widget timerWidgets(BuildContext context, String displayTime) {
  return Container(
    child: Column(
      children: <Widget>[
        SizedBox(
          height: SizeConfig.blockSizeVertical * 4,
        ),
        timerContainer(context, displayTime),
        SizedBox(
          height: SizeConfig.blockSizeVertical * 1,
        ),
        workoutTimeContainer(),
        SizedBox(
          height: SizeConfig.blockSizeVertical * 4,
        ),
      ],
    ),
  );
}
