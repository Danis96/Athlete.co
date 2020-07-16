import 'package:attt/utils/globals.dart';
import 'package:attt/view/subscription/page/widgets/subscriptionLoader.dart';
import 'package:attt/view/trainingPlan/widgets/workoutContainer.dart';
import 'package:attt/view_model/trainingPlanViewModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

Widget listOfWorkouts(
  DocumentSnapshot userDocument,
  DocumentSnapshot userTrainerDocument,
  AsyncSnapshot snapshot,
  int index,
  String weekName,
) {
  List<dynamic> workoutsFinished = [];
  workoutsFinished = userDocument.data['workouts_finished'];
  String trainerID = userTrainerDocument.data['trainerID'];
  String weekID = snapshot.data[index].data['weekID'];
  List<dynamic> workoutIDs = [];
  workoutIDs =
      TrainingPlanViewModel().getWorkoutIDs(workoutsFinished, trainerID);

  return FutureBuilder(
    future: TrainingPlanViewModel().getWorkouts(trainerID, weekID),
    builder: (BuildContext context, AsyncSnapshot snapshot2) {
      if (snapshot2.hasData) {
        return Column(
          children: <Widget>[
            ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: snapshot2.data.length,
              itemBuilder: (BuildContext context, int index2) {
                String workoutID = snapshot2.data[index2].data['workoutID'];
                numOfSeries = snapshot2.data[index2].data['num_of_series'];
                print(numOfSeries.toString()  + 'NUM OF SERIES');
                return workoutContainer(
                    userDocument,
                    snapshot2,
                    index2,
                    userTrainerDocument,
                    snapshot,
                    index,
                    context,
                    weekName,
                    workoutID,
                    workoutIDs);
              },
            ),
          ],
        );
      } else {
        return Center(
          child: SubLoader().subLoader(),
        );
      }
    },
  );
}
