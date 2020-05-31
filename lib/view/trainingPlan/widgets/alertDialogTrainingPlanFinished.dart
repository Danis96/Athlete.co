import 'package:attt/utils/colors.dart';
import 'package:attt/view/trainingPlan/widgets/cancelButton.dart';
import 'package:attt/view/trainingPlan/widgets/changeButton.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

alertDialogTrainingPlanFinished(
    BuildContext context,
    DocumentSnapshot userDocument,
    String userUID,
    DocumentSnapshot userTrainerDocument,
    String emailOfUser,
    String nameOfUser,
    String photoOfUser) {
  AlertDialog alert = AlertDialog(
    backgroundColor: MyColors().lightBlack,
    title: Text(
      "Congradulations! You have completed this training plan.",
      style: TextStyle(color: MyColors().lightWhite),
    ),
    content: Text(
      "Do you want to train again with the same trainer, or you want to change your trainer?",
      style: TextStyle(color: MyColors().lightWhite),
    ),
    actions: [
      cancelButton(userUID, context, userTrainerDocument),
      continueButton(userTrainerDocument, userDocument, userUID, emailOfUser,
          nameOfUser, photoOfUser, context),
    ],
  );
  
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
