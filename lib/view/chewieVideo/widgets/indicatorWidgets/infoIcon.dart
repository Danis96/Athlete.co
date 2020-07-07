import 'dart:async';
import 'package:attt/utils/size_config.dart';
import 'package:attt/view/workout/widgets/info.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:video_box/video.controller.dart';

int _counter = 0;

Widget infoIcon(
    bool infoClicked,
    goBackToChewie,
    isFromPortrait,
    BuildContext context,
    VideoController controller,
    String name,
    String video,
    colorStatePaused,
    List<dynamic> exTips,
    var isReps,
    index,
    listLenght,
    Function pauseTimer) {
  return Container(
    height: SizeConfig.blockSizeHorizontal * 10,
    width: SizeConfig.blockSizeHorizontal * 10,
    child: ClipOval(
        child: Material(
      color: Colors.white,
      child: InkWell(
        onTap: () {
          if (_counter == 0) {
            /// ukoliko je timer zavrsen nemoj ga pauzirati
            if(colorStatePaused == 'green') {
              print('colorStatePaused = $colorStatePaused');
            } else {
              pauseTimer();
            }
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
              print('');
            }
            _counter = 1;
            Timer(Duration(seconds: 1), () {
              _counter = 0;
              print('Counter je opet $_counter');
            });
          }
        },
        child: Container(
          child: Center(
            child: FaIcon(
              FontAwesomeIcons.infoCircle,
              size: SizeConfig.safeBlockHorizontal * 5.5,
            ),
          ),
        ),
      ),
    )),
  );
}
