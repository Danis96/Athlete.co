import 'package:attt/utils/size_config.dart';
import 'package:flutter/material.dart';

Widget setsWidget(
  BuildContext context,
  String currentSet,
  int sets,
) {
  return Container(
    padding: MediaQuery.of(context).orientation == Orientation.landscape
        ? EdgeInsets.all(0)
        : EdgeInsets.all(4.0),
    margin: EdgeInsets.only(
        top: MediaQuery.of(context).orientation == Orientation.landscape
            ? SizeConfig.blockSizeVertical * 1
            : SizeConfig.blockSizeVertical * 0,
        right: MediaQuery.of(context).orientation == Orientation.landscape
            ? SizeConfig.blockSizeHorizontal * 4
            : SizeConfig.blockSizeHorizontal * 0,
        left: MediaQuery.of(context).orientation == Orientation.landscape
            ? SizeConfig.blockSizeHorizontal * 0
            : SizeConfig.blockSizeHorizontal * 0),
    child: Text(
      currentSet + '/' + sets.toString() + ' Sets',
      style: TextStyle(
          color: Colors.white,
          fontSize: MediaQuery.of(context).orientation == Orientation.landscape
              ? 25.0
              : SizeConfig.safeBlockHorizontal * 6.0,
          fontWeight: FontWeight.bold,
          fontStyle: FontStyle.italic),
    ),
  );
}
