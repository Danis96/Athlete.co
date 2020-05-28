import 'package:attt/utils/size_config.dart';
import 'package:attt/view/workout/widgets/info.dart';
import 'package:flutter/material.dart';
import 'package:video_box/video.controller.dart';

Widget nameWidget(
    bool infoClicked,
    goBackToChewie,
    isFromPortrait,
    BuildContext context,
    VideoController controller,
    Function checkIsOnTimeAndPauseTimer,
    String name,
    exVideo,
    List<dynamic> exTips,
    int isReps,
    index,
    listLenght) {
  SizeConfig().init(context);
  return GestureDetector(
    onTap: () {
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
            exerciseVideoForInfo: exVideo,
          ),
        ));
      } else {
        print('NE MOZE VIŠE PAŠA');
      }
    },
    child: Container(
      alignment: MediaQuery.of(context).orientation == Orientation.landscape
          ? Alignment.centerLeft :  Alignment.center,
      width: SizeConfig.blockSizeHorizontal * 90,
      margin: EdgeInsets.only(
        top: MediaQuery.of(context).orientation == Orientation.landscape
            ? isReps == 0
                ? SizeConfig.blockSizeVertical * 28
                : SizeConfig.blockSizeVertical * 28
            : isReps == 0
                ? index == (listLenght - 1)
                    ? SizeConfig.blockSizeVertical * 9.8
                    : SizeConfig.blockSizeVertical * 7
                : index == (listLenght - 1)
                    ? SizeConfig.blockSizeVertical * 7
                    : SizeConfig.blockSizeVertical * 7,
        left: MediaQuery.of(context).orientation == Orientation.landscape
            ? SizeConfig.blockSizeHorizontal * 1
            : SizeConfig.blockSizeHorizontal * 1,
        right: MediaQuery.of(context).orientation == Orientation.landscape
            ? isReps == 0
                ? SizeConfig.blockSizeHorizontal * 37
                : SizeConfig.blockSizeHorizontal * 30
            : SizeConfig.blockSizeHorizontal * 0,
      ),
      child: RichText(
        overflow: TextOverflow.ellipsis,
        text: TextSpan(children: [
          TextSpan(
            text: name + ' ',
            style: TextStyle(
                color: MediaQuery.of(context).orientation == Orientation.landscape
                    ? Colors.white.withOpacity(0.6) : Colors.white,
                fontSize:
                    MediaQuery.of(context).orientation == Orientation.landscape
                        ? SizeConfig.safeBlockHorizontal * 3
                        : SizeConfig.safeBlockHorizontal * 6,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic),
          ),
          WidgetSpan(
              alignment: PlaceholderAlignment.bottom,
              child: Icon(
                Icons.info,
                size:
                    MediaQuery.of(context).orientation == Orientation.landscape
                        ? SizeConfig.blockSizeHorizontal * 2
                        : SizeConfig.blockSizeHorizontal * 3,
                color: Colors.white,
              ))
        ]),
      ),
    ),
  );
}
