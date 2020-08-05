import 'package:attt/utils/colors.dart';
import 'package:attt/utils/size_config.dart';
import 'package:attt/utils/text.dart';
import 'package:attt/view_model/signInViewModel.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

Widget googleButton(BuildContext context) {
  SizeConfig().init(context);
  return GestureDetector(
    onTap: () => SignInViewModel().signInWithGoogle(context),
    child: Container(
        height: 50,
        width: SizeConfig.blockSizeHorizontal * 72,
        color: MyColors().white,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
                margin:
                    EdgeInsets.only(left: checkIsIosTablet(context) ? SizeConfig.blockSizeHorizontal * 1.4  : SizeConfig.blockSizeHorizontal * 2.5),
                // padding: EdgeInsets.only(
                //   top: SizeConfig.blockSizeVertical * 0.6,
                // ),
                // decoration: BoxDecoration(
                //   borderRadius: BorderRadius.circular(2),
                //   color: Colors.white,
                // ),
                child: 
                // Icon(
                //   FontAwesomeIcons.google,
                //   size: 19,q
                // )
                 Image.asset(
                'assets/images/google-login.png',
                height: 20,
                width: 20,
                fit: BoxFit.contain,
                ),
                ),
            SizedBox(
              width: 5,
            ),
            Container(
              margin: EdgeInsets.only(left: 1),
              child: Text(
                MyText().gButton,
                style: TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.w500,
                  letterSpacing: .3,
                  wordSpacing: -.5,
                  color: Colors.black,
                ),
              ),
            )
          ],
        )),
  );
}

  bool checkIsIosTablet(BuildContext context) {
    if (MediaQuery.of(context).size.width > 800) {
      return true;
    } else {
      return false;
    }
  }