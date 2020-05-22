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
) {
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
      width: SizeConfig.blockSizeHorizontal * 75,
      margin: EdgeInsets.only(
          top: MediaQuery.of(context).orientation == Orientation.landscape
              ? SizeConfig.blockSizeVertical * 2
              : SizeConfig.blockSizeVertical * 8),
      child: RichText(
        overflow: TextOverflow.ellipsis,
        text: TextSpan(children: [
          TextSpan(
            text: name + ' ',
            style: TextStyle(
                color: Colors.white,
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
