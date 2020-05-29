import 'package:attt/utils/size_config.dart';
import 'package:awesome_button/awesome_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Widget stopIcon(Function pressTimer, BuildContext context, int isReps) {
  return Container(
      height: MediaQuery.of(context).orientation == Orientation.portrait
          ? SizeConfig.blockSizeVertical * 5.5
          : SizeConfig.blockSizeVertical * 10,
      width: MediaQuery.of(context).orientation == Orientation.portrait
          ? SizeConfig.blockSizeHorizontal * 35
          : SizeConfig.blockSizeHorizontal * 17,
      margin: EdgeInsets.only(
        top: MediaQuery.of(context).orientation == Orientation.portrait
            ? isReps == 0
                ? SizeConfig.blockSizeVertical * 18
                : SizeConfig.blockSizeVertical * 18
            : SizeConfig.blockSizeVertical * 22,
        left: MediaQuery.of(context).orientation == Orientation.portrait
            ? SizeConfig.blockSizeHorizontal * 27
            : SizeConfig.blockSizeHorizontal * 68,
      ),
      child:
      AwesomeButton(
        blurRadius: 5.0,
        splashColor: Color.fromRGBO(255, 255, 255, .4),
        borderRadius: BorderRadius.circular(25.0),
        height: 75.0,
        width: 200.0,
        onTap: () => pressTimer(),
        color: Colors.white.withOpacity(0.8),
        child:Text(
          'Stopwatch'.toUpperCase(),
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic,
              fontSize:
                  MediaQuery.of(context).orientation == Orientation.portrait
                      ? SizeConfig.safeBlockHorizontal * 4
                      : SizeConfig.safeBlockHorizontal * 1.8),
        ),
      ),
  );
}
