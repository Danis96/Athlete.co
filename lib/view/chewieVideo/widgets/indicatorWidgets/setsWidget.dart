import 'package:attt/utils/size_config.dart';
import 'package:flutter/material.dart';

Widget setsWidget(
  BuildContext context,
  String currentSet,
  int sets,
    isReps
) {
  return Container(
    margin: EdgeInsets.only(
      top: MediaQuery.of(context).orientation == Orientation.landscape
          ? isReps == 0 ? SizeConfig.blockSizeVertical * 0 : SizeConfig.blockSizeVertical * 0
          : SizeConfig.blockSizeVertical * 0 ,
        bottom: MediaQuery.of(context).orientation == Orientation.landscape
            ? isReps == 0 ? SizeConfig.blockSizeVertical * 69 : SizeConfig.blockSizeVertical * 69
            : SizeConfig.blockSizeVertical * 0,
        left: MediaQuery.of(context).orientation == Orientation.landscape
            ? SizeConfig.blockSizeHorizontal * 65.5
            : SizeConfig.blockSizeHorizontal * 0,),
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
