

import 'package:attt/utils/colors.dart';
import 'package:attt/utils/size_config.dart';
import 'package:flutter/material.dart';

Widget headlineStart() {
  return Container(
    alignment: Alignment.centerLeft,
    width: SizeConfig.blockSizeHorizontal * 100,
    child: Column(
      children: <Widget>[
        Text(
          'Welcome to your new\npersonal best'.toUpperCase(),
          style: TextStyle(
              color: MyColors().white,
              fontSize: SizeConfig.safeBlockHorizontal * 6.5,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.bold),
        ),
        Container(
          alignment: Alignment.centerLeft,
          width: SizeConfig.blockSizeHorizontal * 80,
          child: Divider(
            thickness: 3.0,
            color: Colors.amber.withOpacity(0.7),
          ),
        )
      ],
    ),
  );
}