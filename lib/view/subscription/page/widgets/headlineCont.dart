

import 'package:attt/utils/colors.dart';
import 'package:attt/utils/size_config.dart';
import 'package:flutter/material.dart';

Widget headlineStart() {
  return Container(
    alignment: Alignment.center,
    width: SizeConfig.blockSizeHorizontal * 100,
    child: Column(
      children: <Widget>[
        Text(
          'Welcome to your\nnew personal best',
          textAlign: TextAlign.center,
          style: TextStyle(
              color: MyColors().white,
              fontSize: SizeConfig.safeBlockHorizontal * 9,
              fontWeight: FontWeight.w300),
        ),
      ],
    ),
  );
}