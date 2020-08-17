import 'dart:io';

import 'package:apple_sign_in/apple_sign_in.dart';
import 'package:attt/utils/appleSignInAvailable/AppleSignInAvailable.dart';
import 'package:attt/utils/colors.dart';
import 'package:attt/utils/emptyContainer.dart';
import 'package:attt/utils/size_config.dart';
import 'package:attt/view/home/widgets/facebookButton.dart';
import 'package:attt/view/home/widgets/googleButton.dart';
import 'package:attt/view/home/widgets/privacyTerms.dart';
import 'package:attt/view/home/widgets/twitterButton.dart';
import 'package:attt/view_model/signInViewModel.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

Widget buttonList(BuildContext context) {
  SizeConfig().init(context);
  final appleSignInAvailable =
      Provider.of<AppleSignInAvailable>(context, listen: false);
  return Container(
    child: Column(
      children: <Widget>[
        googleButton(context),
        SizedBox(
          height: SizeConfig.blockSizeVertical * 1.3,
        ),
        facebookButton(context),
        SizedBox(
          height: SizeConfig.blockSizeVertical * 1.3,
        ),
        appleSignInAvailable.isAvailable
                ? appleSignInButton(context)
                : EmptyContainer(),

        Platform.isAndroid ? EmptyContainer() : SizedBox(
          height: SizeConfig.blockSizeVertical * 1.3,
        ),
        twitterButton(context),
        SizedBox(
          height: SizeConfig.blockSizeVertical * 1.3,
        ),
        privacyTerms(context)
      ],
    ),
  );
}

Widget appleSignInButton(BuildContext context) {
  SizeConfig().init(context);
  return Container(
    width: SizeConfig.blockSizeHorizontal * 72,
    child: AppleSignInButton(
          cornerRadius: 0.0,
          style: ButtonStyle.white,
          type: ButtonType.continueButton,
          onPressed:() => SignInViewModel().signInWithApple(context),
       ),
  );
}