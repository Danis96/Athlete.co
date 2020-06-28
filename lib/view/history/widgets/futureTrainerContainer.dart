import 'package:attt/utils/colors.dart';
import 'package:attt/utils/emptyContainer.dart';
import 'package:attt/view_model/historyViewModel.dart';
import 'package:flutter/material.dart';
import 'package:attt/view/history/widgets/futureWeekContainer.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

Widget futureTrainerContainer(List<dynamic> finishedWeeksWithAthlete, int index,
    String trainerName, String weekName, List<dynamic> workoutsList) {
  return FutureBuilder(
    future: HistoryViewModel().getTainerName(
        finishedWeeksWithAthlete[index].toString().split('_')[0]),
    builder: (BuildContext context, AsyncSnapshot snapshot) {
      if (snapshot.hasData) {
        if (snapshot != null && snapshot.data.length != 0) {
          trainerName = snapshot.data[0].data['trainer_name'];
        }
        return futureWeekContainer(finishedWeeksWithAthlete, index, weekName,
            trainerName, workoutsList);
      } else {
        return SpinKitFadingCircle(color: MyColors().lightWhite,);
      }
    },
  );
}
