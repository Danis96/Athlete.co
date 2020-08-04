import 'package:attt/utils/colors.dart';
import 'package:attt/utils/emptyContainer.dart';
import 'package:attt/utils/size_config.dart';
import 'package:attt/utils/text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

Widget nameHeadline(String name, String usersPhoto, BuildContext context,
    DocumentSnapshot userDocument) {
  /// take name of users account and
  /// split it to get just the name

  List<String> nameSurname = name != null ?  name.split(' ') : name;
  String justName = name != null ?  nameSurname[0] : name;

  SizeConfig().init(context);
  return Container(
    margin: EdgeInsets.only(
        top: SizeConfig.blockSizeVertical * 2,
        left: SizeConfig.blockSizeHorizontal * 5),
    child: Row(
      children: <Widget>[
        Container(
          height: 100,
          width: 100,
          padding: EdgeInsets.all(10),
          child: userDocument.data['image'] != null ? CircleAvatar(
            backgroundColor: MyColors().black,
            radius: 28.0,
            backgroundImage: NetworkImage(userDocument.data['image']),
          ) : EmptyContainer(),
        ),
        Container(
          margin: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal * 2),
          child: Text(
            MyText().headlineHi + (name != null ? justName : name ) + ',' + MyText().headlineSelect,
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
