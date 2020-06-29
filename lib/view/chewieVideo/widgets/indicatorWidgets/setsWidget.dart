import 'package:attt/utils/size_config.dart';
import 'package:flutter/material.dart';

Widget setsWidget(BuildContext context, String currentSet, int sets, isReps) {
  return Container(
    child: Text(
      currentSet + '/' + sets.toString() + ' Sets',
      style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontStyle: FontStyle.italic,
          fontSize: SizeConfig.safeBlockHorizontal * 5),
    ),
  );
}
