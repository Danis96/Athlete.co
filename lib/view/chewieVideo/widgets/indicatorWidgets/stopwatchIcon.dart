import 'package:attt/utils/colors.dart';
import 'package:attt/utils/size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';



Widget stopIcon(Function pressTimer, BuildContext context, var isReps) {
  return Container(
    child: GestureDetector(
      onTap: () => pressTimer(),
      child: Container(
        child: Icon(
          Icons.timer,
          color: MyColors().lightWhite,
          size: SizeConfig.safeBlockHorizontal * 13,
        ),
      ),
    ),
  );
}
