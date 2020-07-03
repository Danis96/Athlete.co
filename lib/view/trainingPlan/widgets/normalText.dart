import 'package:attt/utils/size_config.dart';
import 'package:flutter/material.dart';

Widget normalText(String text, BuildContext context) {
  return Text(
    text,
    style: TextStyle(
        color: Color.fromRGBO(255, 255, 255, 0.8),
        fontFamily: 'Roboto',
        fontSize: MediaQuery.of(context).orientation == Orientation.portrait
            ? SizeConfig.safeBlockHorizontal * 4.5
            : SizeConfig.safeBlockHorizontal * 4.5,
        fontWeight: FontWeight.w400),
  );
}
