import 'package:flutter/material.dart';

abstract class WorkoutInterface {
  Future getSeries(String trainerID, String weekID, String workoutID);
  Future getExercises(String trainerID,  String weekID, String workoutID, String seriesID);
  Future getWarmups(String trainerID, String weekID, String workoutID);
  xBack(BuildContext context);
  Future getWarmupDocumentID(String trainerID, String weekID, String workoutID);
  String getUserNotes(List<dynamic> notesList, String userId);
}