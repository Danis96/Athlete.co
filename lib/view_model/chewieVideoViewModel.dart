import 'package:attt/utils/fullTrainingStopwatch/fullTrainingStopwatch.dart';
import 'package:attt/utils/globals.dart';
import 'package:attt/view/chewieVideo/pages/chewieVideo.dart';
import 'package:attt/view/trainingPlan/pages/trainingPlan.dart';
import 'package:attt/view_model/signInViewModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class ChewieVideoViewModel {
  playVideo(
      BuildContext context,
      DocumentSnapshot userDocument,
      DocumentSnapshot userTrainerDocument,
      String workoutID,
      String weekID,
      bool finishedWorkout) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (_) => ChewieVideo(
              userDocument: userDocument,
              userTrainerDocument: userTrainerDocument,
              workoutID: workoutID,
              weekID: weekID,
              finishedWorkout: finishedWorkout,
            )));
  }

  updateWorkoutWithNote(String trainerID, String weekID, String workoutID,
      List<String> note) async {
    if(isFromRepsOnly) {
      isDone = false;
      print('Dolazi sa reps type pa je isDone = $isDone');
    } else {
      isDone = true;
    }
    await Firestore.instance
        .collection('Trainers')
        .document(trainerID)
        .collection('weeks')
        .document(weekID)
        .collection('workouts')
        .document(workoutID)
        .updateData({"notes": FieldValue.arrayUnion(note)});
  }

  updateWorkoutHistoryNote(String trainerID, String weekID, String workoutID,
      List<dynamic> note) async {
    await Firestore.instance
        .collection('Trainers')
        .document(trainerID)
        .collection('weeks')
        .document(weekID)
        .collection('workouts')
        .document(workoutID)
        .updateData({"historyNotes": FieldValue.arrayUnion(note)});
  }

  checkForOrientationOnBack() {
    isFromPortrait
        ? SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
        : SystemChrome.setPreferredOrientations(
            [DeviceOrientation.landscapeRight]);
  }

  donePressed(String newNote, List<dynamic> notes, String userUID,
      String trainerID, String weekID, String workoutID, BuildContext context) {
    String note;
    if (newNote != null) {
      note = userUID + '_!_?_' + newNote;
      notes.add(note);
      userNotes = note.split('_!_?_')[1];
      ChewieVideoViewModel()
          .updateWorkoutWithNote(trainerID, weekID, workoutID, notes);
    }
    Navigator.of(context).pop();
  }

  updateUserWithFinishedWorkout(
    DocumentSnapshot userDocument,
    String trainerID,
    String weekID,
    String workoutID,
    String currentTime,
    bool finishedWorkout,
  ) async {
    List<String> note = [];
    String currentDay = DateFormat.d().format(DateTime.now());
    String currentMonth = DateFormat.MMM().format(DateTime.now()).toUpperCase();
    note.add(trainerID +
        '_' +
        weekID +
        '_' +
        workoutID +
        '_' +
        currentDay +
        ' ' +
        currentMonth +
        '_' +
        currentTime);
    final db = Firestore.instance;

    !finishedWorkout
        ? await db
            .collection('Users')
            .document(userDocument.documentID)
            .updateData({"workouts_finished": FieldValue.arrayUnion(note)})
        : print('WORKOUT ALREADY FINISHED');

    await db
        .collection('Users')
        .document(userDocument.documentID)
        .updateData({"workouts_finished_history": FieldValue.arrayUnion(note)});
  }

  finishPressed(
      BuildContext context,
      String newNote,
      DocumentSnapshot userDocument,
      DocumentSnapshot userTrainerDocument,
      String weekID,
      String workoutID,
      List<dynamic> notes,
      bool finishedWorkout) async {
    String currentTime = DateTime.now().toString();
    String note;
    List<dynamic> historyNotes = [];
    if (newNote != null) {
      note = userDocument.data['userUID'] + '_!_?_' + newNote;
      notes.add(note);
      userNotes = note.split('_!_?_')[1];
      ChewieVideoViewModel().updateWorkoutWithNote(
        userTrainerDocument.data['trainerID'],
        weekID,
        workoutID,
        notes,
      );
    } else {
      newNote = userNotes;
    }
    note = userDocument.data['userUID'] +
        '_!_?_' +
        newNote +
        '_!_?_' +
        currentTime;
    historyNotes.add(note);
    ChewieVideoViewModel().updateWorkoutHistoryNote(
      userTrainerDocument.data['trainerID'],
      weekID,
      workoutID,
      historyNotes,
    );
    ChewieVideoViewModel().updateUserWithFinishedWorkout(
      userDocument,
      userTrainerDocument.data['trainerID'],
      weekID,
      workoutID,
      currentTime,
      finishedWorkout,
    );
    List<dynamic> currentUserDocuments = [];
    DocumentSnapshot currentUserDocument;
    currentUserDocuments = await SignInViewModel()
        .getCurrentUserDocument(userDocument.data['userUID']);
    currentUserDocument = currentUserDocuments[0];
    List<dynamic> currentUserTrainerDocuments = [];
    DocumentSnapshot currentUserTrainerDocument;
    currentUserTrainerDocuments = await SignInViewModel()
        .getCurrentUserTrainer(currentUserDocument.data['trainer']);
    currentUserTrainerDocument = currentUserTrainerDocuments[0];
    FocusScope.of(context).requestFocus(new FocusNode());
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (_) => TrainingPlan(
            userDocument: currentUserDocument,
            userTrainerDocument: currentUserTrainerDocument,
            userUID: currentUserDocument.data['userUID'],
          ),
        ),
        (Route<dynamic> route) => false);
    userNotes = '';
    await Future.delayed(
      Duration(seconds: 1),
      () {
        FullTrainingStopwatch().resetStopwtach();
      },
    );
  }

  Future<List<DocumentSnapshot>> getSeriesName(String trainerID, String weekID,
      String workoutID, String seriesID) async {
    var firestore = Firestore.instance;
    QuerySnapshot qn = await firestore
        .collection('Trainers')
        .document(trainerID)
        .collection('weeks')
        .document(weekID)
        .collection('workouts')
        .document(workoutID)
        .collection('series')
        .where('seriesID', isEqualTo: seriesID)
        .getDocuments(
            source: hasActiveConnection ? Source.serverAndCache : Source.cache);
    return qn.documents;
  }
}
