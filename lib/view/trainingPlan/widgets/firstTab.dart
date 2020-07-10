import 'package:attt/utils/colors.dart';
import 'package:attt/utils/size_config.dart';
import 'package:flutter/material.dart';

Widget firstTab(BuildContext context) {
  SizeConfig().init(context);
  return Container(
    width: MediaQuery.of(context).orientation == Orientation.portrait
        ? SizeConfig.blockSizeHorizontal * 50
        : SizeConfig.blockSizeHorizontal * 25,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Icon(
          Icons.fitness_center,
          color: MyColors().white,
          size: MediaQuery.of(context).orientation == Orientation.portrait
              ? SizeConfig.blockSizeHorizontal * 6
              : SizeConfig.blockSizeHorizontal * 3,
        ),
        Text(
          'Training Plan',
          style: TextStyle(
              color: MyColors().white,
              fontSize:
                  MediaQuery.of(context).orientation == Orientation.portrait
                      ? checkIsIosTablet(context)
                          ? SizeConfig.safeBlockHorizontal * 3
                          : SizeConfig.safeBlockHorizontal * 3.5
                      : checkIsIosTablet(context)
                          ? SizeConfig.safeBlockHorizontal * 1.5
                          : SizeConfig.safeBlockHorizontal * 2),
        ),
      ],
    ),
  );
}

/// checking responsive
bool checkIsIosTablet(BuildContext context) {
  if (MediaQuery.of(context).size.width > 1000) {
    return true;
  } else {
    return false;
  }
}
