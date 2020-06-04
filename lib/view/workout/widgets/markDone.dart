import 'package:attt/utils/size_config.dart';
import 'package:attt/view/workout/widgets/customCheckbox.dart';
import 'package:attt/view/workout/widgets/customLabel.dart';
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
      SizedBox(
        width: SizeConfig.blockSizeHorizontal * 1,
      ),
      CustomLabel(
        finishedWorkout: finishedWorkout,
        userDocument: userDocument,
        userTrainerDocument: userTrainerDocument,
        weekID: weekID,
        workoutID: workoutID,
      ),
    ],
  );
}
