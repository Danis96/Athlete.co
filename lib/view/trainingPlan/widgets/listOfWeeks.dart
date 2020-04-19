import 'package:attt/view/trainingPlan/widgets/listOfWorkouts.dart';
import 'package:attt/view/trainingPlan/widgets/weekContainer.dart';
import 'package:attt/view_model/trainingPlanViewModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

Widget listOfWeeks(
    DocumentSnapshot userTrainerDocument, List<dynamic> finishedWeeks) {
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
                if (finishedWeeks.contains(snapshot.data[index]['name'])) {
                  counter = counter + 1;
                  return Container(
                    height: 0,
                    width: 0,
                  );
                } else {
                  if (index == counter) {
                    return listOfWorkouts(userTrainerDocument, snapshot, index);
                  } else {
                    if(index < counter + 3)
                    return weekContainer(snapshot, index);
                  }
                }
              });
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      });
}
