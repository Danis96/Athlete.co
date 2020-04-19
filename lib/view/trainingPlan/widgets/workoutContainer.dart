import 'package:attt/utils/size_config.dart';
import 'package:attt/view/workout/pages/workout.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

Widget workoutContainer(
    AsyncSnapshot snapshot2,
    int index2,
    DocumentSnapshot userTrainerDocument,
    AsyncSnapshot snapshot,
    int index,
    BuildContext context) {
  return GestureDetector(
    onTap: () {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => Workout(
                    trainerID: userTrainerDocument.data['trainerID'],
                    workoutName: snapshot2.data[index2]['name'],
                    weekID: snapshot.data[index].data['weekID'],
                    workoutID: snapshot2.data[index2].data['workoutID'],
                    warmupDesc: snapshot2.data[index2].data['warmup'],
                  )));
    },
    child: Container(
      margin: EdgeInsets.only(bottom: SizeConfig.blockSizeVertical * 1.25),
      width: double.infinity,
      height: SizeConfig.blockSizeVertical * 12.5,
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
              snapshot2.data[index2]['name'].toString().toUpperCase(),
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
              snapshot2.data[index2]['tag'].toString().toUpperCase(),
              style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Roboto',
                  fontSize: SizeConfig.blockSizeVertical * 2.1,
                  fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    ),
  );
}
