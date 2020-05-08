import 'package:attt/utils/colors.dart';
import 'package:attt/utils/globals.dart';
import 'package:attt/utils/size_config.dart';
import 'package:attt/utils/text.dart';
import 'package:attt/view_model/chewieVideoViewModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

Widget bottomButtonStart(DocumentSnapshot userDocument,
    DocumentSnapshot userTrainerDocument, BuildContext context, String workoutID, String weekID) {
  SizeConfig().init(context);
  return BottomAppBar(
    color: MyColors().white,
    child: RaisedButton(
      elevation: 0,
      onPressed: () {
        onlineVideos = [];
        ChewieVideoViewModel()
          .playVideo(context, userDocument, userTrainerDocument, workoutID, weekID);
        onlineVideos = onlineWarmup + onlineExercises;
        print(onlineVideos.length);
      },
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
