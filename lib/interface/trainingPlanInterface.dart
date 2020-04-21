import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

abstract class TrainingPlanInterface {
  Future getWeeks(String trainerID);
  Future getWorkouts(String trainerID, String weekID);
  navigateToWorkout(String trainerID, String workoutName, String weekID,
      String workoutID, String warmupDesc, BuildContext context);
  whatsAppOpen(String phoneNumber, String message);
  secondTabPressed(BuildContext context, DocumentSnapshot userTrainerDocument,
      DocumentSnapshot userDocument);
  firstTabPressed(BuildContext context, DocumentSnapshot userTrainerDocument,
      DocumentSnapshot userDocument);
}
