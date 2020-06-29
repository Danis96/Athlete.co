import 'package:attt/utils/emptyContainer.dart';
import 'package:attt/utils/text.dart';
import 'package:attt/view/trainingPlan/widgets/boldText.dart';
import 'package:attt/view/trainingPlan/widgets/normalText.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

Widget trainingPlanGuides(
    DocumentSnapshot userTrainerDocument, BuildContext context) {
  String trainingPlan = userTrainerDocument.data['training_plan_name'];
  String trainingDuration = userTrainerDocument.data['training_plan_duration'];
  String trainingPhases = userTrainerDocument.data['phases'].toString();
  String athlete = userTrainerDocument.data['trainer_name'] +
      ' - ' +
      userTrainerDocument.data['description'];
  String performanceCoach = userTrainerDocument.data['performance_coach'];

  print('Training phases: ' + trainingPhases);
  return Container(
    width: double.infinity,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        normalText(MyText().youTraining, context),
        boldText(trainingPlan, context),
        normalText('\n' + MyText().trDuration, context),
        Row(
          children: <Widget>[
            trainingDuration == 'null' || trainingDuration == null
                ? EmptyContainer()
                : boldText(trainingDuration + MyText().trWeeks, context),
            trainingPhases == 'null'
                ? EmptyContainer()
                : boldText(' - ' + trainingPhases + ' Phases', context),
          ],
        ),
        normalText('\n' + MyText().trAthlete, context),
        boldText(athlete, context),
        normalText('\n' + MyText().trPerfomancec, context),
        boldText(performanceCoach, context),
      ],
    ),
  );
}
