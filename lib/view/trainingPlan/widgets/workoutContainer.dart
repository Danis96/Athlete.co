import 'package:attt/utils/size_config.dart';
import 'package:attt/utils/colors.dart';
import 'package:attt/view_model/trainingPlanViewModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import '../../../utils/size_config.dart';

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
    onTap: () {
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
        true,
        workoutIDs.contains(workoutID),
        snapshot2.data[index2].data['tag'],
      );
    },
    child: Container(
      margin: EdgeInsets.only(bottom: SizeConfig.blockSizeVertical * 1),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(4),
          ),
          color: Colors.black),
      child: ListTile(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
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
                  snapshot2.data[index2].data['name'].toString().substring(1),
              style: TextStyle(
                  color: workoutIDs.contains(workoutID)
                      ? Colors.white60
                      : Colors.white,
                  fontFamily: 'Roboto',
                  fontSize: SizeConfig.blockSizeVertical * 2.5,
                  fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: SizeConfig.blockSizeVertical + 0.01,
            ),
            Text(
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
            SizedBox(
              height: SizeConfig.blockSizeVertical + 0.01,
            ),
            Text(
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
          ],
        ),
        contentPadding: EdgeInsets.symmetric(
          vertical: SizeConfig.blockSizeVertical * 1,
          horizontal: SizeConfig.blockSizeHorizontal * 4,
        ),
        enabled: false,
        leading: Container(
          margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical * 1),
          child: Icon(
            Icons.fitness_center,
            size: SizeConfig.blockSizeVertical * 5,
            color: Colors.blueAccent,
          ),
        ),
        trailing: workoutIDs.contains(workoutID)
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical * 1),
                    child: Icon(
                      Icons.check,
                      size: SizeConfig.blockSizeVertical * 2.5,
                      color: Colors.blueAccent,
                    ),
                  ),
                  Container(
                    child: Text(
                      'DONE',
                      style: TextStyle(
                          color: Colors.blueAccent,
                          fontFamily: 'Roboto',
                          fontSize: SizeConfig.safeBlockHorizontal * 3,
                          fontWeight: FontWeight.w700),
                    ),
                  )
                ],
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top:  SizeConfig.blockSizeVertical * 1),
                    child: Icon(
                      Icons.arrow_forward_ios,
                      size: checkIsIosTablet(context) ? SizeConfig.blockSizeHorizontal * 3 : SizeConfig.blockSizeHorizontal * 5,
                      color: MyColors().white,
                    ),
                  ),
                ],
              ),
      ),
    ),
  );
}

/// checking responsive
bool checkIsIosTablet(BuildContext context) {
  if (MediaQuery.of(context).size.width > 1000) {
    return true;
  } else {
    return false;
  }
}