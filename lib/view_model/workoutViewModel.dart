import 'package:attt/interface/workoutInerface.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';

class WorkoutViewModel implements WorkoutInterface {
  @override
  Future getExercises(String trainerID, String weekID, String workoutID, String seriesID, Source source) async {
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
        .orderBy('order')
        .getDocuments(source: source);
      return qn.documents;
  }

  @override
  Future getSeries(String trainerID,  String weekID, String workoutID, Source source) async {
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
        .orderBy('order')
        .getDocuments(source: source);
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
  String getUserNotes(List<dynamic> notesList, String userId) {
    String note = '';
      for (int i = 0; i < notesList.length; i++) {
        String item = notesList[i];
        if (item.contains(userId)) {
          List<String> splited = item.split('_!_?_');
          item = splited[1];
          note = item;
        }
      }
      print(note.trim());
      return note.trim();
    }

  @override
  String getUserHistoryNotes(List<dynamic> notesList, String userId, String time) {
    String note = '';
      for (int i = 0; i < notesList.length; i++) {
        String item = notesList[i];
        if (item.contains(userId) && item.split('_!_?_')[2] == time) {
          List<String> splited = item.split('_!_?_');
          item = splited[1];
          note = item;
        }
      }
      print(note.trim());
      return note.trim();
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
        .orderBy('order')
        .getDocuments();
      return qnn.documents;
  }

} 