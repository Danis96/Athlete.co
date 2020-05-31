import 'package:attt/utils/emptyContainer.dart';
import 'package:attt/utils/globals.dart';
import 'package:attt/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:attt/view/history/widgets/noteContainer.dart';

Widget historyWorkoutContainer(String workoutTag, String workoutName,
    List<dynamic> workoutsList, int index2) {
  return Container(
    margin: EdgeInsets.only(bottom: SizeConfig.blockSizeVertical * 1.25),
    width: double.infinity,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(4),
        ),
        color: Colors.black),
    child: Padding(
      padding: EdgeInsets.only(
        top: SizeConfig.blockSizeVertical * 3,
        bottom: SizeConfig.blockSizeVertical * 3,
        left: SizeConfig.blockSizeHorizontal * 5.2,
        right: SizeConfig.blockSizeHorizontal * 5.2,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            workoutName.toUpperCase() +
                ' : ' +
                workoutsList[index2].toString().split(' ')[1] +
                ' ' +
                workoutsList[index2].toString().split(' ')[2],
            style: TextStyle(
                color: Colors.white,
                fontFamily: 'Roboto',
                fontSize: SizeConfig.blockSizeVertical * 2.5,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.w500),
          ),
          SizedBox(
            height: SizeConfig.blockSizeVertical * 0.4,
          ),
          Text(
            workoutTag.toUpperCase(),
            style: TextStyle(
                color: Colors.white,
                fontFamily: 'Roboto',
                fontSize: SizeConfig.blockSizeVertical * 2.1,
                fontWeight: FontWeight.w500),
          ),
          userNotesHistory != '' ? noteContainer() : EmptyContainer(),
        ],
      ),
    ),
  );
}