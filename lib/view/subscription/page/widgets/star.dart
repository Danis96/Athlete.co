



import 'package:attt/utils/size_config.dart';
import 'package:flutter/material.dart';

Widget starIcon() {
  return Container(
    child: Icon(
      Icons.star,
      color: Colors.yellow,
      size: SizeConfig.safeBlockHorizontal * 8,
    ),
  );
}