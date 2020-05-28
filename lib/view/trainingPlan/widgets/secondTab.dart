import 'package:attt/utils/globals.dart';
import 'package:attt/utils/size_config.dart';
import 'package:attt/view_model/trainingPlanViewModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

Widget secondTab(BuildContext context, DocumentSnapshot userTrainerDocument,
    DocumentSnapshot userDocument) {
  SizeConfig().init(context);
  return GestureDetector(
    behavior: HitTestBehavior.translucent,
    onTap: () {
      TrainingPlanViewModel().secondTabPressed(
          context, userTrainerDocument, userDocument, userUIDPref);
    },
    child: Container(
      width: MediaQuery.of(context).orientation == Orientation.portrait
          ? SizeConfig.blockSizeHorizontal * 50
          : SizeConfig.blockSizeHorizontal * 23,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            width: double.infinity,
            child: Icon(
              Icons.show_chart,
              color: Colors.white60,
              size: MediaQuery.of(context).orientation == Orientation.portrait
                  ? SizeConfig.safeBlockHorizontal * 4.5
                  : SizeConfig.safeBlockHorizontal * 2,
            ),
          ),
        ],
      ),
    ),
  );
}
