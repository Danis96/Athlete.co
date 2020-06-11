import 'package:attt/view/workout/widgets/customCheckbox.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

Widget markDone(
    BuildContext context,
    bool finishedWorkout,
    DocumentSnapshot userDocument,
    DocumentSnapshot userTrainerDocument,
    String weekID,
    String workoutID) {
  return Row(
    children: <Widget>[
      CustomCheckbox(
        finishedWorkout: finishedWorkout,
        userDocument: userDocument,
        userTrainerDocument: userTrainerDocument,
        weekID: weekID,
        workoutID: workoutID,
      ),
    ],
  );
}
