//+44 7725 514766  NUMBER TO PUT IN SOCIAL MEDIA BUTTONS

import 'package:attt/utils/colors.dart';
import 'package:attt/utils/size_config.dart';
import 'package:attt/view_model/trainingPlanViewModel.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

showSocialMediaDialog(BuildContext context, String userName) {
  Widget whatsAppButton = IconButton(
    icon: Icon(
      FontAwesomeIcons.whatsapp,
      size: SizeConfig.blockSizeHorizontal * 10,
    ),
    color: Color.fromRGBO(37, 211, 102, 1),
    onPressed: () => TrainingPlanViewModel().whatsAppOpen(
        '+447725514766', 'Hi, my name is $userName.', 'Training Plan', 'Name',context),
  );
  Widget viberButton = IconButton(
    icon: Icon(
      FontAwesomeIcons.viber,
      size: SizeConfig.blockSizeHorizontal * 10,
    ),
    color: Color.fromRGBO(102, 92, 172, 1),
    onPressed: () => TrainingPlanViewModel().launchViber(),
  );
  Widget messengerButton = IconButton(
      icon: Icon(
        FontAwesomeIcons.facebookMessenger,
        size: SizeConfig.blockSizeHorizontal * 10,
      ),
      color: Color.fromRGBO(0, 120, 255, 1),
      onPressed: () => TrainingPlanViewModel().launchMessenger());
  Widget emailButton = IconButton(
      icon: Icon(
        FontAwesomeIcons.envelope,
        color: Colors.redAccent,
        size: SizeConfig.blockSizeHorizontal * 10,
      ),
      onPressed: () => TrainingPlanViewModel().launchEmail(userName));

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    backgroundColor: Color.fromRGBO(0, 0, 0, 0.7),
    title: Text(
      "Contact Us",
      style: TextStyle(color: MyColors().lightWhite, fontSize: SizeConfig.safeBlockHorizontal * 4),
    ),
    content: Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            width: SizeConfig.blockSizeHorizontal * 10,
            child: whatsAppButton),
          Container(
            width: SizeConfig.blockSizeHorizontal * 12,
            child: viberButton),
          Container(
            width: SizeConfig.blockSizeHorizontal * 12,
            child: messengerButton),
          Container(
            width: SizeConfig.blockSizeHorizontal * 12,
            child: emailButton)
        ],
      ),
    ),
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
