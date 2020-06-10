import 'package:cloud_firestore/cloud_firestore.dart';

class Exercise {
  final String name, image, video, exerciseID, time;
  final int isReps, reps, sets, rest;
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
        video: doc['video']);
  }
}
