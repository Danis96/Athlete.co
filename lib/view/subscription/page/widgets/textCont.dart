

import 'package:attt/utils/colors.dart';
import 'package:attt/utils/size_config.dart';
import 'package:flutter/material.dart';

Widget textCont() {
  return Container(
    alignment: Alignment.center,
    width: SizeConfig.blockSizeHorizontal * 100,
    padding: EdgeInsets.all(10.0),
    child: Text(
      '100% Satisfaction Guarantee',
      style: TextStyle(
          color: MyColors().lightWhite,
          fontSize: SizeConfig.safeBlockHorizontal * 6),
    ),
  );
}