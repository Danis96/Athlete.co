import 'package:cloud_firestore/cloud_firestore.dart';

class Workout {
    final String workoutName, workoutTag, warmup, workoutID;


    Workout({this.warmup, this.workoutName, this.workoutTag, this.workoutID});

    factory Workout.fromDocument(DocumentSnapshot doc) {
       return Workout(
          workoutID: doc['workoutID'],
         warmup: doc['warmup'],
         workoutName: doc['name'],
         workoutTag: doc['tag']
       );
    }   
    
}