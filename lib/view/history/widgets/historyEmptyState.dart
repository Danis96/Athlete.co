import 'package:attt/utils/size_config.dart';
import 'package:flutter/material.dart';

Widget historyEmptyState() {
  return Column(
    children: <Widget>[
      SizedBox(
        height: SizeConfig.blockSizeVertical * 35,
      ),
      Center(
        child: Text(
          "You do not have any history log yet.",
          style: TextStyle(
              color: Color.fromRGBO(255, 255, 255, 0.8),
              fontFamily: 'Roboto',
              fontSize: SizeConfig.blockSizeVertical * 2.0,
              fontWeight: FontWeight.w400),
          textAlign: TextAlign.center,
        ),
      ),
    ],
  );
}
