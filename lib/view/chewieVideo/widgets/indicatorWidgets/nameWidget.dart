import 'package:attt/utils/emptyContainer.dart';
import 'package:attt/utils/size_config.dart';
import 'package:attt/view/workout/widgets/info.dart';
import 'package:flutter/cupertino.dart';
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
    String video,
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
            exerciseVideoForInfo: video,
          ),
        ));
      } else {
        print('NE MOZE VIŠE PAŠA');
      }
    },
    child: Container(
      width: MediaQuery.of(context).orientation == Orientation.portrait
          ? SizeConfig.blockSizeHorizontal * 90
          : SizeConfig.blockSizeHorizontal * 50,
      child: Container(
        alignment: MediaQuery.of(context).orientation == Orientation.portrait
            ? Alignment.center
            : null,
        width: MediaQuery.of(context).orientation == Orientation.portrait
            ? SizeConfig.blockSizeHorizontal * 100
            : SizeConfig.blockSizeHorizontal * 50,
        child: RichText(
          overflow: TextOverflow.ellipsis,
          text: TextSpan(children: [
            TextSpan(
              text: name + ' ',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontStyle: FontStyle.italic,
                  fontSize: MediaQuery.of(context).orientation ==
                          Orientation.landscape
                      ? SizeConfig.safeBlockVertical * 4
                      : SizeConfig.safeBlockHorizontal * 4),
            ),
            MediaQuery.of(context).orientation == Orientation.portrait
                ? WidgetSpan(
                    alignment: PlaceholderAlignment.bottom,
                    child: EmptyContainer())
                : WidgetSpan(
                    alignment: PlaceholderAlignment.bottom,
                    child: Icon(
                      Icons.info,
                      size: MediaQuery.of(context).orientation ==
                              Orientation.landscape
                          ? SizeConfig.blockSizeHorizontal * 2.3
                          : SizeConfig.blockSizeHorizontal * 3,
                      color: Colors.white,
                    ))
          ]),
        ),
      ),
    ),
  );
}
