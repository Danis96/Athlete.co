

import 'package:attt/utils/size_config.dart';
import 'package:flutter/material.dart';

Widget clearIcon(BuildContext context, Function checkIsOnTimeAndPauseTimer, onWill  ) {
 return Container(
    margin: EdgeInsets.only(
        bottom: MediaQuery.of(context).orientation ==
            Orientation.landscape
            ? SizeConfig.blockSizeVertical * 0
            : SizeConfig.blockSizeVertical * 10,
        right: MediaQuery.of(context).orientation ==
            Orientation.landscape
            ? SizeConfig.blockSizeHorizontal * 90
            : SizeConfig.blockSizeHorizontal * 80),
    child: IconButton(
      icon: Icon(Icons.clear),
      iconSize: MediaQuery.of(context).orientation ==
          Orientation.landscape
          ? SizeConfig.blockSizeHorizontal * 4
          : SizeConfig.blockSizeHorizontal * 7,
      onPressed: ()  {
        checkIsOnTimeAndPauseTimer();
        onWill();
      },
      color: Colors.white,
    ),
  );
}