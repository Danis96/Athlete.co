import 'package:attt/view_model/historyViewModel.dart';
import 'package:flutter/material.dart';
import 'package:attt/view/history/widgets/finishedWeekContainer.dart';

Widget futureWeekContainer(List<dynamic> finishedWeeksWithAthlete, int index,
    String weekName, String trainerName, List<dynamic> workoutsList) {
  return FutureBuilder(
    future: HistoryViewModel().getWeekName(
        finishedWeeksWithAthlete[index].toString().split('_')[0],
        finishedWeeksWithAthlete[index].toString().split('_')[1]),
    builder: (BuildContext context, AsyncSnapshot snapshot2) {
      if (snapshot2.hasData) {
        if (snapshot2 != null) {
          weekName = snapshot2.data[0].data['name'];
        }
        return finishedWeekContainer(weekName, trainerName, workoutsList,
            finishedWeeksWithAthlete, index);
      } else {
        return Center(
          child: CircularProgressIndicator(),
        );
      }
    },
  );
}
