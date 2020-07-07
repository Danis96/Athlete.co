import 'dart:async';

import 'package:attt/utils/colors.dart';
import 'package:attt/utils/fullTrainingStopwatch/fullTrainingStopwatch.dart';
import 'package:attt/utils/globals.dart';
import 'package:attt/view/trainingPlan/pages/trainingPlan.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:video_box/video_box.dart';
import 'package:attt/utils/customScreenAnimation.dart';

class MyAlertDialog extends StatefulWidget {
  final String title, content, yes, no;
  final DocumentSnapshot userDocument, userTrainerDocument;
  final Function onExit, close, resetTimer;
  final VideoController vc;
  final int isReps;
  final bool ctrl;
  final Timer timer;

  MyAlertDialog({
    Key key,
    this.onExit,
    this.title,
    this.content,
    this.ctrl,
    this.yes,
    this.no,
    this.userDocument,
    this.userTrainerDocument,
    this.vc,
    this.close,
    this.isReps,
    this.resetTimer,
    this.timer,
  }) : super(key: key);

  @override
  _MyAlertDialogState createState() => _MyAlertDialogState();
}

class _MyAlertDialogState extends State<MyAlertDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: MyColors().lightBlack,
      title: Text(
        widget.title,
        style: TextStyle(color: MyColors().lightWhite),
      ),
      content: new Text(
        widget.content,
        style: TextStyle(color: MyColors().lightWhite),
      ),
      actions: <Widget>[
        new FlatButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: new Text(
            widget.no,
            style: TextStyle(color: MyColors().lightWhite),
          ),
        ),
        new FlatButton(
          onPressed: () {
            isTimeChoosed = false;
            userNotes = '';
            alertQuit = true;
            widget.timer != null
                ? widget.resetTimer()
                : print('Timer nije aktivan');
            FullTrainingStopwatch().stopStopwtach();
            FullTrainingStopwatch().resetStopwtach();
            Navigator.of(context).pushReplacement(CardAnimationTween(
              widget: TrainingPlan(
                userDocument: widget.userDocument,
                userTrainerDocument: widget.userTrainerDocument,
              ),
            ));
            onlineVideos = [];
            onlineCovers = [];
            exerciseSnapshots = [];
            widget.vc.dispose();
            widget.close();
          },
          child: new Text(
            widget.yes,
            style: TextStyle(color: MyColors().error),
          ),
        ),
      ],
    );
  }
}
