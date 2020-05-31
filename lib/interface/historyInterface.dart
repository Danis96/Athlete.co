import 'package:cloud_firestore/cloud_firestore.dart';

abstract class HistoryInterface {
  List<dynamic> getfinishedWeeksWithAthlete(List<dynamic> finishedWorkouts);
  Future<List<DocumentSnapshot>> getTainerName(String trainerID);
  Future getWeekName(String trainerID, String weekID);
  Future getWorkoutName(String trainerID, String weekID, String workoutID);
  List<dynamic> getWorkoutList(List<dynamic> finishedWorkouts,
      List<dynamic> finishedWeeksWithAthlete, int index);
  getUserNotesHistory(
      List<dynamic> workoutNotes, List<dynamic> workoutsList, int index2);
}
