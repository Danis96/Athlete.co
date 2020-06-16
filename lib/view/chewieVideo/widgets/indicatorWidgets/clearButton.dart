

import 'package:attt/utils/size_config.dart';
import 'package:flutter/material.dart';

Widget clearIcon(BuildContext context, Function checkIsOnTimeAndPauseTimer, onWill  ) {
 return Container(

    margin: EdgeInsets.only(
       top: MediaQuery.of(context).orientation ==
           Orientation.landscape
           ? SizeConfig.blockSizeVertical * 0
           : SizeConfig.blockSizeVertical * 0 ,
        right: MediaQuery.of(context).orientation ==
            Orientation.landscape
            ? SizeConfig.blockSizeHorizontal * 0
            : SizeConfig.blockSizeHorizontal * 0),
    child: IconButton(
      icon: Icon(Icons.clear),
      iconSize: MediaQuery.of(context).orientation == Orientation.landscape
          ? SizeConfig.blockSizeHorizontal * 4.5
          : SizeConfig.blockSizeHorizontal * 8,
      onPressed: ()  {
        checkIsOnTimeAndPauseTimer();
        onWill();
      },
      color: Colors.white,
    ),
  );
}