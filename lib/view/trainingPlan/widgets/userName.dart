import 'package:attt/utils/size_config.dart';
import 'package:flutter/material.dart';

Widget userName(String justName, BuildContext context) {
  return Container(
    width: MediaQuery.of(context).orientation == Orientation.portrait
        ? SizeConfig.blockSizeHorizontal * 40
        : SizeConfig.blockSizeHorizontal * 20,
    child: Text(
      'Hi $justName',
      style: TextStyle(
        color: Colors.white,
        fontFamily: 'Roboto',
        fontSize: MediaQuery.of(context).orientation == Orientation.portrait
            ? SizeConfig.blockSizeVertical * 3.2
            : SizeConfig.blockSizeVertical * 6,
        fontWeight: FontWeight.w500,
      ),
      textAlign: TextAlign.left,
    ),
  );
}
