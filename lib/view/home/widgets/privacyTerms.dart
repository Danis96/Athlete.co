import 'package:attt/utils/colors.dart';
import 'package:attt/utils/size_config.dart';
import 'package:attt/utils/text.dart';
import 'package:attt/view_model/settingsViewModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';

Widget privacyTerms(BuildContext context) {
  SizeConfig().init(context);
  return Container(
    width: SizeConfig.blockSizeHorizontal * 96,
    child: RichText(
      text: TextSpan(
        text: MyText().byContinuing,
        style: TextStyle(
          color: MyColors().lightWhite,
          fontSize: SizeConfig.safeBlockHorizontal * 3,
          fontFamily: 'Roboto',
        ),
        children: <TextSpan>[
          TextSpan(
            recognizer: TapGestureRecognizer()
              ..onTap = () => SettingsViewModel().goToTermsAndPrivacy(context),
            text: MyText().terms,
            style: TextStyle(
                color:  MyColors().lightWhite,
                fontSize: SizeConfig.safeBlockHorizontal * 3,
                fontFamily: 'Roboto',
                decoration: TextDecoration.underline),
          ),
          TextSpan(
            text: ' & ',
            style: TextStyle(
              color:  MyColors().lightWhite,
              fontSize: SizeConfig.safeBlockHorizontal * 3,
              fontFamily: 'Roboto',
            ),
          ),
          TextSpan(
            recognizer: TapGestureRecognizer()
              ..onTap = () =>SettingsViewModel().goToTermsAndPrivacy(context),
            text: MyText().privacy,
            style: TextStyle(
                color:  MyColors().lightWhite,
                fontSize: SizeConfig.safeBlockHorizontal * 3,
                fontFamily: 'Roboto',
                decoration: TextDecoration.underline),
          ),
        ],
      ),
      textAlign: TextAlign.center,
    ),
  );
}
