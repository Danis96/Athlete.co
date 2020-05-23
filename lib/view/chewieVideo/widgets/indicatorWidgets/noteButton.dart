import 'package:attt/utils/size_config.dart';
import 'package:attt/view/chewieVideo/widgets/addNote.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:video_box/video.controller.dart';

Widget noteButton(BuildContext context, bool noteClicked, isFromPortrait,
    VideoController controller, Function checkIsOnTimeAndPauseTimer,
    DocumentSnapshot userDocument, userTrainerDocument,
    int index, listLenght,isReps, sets, reps,
    String name, workoutID, weekID
    ) {
  return Container(
    margin: EdgeInsets.only(
        top: MediaQuery.of(context).orientation == Orientation.landscape
            ? SizeConfig.blockSizeVertical * 6
            : SizeConfig.blockSizeVertical * 0),
    child: IconButton(
        color: Colors.white,
        iconSize: MediaQuery.of(context).orientation == Orientation.landscape
            ? SizeConfig.blockSizeHorizontal * 4.5
            : SizeConfig.blockSizeHorizontal * 7.5,
        icon: Icon(Icons.comment),
        onPressed: () {
          if (noteClicked) {
            checkIsOnTimeAndPauseTimer();
            noteClicked = false;
            controller.pause();
            if (MediaQuery.of(context).orientation == Orientation.portrait)
              isFromPortrait = true;
            else
              isFromPortrait = false;
            Navigator.of(context).push(
              MaterialPageRoute(
                maintainState: true,
                builder: (_) => AddNote(
                    controller: controller,
                    listLenght: listLenght,
                    userDocument:userDocument,
                    userTrainerDocument: userTrainerDocument,
                    index: index,
                    isReps: isReps,
                    reps: reps,
                    sets: sets,
                    name:name,
                    workoutID: workoutID,
                    weekID: weekID),
              ),
            );
          } else {
            print('NE MOZE VIŠE PAŠA 2');
          }
        }),
  );
}
