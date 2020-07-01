import 'package:attt/utils/colors.dart';
import 'package:attt/utils/size_config.dart';
import 'package:flutter/material.dart';

class BorderUpDown {
  Widget focusTimeBorderUp(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
      ),
      width: SizeConfig.blockSizeHorizontal * 10,
      margin: EdgeInsets.only(
          top: MediaQuery.of(context).size.width < 400
              ? SizeConfig.blockSizeVertical * 7.7
              : SizeConfig.blockSizeVertical * 5.8,
          left: MediaQuery.of(context).size.width < 400
              ? SizeConfig.blockSizeHorizontal * 8.3
              : SizeConfig.blockSizeHorizontal * 7),
      child: Divider(
        color: Colors.blue,
        thickness: 2.0,
      ),
    );
  }

  Widget focusTimeBorderDown(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
      ),
      width: SizeConfig.blockSizeHorizontal * 10,
      margin: EdgeInsets.only(
          top: MediaQuery.of(context).size.width < 400
              ? SizeConfig.blockSizeVertical * 12.7
              : SizeConfig.blockSizeVertical * 9.8,
          left: MediaQuery.of(context).size.width < 400
              ? SizeConfig.blockSizeHorizontal * 8.3
              : SizeConfig.blockSizeHorizontal * 7),
      child: Divider(
        color: Colors.blue,
        thickness: 2.0,
      ),
    );
  }
}
