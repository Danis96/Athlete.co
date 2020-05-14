import 'package:attt/utils/globals.dart';
import 'package:attt/view_model/settingsViewModel.dart';
import 'package:attt/view_model/trainingPlanViewModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:attt/utils/size_config.dart';
import 'package:attt/utils/colors.dart';

String phoneNumberForWhatsApp = '+38762748065';
String messageForWhatsApp = 'Feel free to ask anything. :)';

Widget settingsContainer(String headText, subText, isFrom,
    DocumentSnapshot userDocument, BuildContext context, String userUID) {
  return GestureDetector(
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
                  color: MyColors().lightWhite,
                  fontSize: SizeConfig.safeBlockHorizontal * 4.0,
                  fontWeight: FontWeight.w400)),
        ],
      ),
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: MyColors().lightWhite))),
    ),
  );
}

checkAndDo(String isFrom, DocumentSnapshot userDocument, BuildContext context,
    String phoneNumberForWhatsApp, messageForWhatsApp, String userUID) {
  if (isFrom == 'athlete') {
    isFromSettings = true;
    SettingsViewModel().changeAthlete(context, userDocument, userUID);
  } else if (isFrom == 'question') {
    TrainingPlanViewModel()
        .whatsAppOpen(phoneNumberForWhatsApp, messageForWhatsApp, '', context);
  } else if (isFrom == 'terms') {
    SettingsViewModel().goToTermsAndPrivacy(context);
  } else if (isFrom == 'privacy') {
    /// navigate to privacy and check isFrom
  } else if (isFrom == 'logout') {
    SettingsViewModel().logOut(context, userDocument['platform']);
  }
}
