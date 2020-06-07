import 'package:attt/utils/size_config.dart';
import 'package:flutter/material.dart';

Widget normalText(String text, BuildContext context) {
  return Text(
    text,
    style: TextStyle(
        color: Color.fromRGBO(255, 255, 255, 0.8),
        fontFamily: 'Roboto',
        fontSize: MediaQuery.of(context).orientation == Orientation.portrait
            ? SizeConfig.blockSizeVertical * 1.7
            : SizeConfig.safeBlockHorizontal * 1.8,
        fontWeight: FontWeight.w400),
  );
}