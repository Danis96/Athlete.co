import 'package:attt/utils/colors.dart';
import 'package:attt/utils/size_config.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

Widget trainingPlanHeadline(
  DocumentSnapshot userDocument,
  DocumentSnapshot userTrainerDocument,
  BuildContext context,
  String userUID,
) {
  String name = userDocument.data['display_name'];
  List<String> nameSurname = name.split(' ');
  String justName = nameSurname[0];
  return Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: <Widget>[
      Container(
        height: 90.0,
        width: 90,
        padding: EdgeInsets.all(8),
        child: CircleAvatar(
          backgroundColor: MyColors().black,
          radius: 28.0,
          backgroundImage: NetworkImage(userDocument.data['image']),
        ),
      ),
      SizedBox(
        width: MediaQuery.of(context).orientation == Orientation.portrait
            ? SizeConfig.blockSizeHorizontal * 4.5
            : SizeConfig.blockSizeHorizontal * 3.5,
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).orientation == Orientation.portrait
                ? SizeConfig.blockSizeHorizontal * 40
                : SizeConfig.blockSizeHorizontal * 20,
            child: Text(
              'Hi $justName',
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'Roboto',
                fontSize:
                    MediaQuery.of(context).orientation == Orientation.portrait
                        ? SizeConfig.blockSizeVertical * 3.2
                        : SizeConfig.blockSizeVertical * 6,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.left,
            ),
          ),
        ],
      ),
    ],
  );
}
