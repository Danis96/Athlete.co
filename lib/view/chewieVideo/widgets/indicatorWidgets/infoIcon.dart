import 'package:attt/utils/emptyContainer.dart';
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
    Function checkIsOnTimeAndPauseTimer,
    String name,
    String video,
    List<dynamic> exTips,
    int isReps,
    index,
    listLenght) {
  return MediaQuery.of(context).orientation == Orientation.portrait
      ? Container(
          margin: EdgeInsets.only(
              top: MediaQuery.of(context).orientation == Orientation.portrait
                  ? SizeConfig.blockSizeVertical * 26.7
                  : SizeConfig.blockSizeVertical * 26,
              left: MediaQuery.of(context).orientation == Orientation.portrait
                  ? SizeConfig.blockSizeHorizontal * 11.5
                  : SizeConfig.blockSizeHorizontal * 26),
          child: IconButton(
            icon: Icon(Icons.info),
            onPressed: () {
              if (infoClicked) {
                checkIsOnTimeAndPauseTimer();
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
              } else {
                print('NE MOZE VIŠE PAŠA');
              }
            },
            color: Colors.white,
            iconSize: SizeConfig.blockSizeHorizontal * 8,
          ),
        )
      : EmptyContainer();
}
