import 'package:attt/utils/size_config.dart';
import 'package:attt/view/home/widgets/facebookButton.dart';
import 'package:attt/view/home/widgets/googleButton.dart';
import 'package:attt/view/home/widgets/privacyTerms.dart';
import 'package:attt/view/home/widgets/twitterButton.dart';
import 'package:flutter/material.dart';

Widget buttonList(BuildContext context) {
  SizeConfig().init(context);
  return Container(
    child: Column(
      children: <Widget>[
        googleButton(context),
        SizedBox(
          height: SizeConfig.blockSizeVertical + 1.25,
        ),
        facebookButton(context),
        SizedBox(
          height: SizeConfig.blockSizeVertical * 1.25,
        ),
        twitterButton(context),
        SizedBox(
          height: SizeConfig.blockSizeVertical * 1.25,
        ),
        privacyTerms(context)
      ],
    ),
  );
}