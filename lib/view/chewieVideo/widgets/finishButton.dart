import 'package:attt/utils/size_config.dart';
import 'package:flutter/material.dart';

Widget finishButton(Function nextPlay, BuildContext context) {
  SizeConfig().init(context);
  return Container(
    height: SizeConfig.blockSizeVertical * 6,
    color: Colors.white,
    child: FlatButton(
        onPressed: () {
          nextPlay();
        },
        child: Text(
          'Finish workout'.toUpperCase(),
          style: TextStyle(
              fontSize: SizeConfig.safeBlockHorizontal * 5,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.w600),
        )),
  );
}