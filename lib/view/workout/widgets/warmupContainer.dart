


import 'package:attt/utils/colors.dart';
import 'package:attt/utils/size_config.dart';
import 'package:flutter/material.dart';

Widget warmupContainer(String warmupImage, String warmupDesc) {
  return Row(
    children: <Widget>[
      /// image thumbnail
      Container(
        margin: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal * 5),
        width: 70.0,
        height: 70.0,
        child: Image.network(
          warmupImage,
          fit: BoxFit.contain,
        ),
      ),
      Container(
        padding: EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              child: Text(warmupDesc,
                  style: TextStyle(
                      color: MyColors().white,
                      fontSize: SizeConfig.blockSizeHorizontal * 4,
                      fontWeight: FontWeight.w300)),
            ),
          ],
        ),
      ),
    ],
  );
}