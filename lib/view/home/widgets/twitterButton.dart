import 'package:attt/utils/size_config.dart';
import 'package:attt/view_model/signInViewModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

Widget twitterButton(BuildContext context) {
  SizeConfig().init(context);
  return GestureDetector(
    onTap: () => SignInViewModel().signInWithTwitter(context),
    child: Container(
        height: SizeConfig.blockSizeVertical * 6.25,
        width: SizeConfig.blockSizeHorizontal * 73,
        color: Color(0xFF1DA1F2),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
              height: 24,
              width: 24,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Icon(
                  FontAwesomeIcons.twitter,
                  color: Color(0xFF1DA1F2),
                  size: 15,
                ),
              ),
            ),
            SizedBox(
              width: SizeConfig.blockSizeHorizontal * 3,
            ),
            Text(
              'CONTINUE WITH TWITTER',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: SizeConfig.safeBlockHorizontal * 4,
                  fontFamily: 'Roboto'),
            ),
          ],
        )),
  );
}
