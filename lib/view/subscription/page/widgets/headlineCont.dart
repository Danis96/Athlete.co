

import 'package:attt/utils/colors.dart';
import 'package:attt/utils/size_config.dart';
import 'package:flutter/material.dart';

Widget headlineStart() {
  return Container(
    margin: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal * 3),
    alignment: Alignment.centerLeft,
    width: SizeConfig.blockSizeHorizontal * 100,
    child: Text(
      'START YOUR\n 7 DAY \n FREE TRIAL',
      style: TextStyle(
          color: MyColors().lightWhite,
          fontSize: SizeConfig.safeBlockHorizontal * 10.0,
          fontStyle: FontStyle.italic,
          fontWeight: FontWeight.bold),
    ),
  );
}