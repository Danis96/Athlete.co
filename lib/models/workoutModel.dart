import 'package:cloud_firestore/cloud_firestore.dart';

class Workout {
    final String workoutName;
    final String workoutTag;
    final String warmup;

    Workout({this.warmup, this.workoutName, this.workoutTag});

    factory Workout.fromDocument(DocumentSnapshot doc) {
       return Workout(
         warmup: doc['warmup'],
         workoutName: doc['name'],
         workoutTag: doc['tag']
       );
    }   
    
}