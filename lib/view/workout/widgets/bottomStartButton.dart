

import 'package:attt/utils/colors.dart';
import 'package:attt/utils/size_config.dart';
import 'package:flutter/material.dart';

Widget bottomButtonStart(BuildContext context) {
  SizeConfig().init(context);
   return BottomAppBar(
          color: MyColors().white,
        child: RaisedButton(
          elevation: 0,
          onPressed: () {},
          child: Padding(
            padding: EdgeInsets.all(22.0),
            child: Text(
              'START WORKOUT',
              style: TextStyle(
                  fontStyle: FontStyle.italic,
                  fontSize: SizeConfig.blockSizeHorizontal * 4,
                  fontWeight: FontWeight.w700),
            ),
          ),
          color: Colors.white,
        ),
      );
}