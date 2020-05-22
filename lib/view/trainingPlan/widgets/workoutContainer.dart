import 'package:attt/utils/emptyContainer.dart';
import 'package:attt/utils/size_config.dart';
import 'package:attt/utils/colors.dart';
import 'package:attt/view_model/trainingPlanViewModel.dart';
import 'package:attt/view_model/workoutViewModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

Widget workoutContainer(
    DocumentSnapshot userDocument,
    AsyncSnapshot snapshot2,
    int index2,
    DocumentSnapshot userTrainerDocument,
    AsyncSnapshot snapshot,
    int index,
    BuildContext context,
    String weekName,
    String workoutID,
    List<dynamic> workoutIDs) {
  return GestureDetector(
    onTap: !workoutIDs.contains(workoutID)
        ? () {
            TrainingPlanViewModel().navigateToWorkout(
                userDocument,
                userTrainerDocument,
                userTrainerDocument.data['trainerID'],
                snapshot2.data[index2]['name'],
                snapshot.data[index].data['weekID'],
                snapshot2.data[index2].data['workoutID'],
                snapshot2.data[index2].data['warmup'],
                context,
                weekName,
                snapshot2.data[index2].data['notes'],
                true);
          }
        : null,
    child: Container(
      margin: EdgeInsets.only(bottom: SizeConfig.blockSizeVertical * 1.25),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(4),
          ),
          color: Colors.black),
      child: ListTile(
        title: Text(
          snapshot.data[index].data['name']
                  .toString()
                  .substring(0, 1)
                  .toUpperCase() +
              snapshot.data[index].data['name'].toString().substring(1) +
              ' ' +
              snapshot2.data[index2].data['name']
                  .toString()
                  .substring(0, 1)
                  .toUpperCase() +
              snapshot2.data[index2].data['name'].toString().substring(1) +
              ' ' +
              snapshot2.data[index2]['tag']
                  .toString()
                  .substring(0, 1)
                  .toUpperCase() +
              snapshot2.data[index2]['tag'].toString().substring(1),
          style: TextStyle(
              color: workoutIDs.contains(workoutID)
                  ? Colors.white60
                  : Colors.white,
              fontFamily: 'Roboto',
              fontSize: SizeConfig.blockSizeVertical * 2.5,
              fontWeight: FontWeight.w500),
        ),
        contentPadding: EdgeInsets.symmetric(
          vertical: SizeConfig.blockSizeVertical * 1,
          horizontal: SizeConfig.blockSizeHorizontal * 4,
        ),
        enabled: false,
        leading: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.fitness_center,
              size: SizeConfig.blockSizeVertical * 5,
              color: Colors.blueAccent,
            ),
          ],
        ),
        trailing: workoutIDs.contains(workoutID)
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.check,
                    size: SizeConfig.blockSizeVertical * 3,
                    color: Colors.blueAccent,
                  ),
                  Text(
                    'DONE',
                    style: TextStyle(
                        color: Colors.blueAccent,
                        fontFamily: 'Roboto',
                        fontSize: SizeConfig.blockSizeVertical * 2.5,
                        fontWeight: FontWeight.w700),
                  )
                ],
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.arrow_forward_ios,
                    size: SizeConfig.blockSizeHorizontal * 5,
                    color: MyColors().white,
                  ),
                ],
              ),
        subtitle: Text(
          snapshot2.data[index2].data['numberOfExercises'].toString() +
              ' Exercises',
          style: TextStyle(
              color: workoutIDs.contains(workoutID)
                  ? Colors.white70
                  : Colors.white,
              fontFamily: 'Roboto',
              fontSize: SizeConfig.blockSizeVertical * 2,
              fontWeight: FontWeight.w400),
        ),
      ),
    ),
  );
}
