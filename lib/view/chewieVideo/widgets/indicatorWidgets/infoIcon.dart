import 'dart:async';

import 'package:attt/utils/size_config.dart';
import 'package:attt/view/workout/widgets/info.dart';
import 'package:flutter/material.dart';
import 'package:video_box/video.controller.dart';

Widget infoIcon(
    bool infoClicked,
    goBackToChewie,
    isFromPortrait,
    BuildContext context,
    VideoController controller,
    String name,
    String video,
    List<dynamic> exTips,
    var isReps,
    index,
    listLenght,
    Function pauseTimer
    ) {
  return Container(
    height: SizeConfig.blockSizeHorizontal * 10,
    width: SizeConfig.blockSizeHorizontal * 10,
    child: ClipOval(
        child: Material(
      color: Colors.white,
      child: InkWell(
        onTap: () {
          pauseTimer();
          if (infoClicked) {
            Timer(Duration(milliseconds: 800), () {
              goBackToChewie = true;
              infoClicked = false;
              controller.pause();
              if (MediaQuery.of(context).orientation == Orientation.portrait)
                isFromPortrait = true;
              else
                isFromPortrait = false;
              Navigator.of(context).push(MaterialPageRoute(
                builder: (_) => InfoExercise(
                  vc: controller,
                  exerciseNameForInfo: name,
                  exerciseTips: exTips,
                  exerciseVideoForInfo: video,
                ),
              ));
            });
          } else {
            print('NE MOZE VIŠE PAŠA');
          }
        },
        child: Icon(
          Icons.info,
          size: SizeConfig.blockSizeHorizontal * 5,
        ),
      ),
    )),
  );
}
