import 'package:attt/utils/size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget previousButton(BuildContext context, Function  playPrevious) {
  return Container(
    height: SizeConfig.blockSizeHorizontal * 10,
    width: SizeConfig.blockSizeHorizontal * 10,
    child: ClipOval(
        child: Material(
      color: Colors.white,
      child: InkWell(
        onTap: () {
          playPrevious();
        },
        child: Icon(
          Icons.arrow_back,
          size: SizeConfig.blockSizeHorizontal * 5,
        ),
      ),
    )),
  );
}
