import 'package:attt/utils/colors.dart';
import 'package:attt/utils/globals.dart';
import 'package:attt/view/trainingPlan/pages/trainingPlan.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MyAlertDialog extends StatelessWidget {
  final String title, content, yes, no;
  final DocumentSnapshot userDocument, userTrainerDocument;
  final Function onExit;

  MyAlertDialog({
    Key key,
    this.onExit,
    this.title,
    this.content,
    this.yes,
    this.no,
    this.userDocument,
    this.userTrainerDocument,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: MyColors().lightBlack,
      title: Text(
        title,
        style: TextStyle(color: MyColors().lightWhite),
      ),
      content: new Text(
        content,
        style: TextStyle(color: MyColors().lightWhite),
      ),
      actions: <Widget>[
        new FlatButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: new Text(
            no,
            style: TextStyle(color: MyColors().lightWhite),
          ),
        ),
        new FlatButton(
          onPressed: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                maintainState: false,
                builder: (_) => TrainingPlan(
                  userDocument: userDocument,
                  userTrainerDocument: userTrainerDocument,
                ),
              ),
            );
            isReady = false;
            onlineVideos = [];
            exerciseSnapshots = [];
          },
          child: new Text(
            yes,
            style: TextStyle(color: MyColors().error),
          ),
        ),
      ],
    );
  }
}
