import 'package:flutter/material.dart';
import 'package:attt/view/trainingPlan/widgets/descriptionText.dart';

Widget weekDescription(String weekName, AsyncSnapshot snapshot, int index) {
  String description = snapshot.data[index]['weekDescription'];
  return Container(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        descriptionText(description),
      ],
    ),
  );
}