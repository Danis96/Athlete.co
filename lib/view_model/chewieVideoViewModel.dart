import 'package:attt/utils/globals.dart';
import 'package:attt/view/chewieVideo/pages/chewieVideo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
    FocusScope.of(context).requestFocus(new FocusNode());
    Navigator.of(context).pop();
    ChewieVideoViewModel().checkForOrientationOnBack();
  }
}
