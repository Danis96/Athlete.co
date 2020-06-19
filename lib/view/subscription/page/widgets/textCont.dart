

import 'package:attt/utils/colors.dart';
import 'package:attt/utils/size_config.dart';
import 'package:flutter/material.dart';

Widget textCont(String text) {
  return Container(
    alignment: Alignment.center,
    width: SizeConfig.blockSizeHorizontal * 100,
    padding: EdgeInsets.all(10.0),
    child: Text(
      text,
      style: TextStyle(
          color: Colors.amber,
          fontSize: SizeConfig.safeBlockHorizontal * 6),
    ),
  );
}