import 'package:attt/utils/colors.dart';
import 'package:attt/utils/size_config.dart';
import 'package:flutter/material.dart';

Widget centerText(String text, text1, text2) {
  return Container(
    width: SizeConfig.blockSizeHorizontal * 100,
    child: RichText(
      text: TextSpan(
        text: text,
        style: TextStyle(
            color: MyColors().white,
            fontSize: SizeConfig.safeBlockHorizontal * 4.5,
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.w400),
        children: <TextSpan>[
          TextSpan(
              text: text1,
              style: TextStyle(
                  fontWeight: FontWeight.bold, color: Colors.white)),
          TextSpan(
              text: text2,
              style: TextStyle(
                  fontSize: SizeConfig.safeBlockHorizontal * 4.5,
                  fontWeight: FontWeight.normal, color: Colors.white)),
        ],
      ),
    ),
  );
}