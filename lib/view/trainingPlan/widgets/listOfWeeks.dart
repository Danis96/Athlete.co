import 'package:attt/utils/emptyContainer.dart';
import 'package:attt/view/trainingPlan/widgets/listOfWorkouts.dart';
import 'package:attt/view/trainingPlan/widgets/weekContainer.dart';
import 'package:attt/view_model/trainingPlanViewModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

Widget listOfWeeks(DocumentSnapshot userDocument,
    DocumentSnapshot userTrainerDocument, List<dynamic> finishedWeeks) {
  List<dynamic> weeksFinished = [];
  weeksFinished = userDocument.data['weeks_finished'];
  List<dynamic> weekIDs = [];
  for (var i = 0; i < weeksFinished.length; i++) {
    weekIDs.add(weeksFinished[i]);
  }
  return FutureBuilder(
      future: TrainingPlanViewModel()
          .getWeeks(userTrainerDocument.data['trainerID']),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          int counter = 0;
          return ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                if (weekIDs.contains(snapshot.data[index]['weekID'])) {
                  counter = counter + 1;
                  return Container(
                    height: 0,
                    width: 0,
                  );
                } else {
                  if (index == counter) {
                    String weekName = snapshot.data[index]['name'];
                    return listOfWorkouts(userDocument, userTrainerDocument,
                        snapshot, index, weekName);
                  } else {
                    if (index < snapshot.data.length)
                      return weekContainer(snapshot, index);
                  }
                }
                return EmptyContainer();
              });
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      });
}
