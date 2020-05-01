import 'package:attt/interface/workoutInerface.dart';
import 'package:attt/view/workout/widgets/workoutList.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';

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

  @override
  xBack(BuildContext context) {
     Navigator.of(context).pop();
  }

  @override
  Future getWarmups(String trainerID, String weekID, String workoutID) async {
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
        .collection('warmup')
        .getDocuments();
      return qn.documents;
  }

  @override
  Future getWarmupDocumentID(String trainerID, String weekID, String workoutID) async {
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
        .where('name', isEqualTo: 'Warm Up')
        .getDocuments();
        
      QuerySnapshot qnn = await firestore
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
        .document(qn.documents[0].data['seriesID'])
        .collection('exercises')
        .getDocuments();
      return qnn.documents;
  }

} 