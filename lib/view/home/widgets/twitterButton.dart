import 'dart:async';
import 'dart:io';

import 'package:attt/utils/colors.dart';
import 'package:attt/utils/globals.dart';
import 'package:attt/utils/size_config.dart';
import 'package:attt/utils/text.dart';
import 'package:attt/view_model/signInViewModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_appavailability/flutter_appavailability.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

List<Map<String, String>> installedApps;

Future<void> getApps() async {
  List<Map<String, String>> _installedApps;

  if (Platform.isAndroid) {
    _installedApps = await AppAvailability.getInstalledApps();

    try {
      print(await AppAvailability.checkAvailability("com.twitter.android"));
      // Returns: Map<String, String>{app_name: Chrome, package_name: com.android.chrome, versionCode: null, version_name: 55.0.2883.91}

      print(await AppAvailability.isAppEnabled("com.twitter.android"));
      // Returns: true
      isInstalled = true;
    } catch (e) {
      isInstalled = false;
    }
  }

  installedApps = _installedApps;
}

Widget twitterButton(BuildContext context) {
  SizeConfig().init(context);
  return GestureDetector(
    onTap: () async {
      getApps();
      Timer(Duration(seconds: 1), () {
        if (isInstalled) {
          SignInViewModel().signInWithTwitter(context);
        } else
          showAlertDialog(context);
      });
    },
    child: Container(
        height: 50,
        width: SizeConfig.blockSizeHorizontal * 72,
        color: MyColors().twitterColor,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(left:checkIsIosTablet(context) ? SizeConfig.blockSizeHorizontal * 1.4  : SizeConfig.blockSizeHorizontal * 2.5),
              // decoration: BoxDecoration(
              //   shape: BoxShape.circle,
              //   color: MyColors().white,
              // ),
              // height: SizeConfig.blockSizeVertical * 3.75,
              // width: SizeConfig.blockSizeHorizontal * 6.667,
              child: Icon(
                FontAwesomeIcons.twitter,
                color: Colors.white,
                size: 21,
              ),
            ),
            SizedBox(
              width: 7,
            ),
            Container(
              child: Text(
                MyText().tButton,
                 style: TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.w500,
                  letterSpacing: .3,
                  wordSpacing: -.5,
                  color: Colors.white,),
                ),
            ),
          ],
        )),
  );
}

 bool checkIsIosTablet(BuildContext context) {
    if (MediaQuery.of(context).size.width > 800) {
      return true;
    } else {
      return false;
    }
  }

showAlertDialog(BuildContext context) {
  // set up the button
  Widget okButton = FlatButton(
    child: Text(
      "OK",
      style: TextStyle(color: MyColors().lightWhite),
    ),
    onPressed: () => Navigator.of(context).pop(),
  );
  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text(
      "Not installed",
      style: TextStyle(color: MyColors().lightWhite),
    ),
    content: Text(
      "Please install Twitter app on your device.",
      style: TextStyle(color: MyColors().lightWhite),
    ),
    backgroundColor: Colors.lightBlue,
    actions: [
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
