import 'package:attt/utils/size_config.dart';
import 'package:attt/view_model/signInViewModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';

Widget privacyTerms(BuildContext context) {
  SizeConfig().init(context);
  return Container(
    width: SizeConfig.blockSizeHorizontal * 96,
    child: RichText(
      text: TextSpan(
        text: 'By continuing, you agree to the\n',
        style: TextStyle(
          color: Color.fromRGBO(255, 255, 255, 0.8),
          fontSize: SizeConfig.safeBlockHorizontal * 3,
          fontFamily: 'Roboto',
        ),
        children: <TextSpan>[
          TextSpan(
            recognizer: TapGestureRecognizer()
              ..onTap = () => SignInViewModel().redirectToPrivacyAndTerms(),
            text: 'Terms of Service',
            style: TextStyle(
                color: Color.fromRGBO(255, 255, 255, 0.8),
                fontSize: SizeConfig.safeBlockHorizontal * 3,
                fontFamily: 'Roboto',
                decoration: TextDecoration.underline),
          ),
          TextSpan(
            text: ' & ',
            style: TextStyle(
              color: Color.fromRGBO(255, 255, 255, 0.8),
              fontSize: SizeConfig.safeBlockHorizontal * 3,
              fontFamily: 'Roboto',
            ),
          ),
          TextSpan(
            recognizer: TapGestureRecognizer()
              ..onTap = () => SignInViewModel().redirectToPrivacyAndTerms(),
            text: 'Privacy Policy.',
            style: TextStyle(
                color: Color.fromRGBO(255, 255, 255, 0.8),
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
