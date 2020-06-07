
import 'package:attt/utils/size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget repsWidget(BuildContext context, int isReps, int reps ) {
 return  Container(

   height: MediaQuery.of(context)
       .orientation ==
       Orientation.landscape
       ? SizeConfig.blockSizeVertical * 12 : SizeConfig.blockSizeVertical * 6,
   alignment: MediaQuery.of(context)
       .orientation ==
       Orientation.landscape
       ? Alignment.centerLeft  :  Alignment.center,
   width: SizeConfig.blockSizeHorizontal * 90,
    margin: EdgeInsets.only(
        top: MediaQuery.of(context)
            .orientation ==
            Orientation.landscape
            ? SizeConfig.blockSizeVertical * 62
            : isReps == 0
            ? SizeConfig.blockSizeVertical *
           17
            : SizeConfig.blockSizeVertical *
            2,
        left: MediaQuery.of(context)
            .orientation ==
            Orientation.landscape
            ? SizeConfig.blockSizeHorizontal * 1.2
            : SizeConfig.blockSizeHorizontal * 5),
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