import 'package:attt/interface/historyInterface.dart';
import 'package:attt/utils/globals.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HistoryViewModel implements HistoryInterface {
  @override
  List<dynamic> getfinishedWeeksWithAthlete(List<dynamic> finishedWorkouts) {
    List<dynamic> finishedWeeksWithAthlete = [];
    for (var i = finishedWorkouts.length - 1; i >= 0; i--) {
      if (!finishedWeeksWithAthlete.contains(
          finishedWorkouts[i].toString().split('_')[0] +
              '_' +
              finishedWorkouts[i].toString().split('_')[1])) {
        finishedWeeksWithAthlete.add(
            finishedWorkouts[i].toString().split('_')[0] +
                '_' +
                finishedWorkouts[i].toString().split('_')[1]);
      }
    }
    return finishedWeeksWithAthlete;
  }

  @override
  Future<List<DocumentSnapshot>> getTainerName(String trainerID) async {
    var firestore = Firestore.instance;
    QuerySnapshot qn = await firestore
        .collection('Trainers')
        .where('trainerID', isEqualTo: trainerID)
        .getDocuments(
            source: hasActiveConnection ? Source.serverAndCache : Source.cache);
    return qn.documents;
  }

  @override
  Future getWeekName(String trainerID, String weekID) async {
    var firestore = Firestore.instance;
    QuerySnapshot qn = await firestore
        .collection('Trainers')
        .document(trainerID)
        .collection('weeks')
        .where('weekID', isEqualTo: weekID)
        .getDocuments(
            source: hasActiveConnection ? Source.serverAndCache : Source.cache);
    return qn.documents;
  }

  @override
  Future getWorkoutName(
      String trainerID, String weekID, String workoutID) async {
    var firestore = Firestore.instance;
    QuerySnapshot qn = await firestore
        .collection('Trainers')
        .document(trainerID)
        .collection('weeks')
        .document(weekID)
        .collection('workouts')
        .where('workoutID', isEqualTo: workoutID)
        .getDocuments(
            source: hasActiveConnection ? Source.serverAndCache : Source.cache);
    return qn.documents;
  }

  @override
  List<dynamic> getWorkoutList(List<dynamic> finishedWorkouts,
      List<dynamic> finishedWeeksWithAthlete, int index) {
    List<dynamic> workoutsList = [];
    for (var i = 0; i < finishedWorkouts.length; i++) {
      if (finishedWorkouts[i].toString().split('_')[1] ==
          finishedWeeksWithAthlete[index].toString().split('_')[1]) {
        workoutsList.add(finishedWorkouts[i].toString().split('_')[2] +
            ' ' +
            finishedWorkouts[i].toString().split('_')[3] +
            ' ' +
            finishedWorkouts[i].toString().split('_')[4]);
      }
    }
    workoutsList = workoutsList.reversed.toList();
    return workoutsList;
  }

  @override
  getUserNotesHistory(
      List<dynamic> workoutNotes, List<dynamic> workoutsList, int index2) {
    bool isBreak = false;
    for (var j = 0; j < workoutNotes.length; j++) {
      if (workoutNotes[j].toString().split('_!_?_')[2] ==
              (workoutsList[index2].toString().split(' ')[3] +
                  ' ' +
                  workoutsList[index2].toString().split(' ')[4]) &&
          !isBreak) {
        userNotesHistory = workoutNotes[j].toString().split('_!_?_')[1];
        isBreak = true;
      }
    }
  }
}
