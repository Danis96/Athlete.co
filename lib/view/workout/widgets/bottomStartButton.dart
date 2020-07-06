import 'dart:async';

import 'package:attt/utils/colors.dart';
import 'package:attt/utils/fullTrainingStopwatch/fullTrainingStopwatch.dart';
import 'package:attt/utils/globals.dart';
import 'package:attt/utils/size_config.dart';
import 'package:attt/utils/text.dart';
import 'package:attt/view_model/chewieVideoViewModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:attt/view_model/workoutViewModel.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import '../../../utils/colors.dart';
import '../../../utils/size_config.dart';

int counter = 0;
List<dynamic> expLista = [];
int _btnCounter = 0;
bool isPressed = false;
final RoundedLoadingButtonController _btnController = new RoundedLoadingButtonController();


Widget bottomButtonStart(
  DocumentSnapshot userDocument,
  DocumentSnapshot userTrainerDocument,
  BuildContext context,
  String workoutID,
  String weekID,
  List<dynamic> serije,
  bool finishedWorkout,
  Source source,
) {
  SizeConfig().init(context);
  return Container(
    margin: EdgeInsets.only(
        left: SizeConfig.blockSizeHorizontal * 5,
        right: SizeConfig.blockSizeHorizontal * 5,
        bottom: SizeConfig.blockSizeVertical * 3,
        top: SizeConfig.blockSizeVertical * 0),
    height: SizeConfig.blockSizeVertical * 5,
    width: SizeConfig.blockSizeHorizontal * 90,
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10))
    ),
      child: RoundedLoadingButton(
//        elevation: 0,
      width: SizeConfig.blockSizeVertical * 90,
      controller: _btnController,
        valueColor: MyColors().black,
        onPressed: () async {
          if(_btnCounter == 0) {
            FullTrainingStopwatch().startStopwtach();
            workoutExercisesWithSets = [];
            listOfBoundarySets = [0];
            namesWithSet = [];
            onlineVideos = [];
            onlineCovers = [];
            for (var i = 0; i < serije.length; i++) {
              List<dynamic> vjezbe = await WorkoutViewModel().getExercises(
                userTrainerDocument.data['trainerID'],
                weekID,
                workoutID,
                serije[i],
                source,
              );
              int sets = vjezbe[0].data['sets'];
              for (var j = 0; j < sets; j++) {
                for (var z = 0; z < vjezbe.length; z++) {
                  namesWithSet.add((j + 1).toString() +
                      '_' +
                      serije[i].toString() +
                      '_' +
                      vjezbe[z].data['name']);
                  workoutExercisesWithSets.add(vjezbe[z]);
                }
              }
            }
            for (var i = 0; i < workoutExercisesWithSets.length; i++) {
              onlineVideos.add(workoutExercisesWithSets[i].data['video']);
              onlineCovers.add(workoutExercisesWithSets[i].data['image']);
            }
            alertQuit = false;
            for (var i = 0; i < namesWithSet.length; i++) {
              if (i != 0) {
                List<dynamic> ids = namesWithSet[i].toString().split('_');
                List<dynamic> idsPrevious =
                namesWithSet[i - 1].toString().split('_');
                String id = ids[1];
                String idPrevious = idsPrevious[1];
                if (id != idPrevious) {
                  listOfBoundarySets.add(namesWithSet.indexOf(namesWithSet[i]));
                }
              }
            }
            print(listOfBoundarySets);
            ChewieVideoViewModel().playVideo(context, userDocument,
                userTrainerDocument, workoutID, weekID, finishedWorkout);
            _btnController.success();
            _btnCounter = 1;
            Timer(Duration(seconds: 1), () {
                _btnCounter = 0;
            });
          }
        },
          child: Text(
            MyText().startW,
            style: TextStyle(
                fontStyle: FontStyle.italic,
                fontSize: SizeConfig.blockSizeHorizontal * 4,
                fontWeight: FontWeight.w700),
          ),
        color: Colors.white,
      ),
    ),
  );
}
