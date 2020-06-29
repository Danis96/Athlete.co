import 'package:attt/utils/size_config.dart';
import 'package:flutter/material.dart';

Widget boldText(String text, BuildContext context) {
  return Text(
    text.replaceAll('\\n', '\n'),
    style: TextStyle(
      color: Color.fromRGBO(255, 255, 255, 0.8),
      fontFamily: 'Roboto',
      fontSize: MediaQuery.of(context).orientation == Orientation.portrait
          ? SizeConfig.safeBlockHorizontal * 4
          : SizeConfig.safeBlockHorizontal * 4,
      fontWeight: FontWeight.w700,
    ),
  );
}
