import 'package:attt/view/history/widgets/finishedWeekContainer.dart';
import 'package:attt/view_model/historyViewModel.dart';
import 'package:flutter/material.dart';

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
      return FutureBuilder(
        future: HistoryViewModel().getTainerName(
            finishedWeeksWithAthlete[index].toString().split('_')[0]),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            if (snapshot != null) {
              trainerName = snapshot.data[0].data['trainer_name'];
            }
            return FutureBuilder(
              future: HistoryViewModel().getWeekName(
                  finishedWeeksWithAthlete[index].toString().split('_')[0],
                  finishedWeeksWithAthlete[index].toString().split('_')[1]),
              builder: (BuildContext context, AsyncSnapshot snapshot2) {
                if (snapshot2.hasData) {
                  if (snapshot2 != null) {
                    weekName = snapshot2.data[0].data['name'];
                  }
                  return finishedWeekContainer(weekName, trainerName,
                      workoutsList, finishedWeeksWithAthlete, index);
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      );
    },
  );
}