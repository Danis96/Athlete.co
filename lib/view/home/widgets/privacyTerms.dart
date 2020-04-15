import 'package:attt/utils/size_config.dart';
import 'package:flutter/cupertino.dart';

Widget privacyTerms(BuildContext context) {
  SizeConfig().init(context);
  return Container(
    width: SizeConfig.blockSizeHorizontal * 96,
    child: Text(
      'By continuing, you agree to the\nTerms of Service & Privacy Policy.',
      style: TextStyle(
        color: Color.fromRGBO(255, 255, 255, 0.8),
        fontSize: SizeConfig.safeBlockHorizontal * 3.5,
        fontFamily: 'Roboto',
      ),
      textAlign: TextAlign.center,
    ),
  );
}
