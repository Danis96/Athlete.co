import 'package:attt/utils/globals.dart';
import 'package:attt/utils/size_config.dart';
import 'package:attt/utils/text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

Widget trainingPlanGuides(DocumentSnapshot userTrainerDocument) {
  String trainingPlan = userTrainerDocument.data['training_plan_name'];
  String trainingDuration = userTrainerDocument.data['training_plan_duration'];
  String athlete = userTrainerDocument.data['trainer_name'];
  String performanceCoach = userTrainerDocument.data['performance_coach'];
  String description = userTrainerDocument.data['description'];
  return Container(
    width: double.infinity,
    child: Text(
      MyText().youTraining + '\n$trainingPlan\n\n'+MyText().trDuration+'\n$trainingDuration'+MyText().trWeeks+'\n\n'+MyText().trAthlete+'\n$athlete\n$description\n\n'
          +MyText().trPerfomancec+'\n$performanceCoach\n\n'+MyText().trBest,
      //"Welcome to week $currentWeek\n\nFocus on technique, use the video and coaching tips to help you.",
      style: TextStyle(
          color: Color.fromRGBO(255, 255, 255, 0.8),
          fontFamily: 'Roboto',
          fontSize: SizeConfig.blockSizeVertical * 2.2,
          fontWeight: FontWeight.w400),
    ),
  );
}
