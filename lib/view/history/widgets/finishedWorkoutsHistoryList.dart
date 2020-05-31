import 'package:flutter/material.dart';
import 'package:attt/view/history/widgets/futureWorkoutContainer.dart';

Widget finishedWorkoutsHistoryList(List<dynamic> workoutsList,
    List<dynamic> finishedWeeksWithAthlete, int index) {
  return Container(
    child: ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: workoutsList.length,
      itemBuilder: (BuildContext context, int index2) {
        return futureWorkoutContainer(
            finishedWeeksWithAthlete, index, index2, workoutsList);
      },
    ),
  );
}