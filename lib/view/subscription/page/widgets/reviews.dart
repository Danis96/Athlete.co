


import 'package:attt/utils/colors.dart';
import 'package:attt/utils/size_config.dart';
import 'package:flutter/material.dart';

Widget reviews(String name, review) {
  return Container(
    child: Column(
      children: [
        Container(
          padding: EdgeInsets.all(4),
          alignment: Alignment.centerLeft,
          child: Text(
            name,
            style: TextStyle(
                color: MyColors().white,
                fontSize: SizeConfig.safeBlockHorizontal * 5),
          ),
        ),
        Container(
          padding: EdgeInsets.all(4),
          child: Text(
              review,
              style: TextStyle(color: MyColors().lightWhite, fontSize: SizeConfig.safeBlockHorizontal * 3.7)),
        ),
      ],
    ),
  );
}