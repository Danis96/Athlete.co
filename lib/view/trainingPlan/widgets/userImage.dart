import 'package:attt/utils/colors.dart';
import 'package:flutter/material.dart';

Widget userImage(String image) {
  return Container(
    height: 90.0,
    width: 90,
    padding: EdgeInsets.all(8),
    child: CircleAvatar(
      backgroundColor: MyColors().black,
      radius: 28.0,
      backgroundImage: NetworkImage(image),
    ),
  );
}
