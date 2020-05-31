import 'package:attt/utils/colors.dart';
import 'package:attt/utils/globals.dart';
import 'package:attt/utils/size_config.dart';
import 'package:flutter/material.dart';

Widget noteContainer() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      SizedBox(
        height: SizeConfig.blockSizeVertical * 2,
      ),
      Divider(
        color: MyColors().lightBlack,
        height: 1,
        thickness: 1,
      ),
      SizedBox(
        height: SizeConfig.blockSizeVertical * 2,
      ),
      Container(
        child: Text(
          userNotesHistory,
          style: TextStyle(
            color: Colors.white60,
            fontFamily: 'Roboto',
            fontSize: SizeConfig.blockSizeVertical * 2,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    ],
  );
}
