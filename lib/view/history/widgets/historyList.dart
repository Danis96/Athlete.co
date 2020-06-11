import 'package:attt/view_model/historyViewModel.dart';
import 'package:flutter/material.dart';
import 'package:attt/view/history/widgets/futureTrainerContainer.dart';

Widget historyList(
    List<dynamic> finishedWeeksWithAthlete, List<dynamic> finishedWorkouts) {
  return ListView.builder(
    shrinkWrap: true,
    physics: ScrollPhysics(),
    itemCount: finishedWeeksWithAthlete.length,
    itemBuilder: (BuildContext context, int index) {
      String trainerName = '';
      String weekName = '';
      List<dynamic> workoutsList = [];
      workoutsList = HistoryViewModel()
          .getWorkoutList(finishedWorkouts, finishedWeeksWithAthlete, index);
      return futureTrainerContainer(
          finishedWeeksWithAthlete, index, trainerName, weekName, workoutsList);
    },
  );
}