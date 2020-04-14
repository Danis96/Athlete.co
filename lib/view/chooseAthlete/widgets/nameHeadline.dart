

import 'package:attt/utils/size_config.dart';
import 'package:attt/view_model/signInViewModel.dart';
import 'package:flutter/material.dart';

Widget nameHeadline(String name,String usersPhoto, BuildContext context) {
  SizeConfig().init(context);
  return Container(
    margin: EdgeInsets.only(
        top: SizeConfig.blockSizeVertical * 5,
        left: SizeConfig.blockSizeHorizontal * 5),
    child: Row(
      children: <Widget>[
        GestureDetector(
          onTap: () {
                SignInViewModel().signOutGoogle(context);
          },
                  child: Container(
            height: SizeConfig.blockSizeVertical * 10,
            width: SizeConfig.blockSizeHorizontal * 21,
            padding: EdgeInsets.all(10),
            child: CircleAvatar(
              radius: 28.0,
              backgroundImage: NetworkImage(
                  usersPhoto),
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal * 2),
          child: Text(
            'Hi $name, \nselect your athlete.',
            style: TextStyle(
                fontSize: SizeConfig.safeBlockHorizontal * 5.5,
                fontWeight: FontWeight.w500),
          ),
        ),
      ],
    ),
  );
}