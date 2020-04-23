import 'package:attt/utils/colors.dart';
import 'package:attt/utils/size_config.dart';
import 'package:attt/utils/text.dart';
import 'package:attt/view_model/chewieVideoViewModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:attt/view/chewieVideo/widgets/globals.dart';

Widget bottomButtonStart(
    DocumentSnapshot userDoument,
    DocumentSnapshot userTrainerDocument,
    BuildContext context,
    String trainerID,
    String workoutName,
    String workoutID,
    String weekID,
    String warmupDesc) {
  SizeConfig().init(context);
  return BottomAppBar(
    color: MyColors().white,
    child: RaisedButton(
      elevation: 0,
      onPressed: () => ChewieVideoViewModel().playVideo(
          userDoument,
          userTrainerDocument,
          context,
          trainerID,
          workoutName,
          workoutID,
          weekID,
          warmupDesc),
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
