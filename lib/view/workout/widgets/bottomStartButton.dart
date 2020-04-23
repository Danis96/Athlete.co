

import 'package:attt/utils/colors.dart';
import 'package:attt/utils/size_config.dart';
import 'package:attt/utils/text.dart';
import 'package:attt/view_model/chewieVideoViewModel.dart';
import 'package:flutter/material.dart';

Widget bottomButtonStart(BuildContext context) {
  SizeConfig().init(context);
   return BottomAppBar(
          color: MyColors().white,
        child: RaisedButton(
          elevation: 0,
          onPressed: () => ChewieVideoViewModel().playVideo(context),
          child: Padding(
            padding: EdgeInsets.all(22.0),
            child: Text(
              MyText().startW,
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