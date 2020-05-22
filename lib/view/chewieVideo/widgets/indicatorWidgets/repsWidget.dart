
import 'package:attt/utils/size_config.dart';
import 'package:flutter/material.dart';

Widget repsWidget(BuildContext context, int isReps, int reps ) {
 return  Container(
    margin: EdgeInsets.only(
        top: MediaQuery.of(context)
            .orientation ==
            Orientation.landscape
            ? SizeConfig.blockSizeVertical * 0
            : isReps == 0
            ? SizeConfig.blockSizeVertical *
            3
            : SizeConfig.blockSizeVertical *
            2,
        right: MediaQuery.of(context)
            .orientation ==
            Orientation.landscape
            ? SizeConfig.blockSizeHorizontal *
            4
            : SizeConfig.blockSizeHorizontal *
            0,
        left: MediaQuery.of(context)
            .orientation ==
            Orientation.landscape
            ? SizeConfig.blockSizeHorizontal * 0
            : SizeConfig.blockSizeHorizontal * 33),
    child: Text('x' + reps.toString(),
        style: TextStyle(
            color: Colors.white,
            fontSize: MediaQuery.of(context)
                .orientation ==
                Orientation.landscape
                ? SizeConfig
                .blockSizeVertical *
                10
                : SizeConfig
                .blockSizeVertical *
                5,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic)),
  );
}