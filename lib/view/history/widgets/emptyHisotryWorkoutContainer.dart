import 'package:attt/utils/size_config.dart';
import 'package:flutter/material.dart';

Widget emptyHistoryWorkoutContainer() {
  return Container(
    margin: EdgeInsets.only(bottom: SizeConfig.blockSizeVertical * 1.25),
    width: double.infinity,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(4),
        ),
        color: Colors.black),
    child: Padding(
      padding: EdgeInsets.only(
        top: SizeConfig.blockSizeVertical * 3,
        bottom: SizeConfig.blockSizeVertical * 3,
        left: SizeConfig.blockSizeHorizontal * 5.2,
        right: SizeConfig.blockSizeHorizontal * 5.2,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            '',
          ),
          SizedBox(
            height: SizeConfig.blockSizeVertical * 0.4,
          ),
          Text(
            '',
          ),
        ],
      ),
    ),
  );
}
