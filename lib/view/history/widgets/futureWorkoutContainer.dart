import 'package:attt/utils/globals.dart';
import 'package:attt/view_model/historyViewModel.dart';
import 'package:flutter/material.dart';
import 'package:attt/view/history/widgets/emptyHisotryWorkoutContainer.dart';
import 'package:attt/view/history/widgets/historyWorkoutContainer.dart';

Widget futureWorkoutContainer(List<dynamic> finishedWeeksWithAthlete, int index,
    int index2, List<dynamic> workoutsList) {
  String workoutName = '';
  String workoutTag = '';
  List<dynamic> workoutNotes = [];
  return FutureBuilder(
    future: HistoryViewModel().getWorkoutName(
        finishedWeeksWithAthlete[index].toString().split('_')[0],
        finishedWeeksWithAthlete[index].toString().split('_')[1],
        workoutsList[index2].toString().split(' ')[0]),
    builder: (BuildContext context, AsyncSnapshot snapshot3) {
      if (snapshot3.hasData) {
        userNotesHistory = '';
        if (snapshot3 != null) {
          workoutName = snapshot3.data[0].data['name'];
          workoutTag = snapshot3.data[0].data['tag'];
          workoutNotes = snapshot3.data[0].data['historyNotes'];
          HistoryViewModel()
              .getUserNotesHistory(workoutNotes, workoutsList, index2);
        }
        return historyWorkoutContainer(
            workoutTag, workoutName, workoutsList, index2);
      } else {
        return emptyHistoryWorkoutContainer();
      }
    },
  );
}