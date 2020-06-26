//import 'dart:async';
//
//import 'package:attt/utils/colors.dart';
//import 'package:attt/utils/emptyContainer.dart';
//import 'package:attt/utils/size_config.dart';
//import 'package:attt/view/chewieVideo/widgets/indicatorWidgets/asManyReps.dart';
//import 'package:attt/view/chewieVideo/widgets/indicatorWidgets/clearButton.dart';
//import 'package:attt/view/chewieVideo/widgets/indicatorWidgets/customTextAnimation.dart';
//import 'package:attt/view/chewieVideo/widgets/indicatorWidgets/infoIcon.dart';
//import 'package:attt/view/chewieVideo/widgets/indicatorWidgets/nameWidget.dart';
//import 'package:attt/view/chewieVideo/widgets/indicatorWidgets/nextbutton.dart';
//import 'package:attt/view/chewieVideo/widgets/indicatorWidgets/noteButton.dart';
//import 'package:attt/view/chewieVideo/widgets/indicatorWidgets/previousButton.dart';
//import 'package:attt/view/chewieVideo/widgets/indicatorWidgets/setsWidget.dart';
//import 'package:attt/view/chewieVideo/widgets/indicatorWidgets/timerWidget.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:flutter/material.dart';
//import 'package:video_box/video.controller.dart';
//
//Widget repsAndTimeType(
//  BuildContext context,
//  Function onWill,
//  pauseAndPlayFunction,
//  playNext,
//  playPrevious,
//  showTimerDialog,
//  startPausedTimer,
//  startTimer,
//  pauseTimer,
//  int counter,
//  index,
//  isReps,
//  listLenght,
//  reps,
//  sets,
//  timePaused,
//  String name,
//  video,
//  repsDescription,
//  exerciseTime,
//  workoutID,
//  weekID,
//  currentSet,
//  timeToDisplay,
//  bool isTips,
//  infoClicked,
//  goBackToChewie,
//  isFromPortrait,
//  noteClicked,
//  isPausedTimer,
//  VideoController controller,
//  List<dynamic> tips,
//  DocumentSnapshot userDocument,
//  userTrainerDocument,
//  Timer timer,
//) {
//  return Column(
//    children: <Widget>[
//      Stack(
//        alignment: Alignment.topRight,
//        children: <Widget>[
//          Row(
//            children: <Widget>[
//              clearIcon(
//                context,
//                onWill,
//              ),
//            ],
//          ),
//          InkWell(
//            onTap: () {
//              if (counter == 0) {
//                pauseAndPlayFunction();
//                isTips = false;
//                counter = 1;
//              }
//              Timer(Duration(seconds: 1), () {
//                counter = 0;
//              });
//            },
//            child: Container(
//              width: SizeConfig.blockSizeHorizontal * 83,
//              height: SizeConfig.blockSizeVertical * 20,
//            ),
//          )
//        ],
//      ),
//      Column(children: <Widget>[
//        Container(
//          margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical * 22),
//          child: MarqueeWidget(
//            child: nameWidget(
//              infoClicked,
//              goBackToChewie,
//              isFromPortrait,
//              context,
//              controller,
//              name,
//              video,
//              tips,
//              isReps,
//              index,
//              listLenght,
//            ),
//          ),
//        ),
//        Container(
//          padding: EdgeInsets.all(3),
//          child: Text(
//            reps,
//            style: TextStyle(
//              color: MyColors().lightWhite,
//              fontSize: SizeConfig.safeBlockHorizontal * 4,
//              fontWeight: FontWeight.w500,
//            ),
//          ),
//        ),
//      ]),
//      Container(
//        margin: EdgeInsets.only(
//            top: repsDescription != null && repsDescription != ''
//                ? SizeConfig.blockSizeVertical * 6
//                : SizeConfig.blockSizeVertical * 9),
//        child: Column(
//          children: <Widget>[
//            repsDescription != null && repsDescription != ''
//                ? Container(
//                    decoration: BoxDecoration(
//                      borderRadius: BorderRadius.only(
//                          topRight: Radius.circular(5.0),
//                          topLeft: Radius.circular(5.0)),
//                      color: Colors.grey,
//                    ),
//                    width: SizeConfig.blockSizeHorizontal * 95,
//                    height: SizeConfig.blockSizeVertical * 5.5,
//                    child: Row(
//                      mainAxisAlignment: MainAxisAlignment.center,
//                      children: <Widget>[
//                        asManyReps(
//                          context,
//                          repsDescription,
//                        ),
//                      ],
//                    ),
//                  )
//                : EmptyContainer(),
//            Container(
//              width: SizeConfig.blockSizeHorizontal * 95,
//              height: SizeConfig.blockSizeVertical * 20,
//              decoration: BoxDecoration(
//                borderRadius: repsDescription != null && repsDescription != ''
//                    ? BorderRadius.only(
//                        bottomLeft: Radius.circular(5.0),
//                        bottomRight: Radius.circular(5.0),
//                      )
//                    : BorderRadius.all(Radius.circular(5.0)),
//                color: Colors.white,
//              ),
//              child: Column(
//                crossAxisAlignment: CrossAxisAlignment.center,
//                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                children: <Widget>[
//                  Container(
//                      height: SizeConfig.blockSizeVertical * 10,
//                      child: timerWidget(
//                        context,
//                        showTimerDialog,
//                        controller,
//                        timeToDisplay,
//                          timeToDisplay,
//                          timeToDisplay
//                      )),
//                  Container(
//                    width: SizeConfig.blockSizeHorizontal * 60,
//                    height: SizeConfig.blockSizeVertical * 5,
//                    child: RaisedButton(
//                      color: MyColors().lightBlack,
//                      child: Text(
//                        'start timer'.toUpperCase(),
//                        style: TextStyle(
//                            color: Colors.white,
//                            fontWeight: FontWeight.w600,
//                            fontSize: SizeConfig.safeBlockHorizontal * 4),
//                      ),
//                      onPressed: () => startTimer(),
//                    ),
//                  ),
//                  Container(
//                    alignment: Alignment.center,
//                    height: SizeConfig.blockSizeVertical * 5,
//                    child: FlatButton(
//                      onPressed: () => null,
import 'package:flutter/material.dart';

////                          showFancyCustomDialog(context),
//                      child: Text(
//                        'EDIT TIMER',
//                        style: TextStyle(
//                            color: MyColors().lightBlack.withOpacity(0.5)),
//                      ),
//                    ),
//                  ),
//                ],
//              ),
//            ),
//          ],
//        ),
//      ),
//      Align(
//        alignment: Alignment.bottomCenter,
//        child: Column(
//          mainAxisAlignment: MainAxisAlignment.end,
//          children: <Widget>[

//  Container(
//margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical * 2),
//   child: Row(
//mainAxisAlignment: MainAxisAlignment.center,
//children: <Widget>[
//setsWidget(
//context,
//currentSet,
//sets,
//isReps,
//),
//],
//)
//),

//            SizedBox(
//              height: SizeConfig.blockSizeVertical * 2,
//            ),
//            Row(
//              mainAxisAlignment: MainAxisAlignment.spaceBetween,
//              children: <Widget>[
//                index == 0
//                    ? SizedBox(
//                        width: SizeConfig.blockSizeHorizontal * 10,
//                      )
//                    : previousButton(
//                        context,
//                        playPrevious,
//                      ),
//                Container(
//                  child: Row(
//                    children: <Widget>[
//                      noteButton(
//                        context,
//                        noteClicked,
//                        isFromPortrait,
//                        controller,
//                        userDocument,
//                        userTrainerDocument,
//                        index,
//                        listLenght,
//                        isReps,
//                        sets,
//                        reps.toString(),
//                        name,
//                        workoutID,
//                        weekID,
//                      ),
//                      SizedBox(
//                        width: SizeConfig.blockSizeHorizontal * 3,
//                      ),
//                      infoIcon(
//                        infoClicked,
//                        goBackToChewie,
//                        isFromPortrait,
//                        context,
//                        controller,
//                        name,
//                        video,
//                        tips,
//                        isReps,
//                        index,
//                        listLenght,
//                      ),
//                    ],
//                  ),
//                ),
//                index == (listLenght - 1)
//                    ? SizedBox(
//                        width: SizeConfig.blockSizeHorizontal * 10,
//                      )
//                    : nextButton(context, playNext, controller, timer),
//              ],
//            ),
//          ],
//        ),
//      )
//    ],
//  );
//}
