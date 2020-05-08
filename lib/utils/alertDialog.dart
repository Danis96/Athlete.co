import 'package:attt/utils/colors.dart';
import 'package:attt/utils/globals.dart';
import 'package:attt/view/trainingPlan/pages/trainingPlan.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:video_box/video_box.dart';
import 'package:attt/utils/customScreenAnimation.dart';

import 'package:flutter/services.dart';

class MyAlertDialog extends StatefulWidget {
  final String title, content, yes, no;
  final DocumentSnapshot userDocument, userTrainerDocument;
  final Function onExit, close;
  final VideoController vc;

  MyAlertDialog({
    Key key,
    this.onExit,
    this.title,
    this.content,
    this.yes,
    this.no,
    this.userDocument,
    this.userTrainerDocument,
    this.vc,
    this.close,
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
            widget.vc.play();
            Navigator.pop(context);
          },
          child: new Text(
            widget.no,
            style: TextStyle(color: MyColors().lightWhite),
          ),
        ),
        new FlatButton(
          onPressed: () {
            widget.vc.pause();
            alertQuit = true;
            Navigator.of(context).pushReplacement(CardAnimationTween(
              widget: TrainingPlan(
                userDocument: widget.userDocument,
                userTrainerDocument: widget.userTrainerDocument,
              ),
            ));
            isReady = false;
            onlineVideos = [];
            exerciseSnapshots = [];
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
