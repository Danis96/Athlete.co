import 'package:attt/utils/size_config.dart';
import 'package:flutter/material.dart';

Widget finishButton(
    Function nextPlay, BuildContext context, int index, listLenght) {
  SizeConfig().init(context);
  return Container(
    color: Colors.white,
    child: FlatButton(
        onPressed: () {
          nextPlay();
        },
        child: Text(
          'Finish workout'.toUpperCase(),
          style: TextStyle(
              fontSize: MediaQuery.of(context).orientation == Orientation.landscape
                  ? SizeConfig.safeBlockHorizontal * 3 : SizeConfig.safeBlockHorizontal * 4.2,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.w600),
        )),
  );
}
