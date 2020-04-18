import 'package:attt/interface/workoutInerface.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class WorkoutViewModel implements WorkoutInterface {
  @override
  Future getExercises(String trainerID, String weekID, String workoutID, String seriesID) async {
      var firestore = Firestore.instance;
    QuerySnapshot qn = await firestore
        .collection('Trainers')
        /// treba mi trainerIDtra
        .document(trainerID)
        .collection('weeks')
         /// treba mi weekID
        .document(weekID)
        .collection('workouts')
         /// treba mi workoutID
        .document(workoutID)
        .collection('series')
         /// treba mi seriesID
        .document(seriesID)
        .collection('exercises')
        .getDocuments();
      return qn.documents;
  }

  @override
  Future getSeries(String trainerID,  String weekID, String workoutID) async {
        var firestore = Firestore.instance;
    QuerySnapshot qn = await firestore
        .collection('Trainers')
         /// treba mi trainerID
        .document(trainerID)
        .collection('weeks')
         /// treba mi weekID
        .document(weekID)
        .collection('workouts')
         /// treba mi workoutID
        .document(workoutID)
        .collection('series')
        .getDocuments();
      return qn.documents;
  }

}