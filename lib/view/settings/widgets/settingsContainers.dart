import 'package:attt/utils/globals.dart';
import 'package:attt/view/trainingPlan/widgets/socialMediaDialog.dart';
import 'package:attt/view_model/settingsViewModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:attt/utils/size_config.dart';

String phoneNumberForWhatsApp = '+447725514766';
String messageForWhatsApp = 'Feel free to ask anything. :)';

Widget settingsContainer(String headText, subText, isFrom,
    DocumentSnapshot userDocument, BuildContext context, String userUID) {
  return GestureDetector(
    behavior: HitTestBehavior.translucent,
    onTap: () => checkAndDo(isFrom, userDocument, context,
        phoneNumberForWhatsApp, messageForWhatsApp, userUID),
    child: Container(
      width: SizeConfig.blockSizeHorizontal * 100,
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(headText,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: SizeConfig.safeBlockHorizontal * 5,
                  fontWeight: FontWeight.w400)),
          Text(subText,
              style: TextStyle(
                  color: Colors.white60,
                  fontSize: SizeConfig.safeBlockHorizontal * 4.0,
                  fontWeight: FontWeight.w400)),
        ],
      ),
    ),
  );
}

checkAndDo(String isFrom, DocumentSnapshot userDocument, BuildContext context,
    String phoneNumberForWhatsApp, messageForWhatsApp, String userUID) {
  if (isFrom == 'athlete') {
    isFromSettings = true;
    SettingsViewModel().changeAthlete(context, userDocument, userUID);
  } else if (isFrom == 'question') {
    showSocialMediaDialog(context, userDocument.data['display_name']);
  } else if (isFrom == 'terms') {
    SettingsViewModel().goToTermsAndPrivacy(context);
  } else if (isFrom == 'privacy') {
    /// navigate to privacy and check isFrom
  } else if (isFrom == 'logout') {
    SettingsViewModel().logOut(context, userDocument['platform']);
  }
}
