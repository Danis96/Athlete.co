import 'package:attt/utils/size_config.dart';
import 'package:flutter/material.dart';

Widget timerContainer(BuildContext context, String displayTime) {
  return Container(
    width: MediaQuery.of(context).size.width,
    child: Text(
      displayTime,
      style: TextStyle(
        color: Colors.white,
        fontStyle: FontStyle.italic,
        fontWeight: FontWeight.bold,
        fontSize: SizeConfig.blockSizeHorizontal * 20,
      ),
      textAlign: TextAlign.center,
    ),
  );
}
