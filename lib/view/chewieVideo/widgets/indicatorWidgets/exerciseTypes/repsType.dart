import 'dart:async';

import 'package:attt/utils/colors.dart';
import 'package:attt/utils/emptyContainer.dart';
import 'package:attt/utils/globals.dart';
import 'package:attt/utils/size_config.dart';
import 'package:attt/view/chewieVideo/widgets/indicatorWidgets/asManyReps.dart';
import 'package:attt/view/chewieVideo/widgets/indicatorWidgets/clearButton.dart';
import 'package:attt/view/chewieVideo/widgets/indicatorWidgets/customTextAnimation.dart';
import 'package:attt/view/chewieVideo/widgets/indicatorWidgets/infoIcon.dart';
import 'package:attt/view/chewieVideo/widgets/indicatorWidgets/nameWidget.dart';
import 'package:attt/view/chewieVideo/widgets/indicatorWidgets/nextbutton.dart';
import 'package:attt/view/chewieVideo/widgets/indicatorWidgets/noteButton.dart';
import 'package:attt/view/chewieVideo/widgets/indicatorWidgets/previousButton.dart';
import 'package:attt/view/chewieVideo/widgets/indicatorWidgets/repsWidget.dart';
import 'package:attt/view/chewieVideo/widgets/indicatorWidgets/setsWidget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:video_box/video.controller.dart';

Widget repsType(
  BuildContext context,
  Function onWill,
  pauseAndPlayFunction,
  playNext,
  playPrevious,
  resetTimer,
  pauseTimer,
  checkAndArrangeTime,
  int counter,
  index,
  isReps,
  listLenght,
  reps,
  sets,
  String name,
  video,
  repsDescription,
  exerciseTime,
  workoutID,
  weekID,
  currentSet,
  bool isTips,
  infoClicked,
  goBackToChewie,
  isFromPortrait,
  noteClicked,
  isOrientationFull,
  VideoController controller,
  List<dynamic> tips,
  DocumentSnapshot userDocument,
  userTrainerDocument,
  Timer timer,
) {

  isFromRepsOnly = true;
  return MediaQuery.of(context).orientation == Orientation.portrait
      ? Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Stack(
              alignment: Alignment.topRight,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    clearIcon(
                      context,
                      onWill,
                    ),
                  ],
                ),
                InkWell(
                  onTap: () {
                    if (counter == 0) {
                      pauseAndPlayFunction();
                      isTips = false;
                      counter = 1;
                    }
                    Timer(Duration(seconds: 1), () {
                      counter = 0;
                    });
                  },
                  child: Container(
                    width: SizeConfig.blockSizeHorizontal * 83,
                    height: MediaQuery.of(context).orientation ==
                            Orientation.landscape
                        ? SizeConfig.blockSizeHorizontal * 0
                        : SizeConfig.blockSizeVertical * 20,
                  ),
                )
              ],
            ),
            Container(
              margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical * 18),
              child: name.length >= 17
                  ? MarqueeWidget(
                      direction: Axis.horizontal,
                      animationDuration: Duration(milliseconds: 1500),
                      backDuration: Duration(milliseconds: 500),
                      pauseDuration: Duration(milliseconds: 200),
                      child: nameWidget(
                        infoClicked,
                        goBackToChewie,
                        isFromPortrait,
                        context,
                        controller,
                        name,
                        video,
                        '',
                        tips,
                        isReps,
                        index,
                        listLenght,
                        pauseTimer,
                      ),
                    )
                  : nameWidget(
                      infoClicked,
                      goBackToChewie,
                      isFromPortrait,
                      context,
                      controller,
                      name,
                      video,
                      '',
                      tips,
                      isReps,
                      index,
                      listLenght,
                      pauseTimer,
                    ),
            ),
            Container(
              width: MediaQuery.of(context).orientation == Orientation.landscape
                  ? SizeConfig.blockSizeHorizontal * 1
                  : SizeConfig.blockSizeHorizontal * 100,
              margin: EdgeInsets.only(
                  top: repsDescription != null && repsDescription != ''
                      ? SizeConfig.blockSizeVertical * 6
                      : SizeConfig.blockSizeVertical * 7.5),
              child: Column(
                children: <Widget>[
                  repsDescription != null && repsDescription != ''
                      ? Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(5.0),
                                topLeft: Radius.circular(5.0)),
                            color: Colors.grey,
                          ),
                          width: SizeConfig.blockSizeHorizontal * 95,
                          height: SizeConfig.blockSizeVertical * 5.5,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              asManyReps(
                                context,
                                repsDescription,
                              ),
                            ],
                          ),
                        )
                      : EmptyContainer(),
                  Container(
                    width: SizeConfig.blockSizeHorizontal * 95,
                    height: repsDescription != null && repsDescription != ''
                        ? SizeConfig.blockSizeVertical * 17
                        : SizeConfig.blockSizeVertical * 20,
                    decoration: BoxDecoration(
                      borderRadius:
                          repsDescription != null && repsDescription != ''
                              ? BorderRadius.only(
                                  bottomLeft: Radius.circular(5.0),
                                  bottomRight: Radius.circular(5.0))
                              : BorderRadius.all(Radius.circular(5.0)),
                      color: Colors.white,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Container(
                          height: MediaQuery.of(context).orientation ==
                                  Orientation.landscape
                              ? SizeConfig.blockSizeHorizontal * 0
                              : SizeConfig.blockSizeVertical * 10,
                          child: repsWidget(
                            context,
                            isReps,
                            reps,
                            exerciseTime,
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).orientation ==
                                  Orientation.landscape
                              ? SizeConfig.blockSizeHorizontal * 1
                              : SizeConfig.blockSizeHorizontal * 60,
                          height: SizeConfig.blockSizeVertical * 5,
                          margin: EdgeInsets.only(
                            bottom:
                                repsDescription != null && repsDescription != ''
                                    ? SizeConfig.blockSizeVertical * 1.2
                                    : SizeConfig.blockSizeVertical * 0,
                          ),
                          child: RaisedButton(
                            color: MyColors().lightBlack,
                            child: Text(
                              index == (listLenght - 1) ? 'FINISH' : 'DONE',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: SizeConfig.safeBlockHorizontal * 4),
                            ),
                            onPressed: () => playNext(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).orientation ==
                            Orientation.landscape
                        ? SizeConfig.blockSizeHorizontal * 1
                        : SizeConfig.blockSizeHorizontal * 100,
                    margin: EdgeInsets.only(
                        top: MediaQuery.of(context).orientation ==
                                Orientation.landscape
                            ? SizeConfig.blockSizeHorizontal * 0
                            : SizeConfig.blockSizeVertical * 1.2),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        setsWidget(
                          context,
                          currentSet,
                          sets,
                          isReps,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: checkIsIosTablet(context) ? SizeConfig.blockSizeVertical * 1  : SizeConfig.blockSizeVertical * 2,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      index == 0
                          ? SizedBox(
                              width: SizeConfig.blockSizeHorizontal * 10,
                            )
                          : previousButton(
                              context,
                              playPrevious,
                              resetTimer,
                        checkAndArrangeTime,
                            ),
                      Container(
                        child: Row(
                          children: <Widget>[
                            noteButton(
                              context,
                              noteClicked,
                              isFromPortrait,
                              isOrientationFull,
                              controller,
                              userDocument,
                              userTrainerDocument,
                              index,
                              listLenght,
                              isReps,
                              sets,
                              reps.toString(),
                              name,
                              workoutID,
                              weekID,
                              '',
                              pauseTimer,
                            ),
                            SizedBox(
                              width: SizeConfig.blockSizeHorizontal * 3,
                            ),
                            infoIcon(
                              infoClicked,
                              goBackToChewie,
                              isFromPortrait,
                              context,
                              controller,
                              name,
                              video,
                              '',
                              tips,
                              isReps,
                              index,
                              listLenght,
                              pauseTimer,
                            ),
                          ],
                        ),
                      ),
                      nextButton(
                        context,
                        playNext,
                        resetTimer,
                        checkAndArrangeTime,
                        controller,
                        index,
                        listLenght,
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        )
      : EmptyContainer();
}

/// checking responsive
bool checkIsIosTablet(BuildContext context) {
  if (MediaQuery.of(context).size.width > 1000) {
    return true;
  } else {
    return false;
  }
}