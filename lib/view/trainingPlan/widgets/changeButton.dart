import 'package:attt/utils/colors.dart';
import 'package:attt/view_model/trainingPlanViewModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

Widget continueButton(
    DocumentSnapshot userTrainerDocument,
    DocumentSnapshot userDocument,
    String userUID,
    String emailOfUser,
    String nameOfUser,
    String photoOfUser,
    BuildContext context) {
  return FlatButton(
    child: Text(
      "Change",
      style: TextStyle(color: MyColors().error),
    ),
    onPressed: () => TrainingPlanViewModel().changeTrainer(userTrainerDocument,
        userDocument, userUID, emailOfUser, nameOfUser, photoOfUser, context),
  );
}
