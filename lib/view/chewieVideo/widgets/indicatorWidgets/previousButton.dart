import 'package:attt/utils/size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget previousButton(BuildContext context, Function  playPrevious, resetTimer) {
  return Container(
    height: SizeConfig.blockSizeHorizontal * 12,
    width: SizeConfig.blockSizeHorizontal * 12,
    child: ClipOval(
        child: Material(
      color: Colors.white,
      child: InkWell(
        onTap: () {
          playPrevious();
          resetTimer();
        },
        child: Icon(
          Icons.arrow_back,
          size: SizeConfig.blockSizeHorizontal * 6,
        ),
      ),
    )),
  );
}
