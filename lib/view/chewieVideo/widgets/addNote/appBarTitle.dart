import 'package:attt/utils/size_config.dart';
import 'package:flutter/material.dart';

Widget appBarTitle(BuildContext context) {
  return new Text(
    'ADD NOTE',
    style: new TextStyle(
      fontSize: MediaQuery.of(context).orientation == Orientation.portrait
          ? SizeConfig.blockSizeHorizontal * 5
          : SizeConfig.blockSizeHorizontal * 2.5,
    ),
  );
}
