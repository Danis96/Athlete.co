import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

abstract class TrainingPlanInterface {
  Future getWeeks(String trainerID, Source source);
  Future getWorkouts(String trainerID, String weekID);
  navigateToWorkout(
      DocumentSnapshot userDocument,
      DocumentSnapshot userTrainerDocument,
      String trainerID,
      String workoutName,
      String weekID,
      String workoutID,
      String warmupDesc,
      BuildContext context,
      String weekName,
      List<dynamic> listOfNotes,
      bool alreadyFinishedWorkout,
      bool finishedWorkout,
      String tag,
      );
  whatsAppOpen(
      String phoneNumber, String message, String screen, String userName, BuildContext context);
  secondTabPressed(BuildContext context, DocumentSnapshot userTrainerDocument,
      DocumentSnapshot userDocument, String userUID);
  firstTabPressed(BuildContext context, DocumentSnapshot userTrainerDocument,
      DocumentSnapshot userDocument);
  showAlertDialog(BuildContext context);
  List<dynamic> getWorkoutIDs(List<dynamic> workoutsFinished, String trainerID);
  List<dynamic> getWeekIDs(List<dynamic> weeksFinished, String trainerID);
  List<dynamic> getWeeksToKeep(List<dynamic> weeksFinished, String trainerID);
  continueWithSameTrainer(String userUID, BuildContext context,
      DocumentSnapshot userTrainerDocument);
  changeTrainer(
      DocumentSnapshot userTrainerDocument,
      DocumentSnapshot userDocument,
      String userUID,
      String emailOfUser,
      String nameOfUser,
      String photoOfUser,
      BuildContext context);
  getFinishedWeeks(List<dynamic> weekIDs, AsyncSnapshot snapshot, int index);
  deleteUserProgressAndShowAlertDialog(
      AsyncSnapshot snapshot,
      DocumentSnapshot userDocument,
      List<dynamic> weeksToKeep,
      BuildContext context,
      String userUID,
      DocumentSnapshot userTrainerDocument,
      String emailOfUser,
      String nameOfUser,
      String photoOfUser);
}
