import 'package:attt/utils/colors.dart';
import 'package:attt/utils/size_config.dart';
import 'package:flutter/material.dart';

Widget secondTab(BuildContext context) {
  SizeConfig().init(context);
  return Container(
    width: SizeConfig.blockSizeHorizontal * 50,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Icon(
          Icons.show_chart,
          color: Colors.white,
          size: SizeConfig.blockSizeHorizontal * 6,
        ),
        Text(
          'History',
          style: TextStyle(
            color: MyColors().white,
            fontSize: checkIsIosTablet(context) ?  SizeConfig.safeBlockHorizontal * 3  :  SizeConfig.safeBlockHorizontal * 3.5
          ),
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
