import 'package:attt/utils/customScreenAnimation.dart';
import 'package:attt/utils/globals.dart';
import 'package:attt/utils/colors.dart';
import 'package:attt/view/trainingPlan/pages/trainingPlan.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:attt/utils/size_config.dart';
import 'package:attt/view/settings/widgets/settingsContainers.dart';

class SettingsPage extends StatelessWidget {
  final DocumentSnapshot userDocument;
  final String userUID;
  SettingsPage({this.userDocument, this.userUID});

  String _isAthlete = 'athlete',
      _isQuestions = 'question',
      _isTerms = 'terms',
      _isLogOut = 'logout';

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: MyColors().lightBlack,
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.clear,
            size: SizeConfig.blockSizeHorizontal * 5,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'Settings',
          style: TextStyle(fontSize: SizeConfig.safeBlockHorizontal * 5.5),
        ),
        backgroundColor: MyColors().lightBlack,
      ),
      body: WillPopScope(
        onWillPop: () => _onWillPop(context, userDocument, userUID),
        child: ListView(
          children: <Widget>[
            Divider(
              thickness: 1,
              height: 1,
              color: Colors.white24,
            ),
            settingsContainer('Change your athlete or program', '', _isAthlete,
                userDocument, context, userUID),
            Divider(
              thickness: 1,
              height: 1,
              color: Colors.white24,
            ),
            settingsContainer(
                'Can we help?',
                'Contact us.',
                _isQuestions,
                userDocument,
                context,
                userUID),
            Divider(
              thickness: 1,
              height: 1,
              color: Colors.white24,
            ),
            settingsContainer('Terms of Service', '', _isTerms, userDocument,
                context, userUID),
            Divider(
              thickness: 1,
              height: 1,
              color: Colors.white24,
            ),
            settingsContainer(
                'Log Out', '', _isLogOut, userDocument, context, userUID),
            Divider(
              thickness: 1,
              height: 1,
              color: Colors.white24,
            ),
          ],
        ),
      ),
    );
  }
}

_onWillPop(
    BuildContext context, DocumentSnapshot userDocument, String userUID) {
  isFromSettings
      ? Navigator.of(context).push(CardAnimationTween(
          widget: TrainingPlan(
          userDocument: userDocument,
          userUID: userUID,
        )))
      : Navigator.of(context).pop();
}
