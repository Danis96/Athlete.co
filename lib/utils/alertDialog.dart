
import 'package:attt/view/trainingPlan/pages/trainingPlan.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MyAlertDialog extends StatelessWidget {
  final String title, content, yes, no;
  final DocumentSnapshot userDocument, userTrainerDocument;
  MyAlertDialog(
      {Key key, this.title, this.content, this.yes, this.no, this.userDocument, this.userTrainerDocument })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: new Text(content),
      actions: <Widget>[
        new FlatButton(
          onPressed: () => Navigator.pop(context),
          child: new Text(no),
        ),
        new FlatButton(
          onPressed: () => Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (_) => TrainingPlan(
                  userDocument: userDocument,
                  userTrainerDocument: userTrainerDocument,
                ),
              ),
              (Route<dynamic> route) => false) ,
          child: new Text(yes),
        ),
      ],
    );
  }
}