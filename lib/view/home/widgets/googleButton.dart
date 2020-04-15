import 'package:attt/utils/size_config.dart';
import 'package:attt/view_model/signInViewModel.dart';
import 'package:flutter/material.dart';

Widget googleButton(BuildContext context) {
  SizeConfig().init(context);
  return GestureDetector(
    onTap: () => SignInViewModel().signInWithGoogle(context),
    child: Container(
        height: SizeConfig.blockSizeVertical * 6.25,
        width: SizeConfig.blockSizeHorizontal * 72,
        color: Colors.white,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image(
                  image: AssetImage(
                    'assets/logos/google_light.png',
                    package: 'flutter_signin_button',
                  ),
                  height: SizeConfig.blockSizeVertical * 5.5,
                ),
              ),
            ),
            Text(
              'CONTINUE WITH GOOGLE',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: SizeConfig.safeBlockHorizontal * 4,
                  fontFamily: 'Roboto'),
            ),
          ],
        )),
  );
}
