import 'package:attt/utils/size_config.dart';
import 'package:attt/view/history/widgets/settingIcon.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:attt/view/trainingPlan/widgets/userImage.dart';
import 'package:attt/view/trainingPlan/widgets/userName.dart';

Widget trainingPlanHeadline(
  DocumentSnapshot userDocument,
  DocumentSnapshot userTrainerDocument,
  BuildContext context,
  String userUID,
) {
  String name = userDocument.data['display_name'];
  List<String> nameSurname = name.split(' ');
  String justName = nameSurname[0];
  String image = userDocument.data['image'];
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: <Widget>[
      userImage(image),
      SizedBox(
        width: MediaQuery.of(context).orientation == Orientation.portrait
            ? SizeConfig.blockSizeHorizontal * 4.3
            : SizeConfig.blockSizeHorizontal * 3.5,
      ),
      userName(justName, context),
      settingsIcon(userDocument, userUID, context)
    ],
  );
}
