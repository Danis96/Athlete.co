import 'package:attt/utils/size_config.dart';
import 'package:attt/view_model/chewieVideoViewModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

Widget finishWorkoutButton(
    BuildContext context,
    List<dynamic> notes,
    String newNote,
    DocumentSnapshot userDocument,
    DocumentSnapshot userTrainerDocument,
    String weekID,
    String workoutID,
    bool finishedWorkout) {
  return Container(
    width: MediaQuery.of(context).size.width,
    child: RaisedButton(
      elevation: 0,
      onPressed: () => ChewieVideoViewModel().finishPressed(
          context,
          newNote,
          userDocument,
          userTrainerDocument,
          weekID,
          workoutID,
          notes,
          finishedWorkout),
      child: Padding(
        padding: EdgeInsets.all(22.0),
        child: Text(
          'FINISH',
          style: TextStyle(
            fontStyle: FontStyle.italic,
            fontSize: SizeConfig.blockSizeHorizontal * 4,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      color: Colors.white,
    ),
  );
}