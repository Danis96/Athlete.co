import 'package:attt/utils/size_config.dart';
import 'package:flutter/material.dart';

Widget setsWidget(BuildContext context, String currentSet, int sets, isReps) {
  return Container(
    child: Text(
      currentSet + '/' + sets.toString() + ' Sets',
      style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w600,
          fontStyle: FontStyle.italic,
          fontSize: MediaQuery.of(context).orientation == Orientation.landscape
              ? SizeConfig.safeBlockVertical * 4
              : SizeConfig.safeBlockHorizontal * 4),
    ),
  );
}
