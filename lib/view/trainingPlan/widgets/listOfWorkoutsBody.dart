import 'package:attt/utils/size_config.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:attt/view/trainingPlan/widgets/weekDescription.dart';
import 'package:attt/view/trainingPlan/widgets/workoutList.dart';

Widget listOfWorkoutsBody(String weekName, AsyncSnapshot snapshot, int index,
    DocumentSnapshot userDocument, DocumentSnapshot userTrainerDocument) {
  return SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        weekDescription(weekName, snapshot, index),
        SizedBox(
          height: SizeConfig.blockSizeVertical * 1.5,
        ),
        Divider(
          height: 1,
          thickness: 1,
          color: Colors.white24,
        ),
        SizedBox(
          height: SizeConfig.blockSizeVertical * 1.5,
        ),
        listOfWorkouts(
            userDocument, userTrainerDocument, snapshot, index, weekName),
      ],
    ),
  );
}
