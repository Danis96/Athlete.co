import 'package:attt/view/chewieVideo/pages/chewieVideo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChewieVideoViewModel {
  playVideo(BuildContext context, DocumentSnapshot userDocument,
      DocumentSnapshot userTrainerDocument, String workoutID, String weekID) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (_) => ChewieVideo(
              userDocument: userDocument,
              userTrainerDocument: userTrainerDocument,
              workoutID: workoutID,
              weekID: weekID
            )));
  }

  updateWorkoutWithNote(String trainerID, String weekID, String workoutID, List<String> note) async {
    await Firestore.instance.collection('Trainers')
        .document(trainerID)
        .collection('weeks')
        .document(weekID)
        .collection('workouts')
        .document(workoutID)
        .updateData({"notes": FieldValue.arrayUnion(note)});
  }
}
