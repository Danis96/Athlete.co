import 'package:attt/utils/colors.dart';
import 'package:attt/view_model/trainingPlanViewModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

Widget cancelButton(String userUID, BuildContext context, DocumentSnapshot userTrainerDocument) {
  return FlatButton(
      child: Text(
        "Continue with same trainer",
        style: TextStyle(color: MyColors().lightWhite),
      ),
      onPressed: () => TrainingPlanViewModel()
          .continueWithSameTrainer(userUID, context, userTrainerDocument));
}