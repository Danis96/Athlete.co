

import 'package:attt/utils/size_config.dart';
import 'package:flutter/material.dart';

Widget asManyReps(BuildContext context) {
   return Container(
     margin: EdgeInsets.only(
         top: MediaQuery.of(context)
             .orientation ==
             Orientation.landscape
             ? SizeConfig.blockSizeVertical * 12
             : SizeConfig.blockSizeVertical *
             18,
         right: MediaQuery.of(context)
             .orientation ==
             Orientation.landscape
             ? SizeConfig.blockSizeHorizontal *
             2.5
             : SizeConfig.blockSizeHorizontal *
             0,
         left: MediaQuery.of(context)
             .orientation ==
             Orientation.landscape
             ? SizeConfig.blockSizeHorizontal *
             0
             : SizeConfig.blockSizeHorizontal *
             17),
     width: MediaQuery.of(context)
         .orientation ==
         Orientation.landscape
         ? SizeConfig.blockSizeHorizontal * 16
         : SizeConfig.blockSizeHorizontal * 35,
     child: Text(
       'AS MANY REPS AS POSSIBLE',
       style: TextStyle(
           color: Colors.white,
           fontWeight: FontWeight.w600,
           fontStyle: FontStyle.italic,
           fontSize: MediaQuery.of(context)
               .orientation ==
               Orientation.landscape
               ? SizeConfig.safeBlockVertical *
               4
               : SizeConfig.safeBlockVertical *
               2),
       textAlign: TextAlign.center,
     ),
   );
}