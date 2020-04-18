
import 'package:flutter/cupertino.dart';

abstract class WorkoutInterface {
  Future getSeries(String trainerID, String weekID, String workoutID);
  Future getExercises(String trainerID,  String weekID, String workoutID, String seriesID);
  xBack(BuildContext context);
}