import 'package:attt/interface/workoutInerface.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class WorkoutViewModel implements WorkoutInterface {
  @override
  Future getExercises(String trainer) async {
      var firestore = Firestore.instance;
    QuerySnapshot qn = await firestore
        .collection('Trainers')
        /// treba mi 
        .document(trainer)
        .collection('weeks')
         /// treba mi 
        .document('week1')
        .collection('workouts')
         /// treba mi 
        .document('workout1')
        .collection('series')
         /// treba mi 
        .document('core')
        .collection('exercises')
        .getDocuments();
      return qn.documents;
  }

  @override
  Future getSeries(String trainer) async {
        var firestore = Firestore.instance;
    QuerySnapshot qn = await firestore
        .collection('Trainers')
         /// treba mi 
        .document(trainer)
        .collection('weeks')
         /// treba mi 
        .document('week1')
        .collection('workouts')
         /// treba mi 
        .document('workout1')
        .collection('series')
        .getDocuments();
      return qn.documents;
  }

}