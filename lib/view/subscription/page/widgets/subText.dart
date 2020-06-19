import 'package:attt/utils/colors.dart';
import 'package:attt/utils/size_config.dart';
import 'package:flutter/material.dart';

Widget subText(String text1, text2) {
  return Container(
    margin: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal * 2),
    width: SizeConfig.blockSizeHorizontal * 100,
    alignment: Alignment.centerLeft,
    child: Column(
      children: <Widget>[
        Container(
          width: SizeConfig.blockSizeHorizontal * 100,
          alignment: Alignment.centerLeft,
          child: RichText(
            text: TextSpan(
              text: text1,
              style: TextStyle(
                  color: MyColors().white,
                  fontSize: SizeConfig.safeBlockHorizontal * 5.0,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w400),
              children: <TextSpan>[
                TextSpan(
                    text: text2,
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.amber)),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}
