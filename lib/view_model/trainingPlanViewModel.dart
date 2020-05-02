import 'package:attt/interface/trainingPlanInterface.dart';
import 'package:attt/utils/customScreenAnimation.dart';
import 'package:attt/utils/globals.dart';
import 'package:attt/view/history/page/history.dart';
import 'package:attt/view/trainingPlan/pages/trainingPlan.dart';
import 'package:attt/view/workout/pages/workout.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class TrainingPlanViewModel implements TrainingPlanInterface {
  @override
  Future getWeeks(String trainerID) async {
    var firestore = Firestore.instance;
    QuerySnapshot qn = await firestore
        .collection('Trainers')

        /// treba i trainerID
        .document(trainerID)
        .collection('weeks')
        .orderBy('name')
        .getDocuments();
    return qn.documents;
  }

  @override
  Future getWorkouts(String trainerID, String weekID) async {
    var firestore = Firestore.instance;
    QuerySnapshot qn = await firestore
        .collection('Trainers')

        /// treba mi trainerID
        .document(trainerID)
        .collection('weeks')

        /// treba mi weekID
        .document(weekID)
        .collection('workouts')
        .orderBy('order')
        .getDocuments();
    return qn.documents;
  }

  @override
  navigateToWorkout(
      DocumentSnapshot userDocument,
      DocumentSnapshot userTrainerDocument,
      String trainerID,
      String workoutName,
      String weekID,
      String workoutID,
      String warmupDesc,
      BuildContext context,
      ) {
    Navigator.push(
        context,
        CardAnimationTween(
            widget: Workout(
                userDocument: userDocument,
                userTrainerDocument: userTrainerDocument,
                trainerID: trainerID,
                workoutName: workoutName,
                weekID: weekID,
                workoutID: workoutID,
                warmupDesc: warmupDesc,
                )));
  }

  @override
  whatsAppOpen(String phoneNumber, String message) async {
    var whatsappUrl = "whatsapp://send?phone=$phoneNumber&text=$message";
    if (await canLaunch(whatsappUrl)) {
      await launch(whatsappUrl);
    } else {
      throw 'Could not launch $whatsappUrl';
    }
  }

  @override
  secondTabPressed(BuildContext context, DocumentSnapshot userTrainerDocument,
      DocumentSnapshot userDocument, String userUID) {
    Navigator.push(
        context,
        CardAnimationTween(
          widget: History(
            userTrainerDocument: userTrainerDocument,
            userDocument: userDocument,
            userUID: userUIDPref,
          ),
        ));
  }

  @override
  firstTabPressed(BuildContext context, DocumentSnapshot userTrainerDocument,
      DocumentSnapshot userDocument) {
    Navigator.push(
        context,
        CardAnimationTween(
          widget: TrainingPlan(
            userDocument: userDocument,
            userTrainerDocument: userTrainerDocument,
          ),
        ));
  }
}
