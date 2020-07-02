


import 'package:attt/utils/colors.dart';
import 'package:attt/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';


class SubLoader {

  Widget subLoaderText() {
    return  Container(
      margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical * 2),
      child: Text(
        'Please wait while loading',
        style: TextStyle(
            color: MyColors().lightWhite,
            fontSize: SizeConfig.safeBlockHorizontal * 5),
      ),
    );
  }

  Widget subLoader() {
    return  Center(
      child: SpinKitFadingCircle(
        color: MyColors().lightWhite,
        size: SizeConfig.safeBlockHorizontal * 15,
      ),
    );
  }
}


