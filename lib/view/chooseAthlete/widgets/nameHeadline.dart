import 'package:attt/utils/colors.dart';
import 'package:attt/utils/size_config.dart';
import 'package:attt/utils/text.dart';
import 'package:flutter/material.dart';

Widget nameHeadline(String name, String usersPhoto, BuildContext context) {
  SizeConfig().init(context);
  return Container(
    margin: EdgeInsets.only(
        top: SizeConfig.blockSizeVertical * 5,
        left: SizeConfig.blockSizeHorizontal * 5),
    child: Row(
      children: <Widget>[
        Container(
          height: 90.0,
          width: 90,
          padding: EdgeInsets.all(10),
          child: CircleAvatar(
            radius: 28.0,
            backgroundImage: NetworkImage(usersPhoto),
          ),
        ),
        Container(
          margin: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal * 2),
          child: Text(
            MyText().headlineHi + name +',' + MyText().headlineSelect,
            style: TextStyle(
                color: MyColors().white,
                fontSize: SizeConfig.safeBlockHorizontal * 5.5,
                fontWeight: FontWeight.w500),
          ),
        ),
      ],
    ),
  );
}
