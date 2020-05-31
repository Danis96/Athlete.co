import 'package:attt/utils/size_config.dart';
import 'package:flutter/material.dart';

Widget descIntro(String weekName) {
  return Text(
    "Welcome to " +
        weekName.substring(0, 1).toUpperCase() +
        weekName.substring(1) +
        "\n",
    style: TextStyle(
        color: Color.fromRGBO(255, 255, 255, 0.8),
        fontFamily: 'Roboto',
        fontSize: SizeConfig.blockSizeVertical * 1.7,
        fontWeight: FontWeight.w400),
  );
}
