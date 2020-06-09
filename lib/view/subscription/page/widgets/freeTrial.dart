

import 'package:attt/utils/size_config.dart';
import 'package:flutter/material.dart';

Widget freeTrial(String t1, t2) {
  return Container(
    height: SizeConfig.blockSizeVertical * 12,
    margin: EdgeInsets.only(
        left: SizeConfig.blockSizeHorizontal * 72,
        top: SizeConfig.blockSizeVertical * 2),
    color: Colors.yellow,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(5.0),
          child: Text(
            t1,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: SizeConfig.safeBlockHorizontal * 4.3),
          ),
        ),
        Container(
          padding: EdgeInsets.all(5.0),
          child: Text(
            t2,
            style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: SizeConfig.safeBlockHorizontal * 3.5),
          ),
        )
      ],
    ),
  );
}