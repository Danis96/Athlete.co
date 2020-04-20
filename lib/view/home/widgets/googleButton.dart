import 'package:attt/utils/colors.dart';
import 'package:attt/utils/size_config.dart';
import 'package:attt/utils/text.dart';
import 'package:attt/view_model/signInViewModel.dart';
import 'package:flutter/material.dart';

Widget googleButton(BuildContext context) {
  SizeConfig().init(context);
  return GestureDetector(
    onTap: () => SignInViewModel().signInWithGoogle(context),
    child: Container(
        height: SizeConfig.blockSizeVertical * 6.25,
        width: SizeConfig.blockSizeHorizontal * 72,
        color: MyColors().white,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(
                top: SizeConfig.blockSizeVertical * 0.6,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(2),
                color: Colors.white,
              ),
              height: SizeConfig.blockSizeVertical * 3.75,
              width: SizeConfig.blockSizeHorizontal * 6.667,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.asset(
                'assets/images/google-login.png',
                height: SizeConfig.blockSizeVertical * 3.75,
              ),
              ),
            ),
            SizedBox(
              width: SizeConfig.blockSizeHorizontal * 4,
            ),
            Text(
              MyText().gButton,
              style: TextStyle(
                  color: MyColors().black,
                  fontSize: SizeConfig.safeBlockHorizontal * 4,
                  fontFamily: 'Roboto'),
            ),
          ],
        )),
  );
}
