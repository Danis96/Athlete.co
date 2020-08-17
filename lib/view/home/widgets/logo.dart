import 'package:attt/utils/size_config.dart';
import 'package:attt/utils/text.dart';
import 'package:flutter/material.dart';

Widget logo(BuildContext context) {
  SizeConfig().init(context);
  return Container(
    height: SizeConfig.blockSizeVertical * 4.75,
    width: SizeConfig.blockSizeHorizontal * 59,
    child: Image.asset('assets/images/athlete-logo.png', fit: BoxFit.fitWidth,),
  );
}
