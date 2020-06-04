import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

abstract class ChewieVideoInterface {
   initializeVariables();
   showRest(BuildContext context, String toPlay);
   //Future<List<DocumentSnapshot>> getSeriesName(String trainerID, String weekID, String workoutID, String seriesID);
}