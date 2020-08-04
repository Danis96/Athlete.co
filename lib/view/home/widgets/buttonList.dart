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
  final appleSignInAvailable = Provider.of<AppleSignInAvailable>(context, listen: false);
  return Container(
    child: Column(
      children: <Widget>[
        googleButton(context),
        SizedBox(
          height: SizeConfig.blockSizeVertical + 1.7,
        ),
        // facebookButton(context),
        // SizedBox(
        //   height: SizeConfig.blockSizeVertical * 1.7,
        // ),
        Platform.isIOS ? 
        appleSignInAvailable.isAvailable ?  
        appleSignInButton(context) : EmptyContainer() : EmptyContainer(),
        SizedBox(
          height: SizeConfig.blockSizeVertical * 1.7,
        ),
        twitterButton(context),
        SizedBox(
          height: SizeConfig.blockSizeVertical * 1.7,
        ),
        privacyTerms(context)
      ],
    ),
  );
}

Widget appleSignInButton(BuildContext context) {
  SizeConfig().init(context);
  return Container(
    width: SizeConfig.blockSizeHorizontal * 73,
    child: AppleSignInButton(
       onPressed: () => SignInViewModel().signInWithApple(context),
       style: ButtonStyle.black,
    ),
  );
}