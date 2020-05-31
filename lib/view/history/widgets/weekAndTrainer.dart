import 'package:attt/utils/size_config.dart';
import 'package:flutter/material.dart';

Widget weekAndTrainer(String weekName, String trainerName) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: <Widget>[
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            weekName.toUpperCase(),
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'Roboto',
              fontStyle: FontStyle.italic,
              fontSize: SizeConfig.blockSizeVertical * 3,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.start,
          ),
          SizedBox(
            height: SizeConfig.blockSizeVertical * 1,
          ),
          Text(
            trainerName.toUpperCase(),
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'Roboto',
              fontSize: SizeConfig.blockSizeVertical * 2.5,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    ],
  );
}
