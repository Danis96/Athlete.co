
abstract class WorkoutInterface {
  Future getSeries(String trainerID, String weekID, String workoutID);
  Future getExercises(String trainerID,  String weekID, String workoutID, String seriesID);
}