import 'package:attt/utils/colors.dart';
import 'package:attt/utils/globals.dart';
import 'package:attt/utils/size_config.dart';
import 'package:attt/utils/customScreenAnimation.dart';
import 'package:attt/view_model/trainingPlanViewModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:attt/view/settings/pages/settingsPage.dart';

Widget trainingPlanHeadline(
    DocumentSnapshot userDocument,
    DocumentSnapshot userTrainerDocument,
    BuildContext context,
    String userUID) {
  String name = userDocument.data['display_name'];
  List<String> nameSurname = name.split(' ');
  String justName = nameSurname[0];
  //String trainingPlan = userTrainerDocument.data['training_plan_name'];
  return Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: <Widget>[
      Container(
        height: 90.0,
        width: 90,
        padding: EdgeInsets.all(8),
        child: CircleAvatar(
          backgroundColor: MyColors().black,
          radius: 28.0,
          backgroundImage: NetworkImage(userDocument.data['image']),
        ),
      ),
      SizedBox(
        width: SizeConfig.blockSizeHorizontal * 4.5,
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: SizeConfig.blockSizeHorizontal * 40,
            child: Text(
              'Hi $justName',//,',
              //'Week $currentWeek of $totalWeeks',
              style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Roboto',
                  fontSize: SizeConfig.blockSizeVertical * 3.2,
                  fontWeight: FontWeight.w500),
              textAlign: TextAlign.left,
            ),
          ),
          // SizedBox(
          //   height: SizeConfig.blockSizeVertical * 0.3,
          // ),
          // Container(
          //   width: SizeConfig.blockSizeHorizontal * 40,
          //   child: Text(
          //     'Week $currentWeek of $totalWeeks',
          //     //'Your training plan is:\n$trainingPlan',
          //     style: TextStyle(
          //         color: Colors.white,
          //         fontFamily: 'Roboto',
          //         fontSize: SizeConfig.blockSizeVertical * 2.5,
          //         fontWeight: FontWeight.w400),
          //     textAlign: TextAlign.left,
          //   ),
          // ),
        ],
      ),
    ],
  );
}
