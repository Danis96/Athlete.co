import 'package:cloud_firestore/cloud_firestore.dart';

class Exercise {
  final String name, image, video, exerciseID, time, repsDescription;
  final int isReps, sets, rest;
  final reps;
  final List<dynamic> tips;

  Exercise(
      {this.exerciseID,
      this.name,
      this.image,
      this.isReps,
      this.reps,
      this.rest,
      this.sets,
      this.tips,
      this.video,
      this.time,
        this.repsDescription
      });

  factory Exercise.fromDocument(DocumentSnapshot doc) {
    return Exercise(
        exerciseID: doc['exerciseID'],
        name: doc['name'],
        image: doc['image'],
        isReps: doc['isReps'],
        reps: doc['reps'],
        rest: doc['rest'],
        sets: doc['sets'],
        tips: doc['tips'],
        time: doc['time'],
        repsDescription: doc['repsDescription'],
        video: doc['video']);
  }
}
