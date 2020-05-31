import 'package:attt/utils/colors.dart';
import 'package:attt/utils/customScreenAnimation.dart';
import 'package:attt/utils/size_config.dart';
import 'package:attt/view/settings/pages/settingsPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

Widget settingsIcon(
    DocumentSnapshot userDocument, String userUID, BuildContext context) {
  return Container(
    alignment: Alignment.centerRight,
    margin: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal * 8),
    child: IconButton(
      onPressed: () => Navigator.of(context).push(CardAnimationTween(
          widget: SettingsPage(
        userDocument: userDocument,
        userUID: userUID,
      ))),
      icon: Icon(
        Icons.settings,
        color: MyColors().white,
        size: SizeConfig.blockSizeHorizontal * 7,
      ),
    ),
  );
}
