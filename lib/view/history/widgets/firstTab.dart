import 'package:attt/utils/size_config.dart';
import 'package:attt/view_model/trainingPlanViewModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

Widget firstTab(BuildContext context, DocumentSnapshot userDocument,
    DocumentSnapshot userTrainerDocument) {
  SizeConfig().init(context);
  return GestureDetector(
    behavior: HitTestBehavior.translucent,
    onTap: () {
      TrainingPlanViewModel()
          .firstTabPressed(context, userTrainerDocument, userDocument);
    },
    child: Container(
      width: SizeConfig.blockSizeHorizontal * 50,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Icon(
            Icons.fitness_center,
            color: Colors.white60,
            size: SizeConfig.blockSizeHorizontal * 6,
          ),
        ],
      ),
    ),
  );
}
