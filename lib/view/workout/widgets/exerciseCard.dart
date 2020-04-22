

import 'package:attt/utils/colors.dart';
import 'package:attt/utils/size_config.dart';
import 'package:flutter/material.dart';

Widget exerciseCard(
  String _exerciseName,
  String _exerciseTips,
  String _exerciseVideo,
  String _exerciseImage,
  int _exerciseIsReps,
  int _exerciseReps,
  int _exerciseRest,
  int _exerciseSets,
) {
  return Row(
    children: <Widget>[
      /// image thumbnail
      Container(
        margin: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal * 5),
        width: 90.0,
        height: 90.0,
        child: Image.network(_exerciseImage, 
                             height: SizeConfig.blockSizeVertical * 10,
                             width: SizeConfig.blockSizeHorizontal * 10,
                              fit: BoxFit.contain,),
      ),
      Container(
        padding: EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              child: Text(_exerciseName,
                  style: TextStyle(
                      color: MyColors().white,
                      fontSize: SizeConfig.blockSizeHorizontal * 4,
                      fontWeight: FontWeight.w500)),
            ),
            Row(
              children: <Widget>[
                Text(
                  _exerciseIsReps == 0
                      ? 'Sets $_exerciseSets | Reps $_exerciseReps | Rest $_exerciseRest s '
                      : 'Sets $_exerciseSets |  Rest $_exerciseRest s ',
                  style: TextStyle(
                      color: MyColors().lightWhite,
                      fontSize: SizeConfig.blockSizeHorizontal * 3),
                ),
              ],
            ),
          ],
        ),
      ),
    ],
  );
}