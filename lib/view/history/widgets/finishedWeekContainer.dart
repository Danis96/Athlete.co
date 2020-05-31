import 'package:attt/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:attt/view/history/widgets/weekAndTrainer.dart';
import 'package:attt/view/history/widgets/finishedWorkoutsHistoryList.dart';

Widget finishedWeekContainer(
    String weekName,
    String trainerName,
    List<dynamic> workoutsList,
    List<dynamic> finishedWeeksWithAthlete,
    int index) {
  return Container(
    margin: EdgeInsets.only(bottom: SizeConfig.blockSizeVertical * 3),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        weekAndTrainer(weekName, trainerName),
        SizedBox(
          height: SizeConfig.blockSizeVertical * 2,
        ),
        finishedWorkoutsHistoryList(workoutsList, finishedWeeksWithAthlete, index),
      ],
    ),
  );
}