import 'package:attt/utils/size_config.dart';
import 'package:attt/view_model/signInViewModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

Widget facebookButton(BuildContext context) {
  SizeConfig().init(context);
  return GestureDetector(
    onTap: () => SignInViewModel().signInWithFacebook(context),
    child: Container(
        height: SizeConfig.blockSizeVertical * 6.25,
        width: SizeConfig.blockSizeHorizontal * 79,
        color: Color(0xFF3B5998),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              height: SizeConfig.blockSizeVertical * 5.5,
              color: Color(0xFF3B5998),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Icon(FontAwesomeIcons.facebookF),
              ),
            ),
            SizedBox(
              width: SizeConfig.blockSizeHorizontal * 1.25,
            ),
            Text(
              'CONTINUE WITH FACEBOOK',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: SizeConfig.safeBlockHorizontal * 4,
                  fontFamily: 'Roboto'),
            ),
          ],
        )),
  );
}
