

import 'package:attt/utils/size_config.dart';
import 'package:flutter/material.dart';

Widget clearIcon(BuildContext context, Function  onWill  ) {
 return Container(

    margin: EdgeInsets.only(
       top: SizeConfig.blockSizeVertical * 2 ,
        right: SizeConfig.blockSizeHorizontal * 0),
    child: IconButton(
      icon: Icon(Icons.clear),
      iconSize: SizeConfig.blockSizeHorizontal * 8,
      onPressed: ()  {
        onWill();
      },
      color: Colors.white,
    ),
  );
}