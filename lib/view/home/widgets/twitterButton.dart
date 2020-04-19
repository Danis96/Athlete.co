import 'package:attt/utils/colors.dart';
import 'package:attt/utils/size_config.dart';
import 'package:attt/utils/text.dart';
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
        width: SizeConfig.blockSizeHorizontal * 72,
        color: MyColors().twitterColor,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: MyColors().white,
              ),
              height: 24,
              width: 24,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Icon(
                  FontAwesomeIcons.twitter,
                  color: MyColors().twitterColor,
                  size: 15,
                ),
              ),
            ),
            SizedBox(
              width: SizeConfig.blockSizeHorizontal * 3,
            ),
            Text(
              MyText().tButton,
              style: TextStyle(
                  color: MyColors().white,
                  fontSize: SizeConfig.safeBlockHorizontal * 4,
                  fontFamily: 'Roboto'),
            ),
          ],
        )),
  );
}
