import 'package:attt/utils/colors.dart';
import 'package:attt/utils/customScreenAnimation.dart';
import 'package:attt/utils/globals.dart';
import 'package:attt/utils/size_config.dart';
import 'package:attt/view/settings/pages/settingsPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

Widget settingsIcon(
    DocumentSnapshot userDocument, String userUID, BuildContext context) {
  return Container(
    margin: EdgeInsets.only(
        right: checkIsIosTablet(context)
            ? SizeConfig.blockSizeHorizontal * 5
            : SizeConfig.blockSizeHorizontal * 0),
    alignment: Alignment.centerRight,
    //margin: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal * 8),
    child: IconButton(
      onPressed: () => Navigator.of(context).push(CardAnimationTween(
          widget: SettingsPage(
        userDocument: userDocument,
        userUID: userUID,
      ))),
      icon: Icon(
        Icons.settings,
        color: MyColors().white,
        size: MediaQuery.of(context).orientation == Orientation.portrait
            ? SizeConfig.safeBlockHorizontal * 7
            : SizeConfig.safeBlockHorizontal * 4,
      ),
    ),
  );
}

/// checking responsive
bool checkIsIosTablet(BuildContext context) {
  if (MediaQuery.of(context).size.width > 1000) {
    return true;
  } else {
    return false;
  }
}

