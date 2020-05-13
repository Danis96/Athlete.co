import 'package:flutter/material.dart';
import 'package:attt/utils/size_config.dart';
import 'package:attt/view/settings/widgets/settingsContainers.dart';

class SettingsPage extends StatelessWidget {
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
      body: Column(
        children: <Widget>[
          settingsContainer('Athlete', 'Name of athelte', _isAthlete),
          settingsContainer('Any questions',
              'If you have any questions feel free to ask.', _isQuestions),
          settingsContainer('Terms of Service', '', _isTerms),
          settingsContainer('Privacy Policy', '', _isPrivacy),
          settingsContainer('Log Out', '', _isLogOut),
        ],
      ),
    );
  }
}
