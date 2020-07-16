import 'package:cloud_firestore/cloud_firestore.dart';

class Workout {
    final String workoutName, workoutTag, warmup, workoutID;
    final int numberOfSeries;


    Workout({this.warmup, this.workoutName, this.workoutTag, this.workoutID, this.numberOfSeries});

    factory Workout.fromDocument(DocumentSnapshot doc) {
       return Workout(
          workoutID: doc['workoutID'],
         warmup: doc['warmup'],
         workoutName: doc['name'],
         workoutTag: doc['tag'],
         numberOfSeries: doc['num_of_series'],
       );
    }   
    
}