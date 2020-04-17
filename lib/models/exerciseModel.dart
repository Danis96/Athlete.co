import 'package:cloud_firestore/cloud_firestore.dart';

class Exercise {
  final String name, image, tips, video;
  final int isReps, reps, sets, rest;

  Exercise(
      {this.name,
      this.image,
      this.isReps,
      this.reps,
      this.rest,
      this.sets,
      this.tips,
      this.video});

  factory Exercise.fromDocument(DocumentSnapshot doc) {
    return Exercise(
        name: doc['name'],
        image: doc['image'],
        isReps: doc['isReps'],
        reps: doc['reps'],
        rest: doc['rest'],
        sets: doc['sets'],
        tips: doc['tips'],
        video: doc['video']);
  }
}
