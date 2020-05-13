import 'package:flutter/material.dart';
import 'package:attt/utils/size_config.dart';
import 'package:attt/utils/colors.dart';

Widget settingsContainer(String headText, subText, isFrom) {
  return GestureDetector(
            onTap: () => print('Click on container from ' + isFrom),
                      child: Container(
              width: SizeConfig.blockSizeHorizontal * 100,
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(headText,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: SizeConfig.safeBlockHorizontal * 5,
                          fontWeight: FontWeight.w400)),
                  Text(subText,
                      style: TextStyle(
                          color: MyColors().lightWhite,
                          fontSize: SizeConfig.safeBlockHorizontal * 4.0,
                          fontWeight: FontWeight.w400)),
                ],
              ),
              decoration: BoxDecoration(
                  border:
                      Border(bottom: BorderSide(color: MyColors().lightWhite))),
            ),
          );
}