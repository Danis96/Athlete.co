import 'dart:async';

import 'package:attt/utils/globals.dart';
import 'package:attt/view_model/chewieVideoViewModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CustomCheckbox extends StatefulWidget {
  final bool finishedWorkout;
  final DocumentSnapshot userDocument, userTrainerDocument;
  final String weekID, workoutID;
  CustomCheckbox(
      {Key key,
      this.finishedWorkout,
      this.userDocument,
      this.userTrainerDocument,
      this.workoutID,
      this.weekID})
      : super(key: key);

  @override
  _CustomCheckboxState createState() => _CustomCheckboxState();
}

class _CustomCheckboxState extends State<CustomCheckbox> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Transform.scale(
        scale: 1.25,
        child: Theme(
          data: Theme.of(context).copyWith(
            unselectedWidgetColor: Colors.white,
          ),
          child: Checkbox(
            checkColor: Colors.black,
            activeColor: Colors.white,
            value: checked ? checked : widget.finishedWorkout,
            onChanged: (bool value) {
              setState(() {
                checked = value;
              });
              Timer(Duration(milliseconds: 100), () {
                ChewieVideoViewModel().finishPressed(
                    context,
                    null,
                    widget.userDocument,
                    widget.userTrainerDocument,
                    widget.weekID,
                    widget.workoutID,
                    [],
                    widget.finishedWorkout);
              });
            },
          ),
        ),
      ),
    );
  }
}
