import 'package:attt/utils/size_config.dart';
import 'package:flutter/material.dart';

Widget descriptionText(String description) {
  return Text(
    description.replaceAll("\\n", "\n"),
    style: TextStyle(
      color: Color.fromRGBO(255, 255, 255, 0.8),
      fontFamily: 'Roboto',
      fontSize: SizeConfig.safeBlockHorizontal * 4.5,
      fontWeight: FontWeight.w400,
    ),
  );
}
