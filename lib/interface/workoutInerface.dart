import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

abstract class WorkoutInterface {
  Future getSeries(String trainerID, String weekID, String workoutID, Source source);
  Future getExercises(String trainerID,  String weekID, String workoutID, String seriesID, Source source);
  Future getWarmups(String trainerID, String weekID, String workoutID);
  xBack(BuildContext context);
  Future getWarmupDocumentID(String trainerID, String weekID, String workoutID);
  String getUserNotes(List<dynamic> notesList, String userId);
  String getUserHistoryNotes(List<dynamic> notesList, String userId, String time);
}