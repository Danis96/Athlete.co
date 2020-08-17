import 'package:attt/utils/colors.dart';
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
        height: 50,
        width: SizeConfig.blockSizeHorizontal * 72,
        color: MyColors().facebookColor,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(
                top: SizeConfig.blockSizeVertical * 0.2,
                left: SizeConfig.blockSizeHorizontal * 4,
              ),
              height: SizeConfig.blockSizeVertical * 3.50,
              width: SizeConfig.blockSizeHorizontal * 5.50,
              child: Icon(
                  FontAwesomeIcons.facebookF,
                  color: MyColors().white,
                  size: SizeConfig.blockSizeVertical * 3,
                ),
            ),
            SizedBox(
              width: SizeConfig.blockSizeHorizontal * 3,
            ),
            Text(
              'Continue with Facebook',
              style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.w500,
                  letterSpacing: .3,
                  wordSpacing: -.5,
                  color: Colors.white,
                ),
            ),
          ],
        )),
  );
}
