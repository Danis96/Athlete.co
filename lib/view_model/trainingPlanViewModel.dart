import 'package:attt/interface/trainingPlanInterface.dart';
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
        .getDocuments();
    return qn.documents;
  }

  @override
  navigateToWorkout(String trainerID, String workoutName, String weekID,
      String workoutID, String warmupDesc, BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => Workout(
                trainerID: trainerID,
                workoutName: workoutName,
                weekID: weekID,
                workoutID: workoutID,
                warmupDesc: warmupDesc)));
  }

  @override
  whatsAppOpen() async {
    String phoneNumber = '+38762623629';
    String message = 'Hello from Athlete.co!!!';
    var whatsappUrl = "whatsapp://send?phone=$phoneNumber&text=$message";
    if (await canLaunch(whatsappUrl)) {
      await launch(whatsappUrl);
    } else {
      throw 'Could not launch $whatsappUrl';
    }
  }
}
