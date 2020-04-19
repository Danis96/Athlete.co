import 'package:attt/utils/size_config.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

Widget trainingPlanHeadline(DocumentSnapshot userDocument) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: <Widget>[
      Container(
        height: 75.0,
        width: 75,
        padding: EdgeInsets.all(10),
        child: CircleAvatar(
          radius: 28.0,
          backgroundImage: NetworkImage(userDocument.data['image']),
        ),
      ),
      SizedBox(
        width: SizeConfig.blockSizeHorizontal * 4.5,
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Week 2 of 18',
            style: TextStyle(
                color: Colors.white,
                fontFamily: 'Roboto',
                fontSize: SizeConfig.blockSizeVertical * 3.2,
                fontWeight: FontWeight.w500),
            textAlign: TextAlign.left,
          ),
          SizedBox(
            height: SizeConfig.blockSizeVertical * 0.3,
          ),
          Text(
            'Your training plan',
            style: TextStyle(
                color: Colors.white,
                fontFamily: 'Roboto',
                fontSize: SizeConfig.blockSizeVertical * 2.5,
                fontWeight: FontWeight.w400),
            textAlign: TextAlign.left,
          ),
        ],
      )
    ],
  );
}
