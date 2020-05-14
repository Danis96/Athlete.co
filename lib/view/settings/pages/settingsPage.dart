import 'package:attt/utils/customScreenAnimation.dart';
import 'package:attt/utils/globals.dart';
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
      _isPrivacy = 'privacy',
      _isLogOut = 'logout';

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.clear,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text('Settings'),
        backgroundColor: Colors.black,
      ),
      body: WillPopScope(
        onWillPop: () => _onWillPop(context, userDocument, userUID),
              child: Column(
          children: <Widget>[
            settingsContainer('Athlete', 'Name of athelte', _isAthlete,
                  userDocument, context, userUID),
            settingsContainer(
                'Any questions',
                'If you have any questions feel free to ask.',
                _isQuestions,
                userDocument,
                context,
                userUID),
            settingsContainer(
                'Terms of Service', '', _isTerms, userDocument, context, userUID),
            settingsContainer(
                'Log Out', '', _isLogOut, userDocument, context, userUID),
          ],
        ),
      ),
    );
  }
}

_onWillPop(BuildContext context, DocumentSnapshot userDocument, String userUID) {
   isFromSettings ? Navigator.of(context).push(CardAnimationTween(widget: TrainingPlan(userDocument: userDocument,userUID: userUID,))) : Navigator.of(context).pop(); 
}