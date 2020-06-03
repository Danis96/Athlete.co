import 'dart:async';

import 'package:attt/utils/colors.dart';
import 'package:attt/utils/globals.dart';
import 'package:attt/utils/size_config.dart';
import 'package:attt/view_model/chewieVideoViewModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CustomLabel extends StatefulWidget {
  final bool finishedWorkout;
  final DocumentSnapshot userDocument, userTrainerDocument;
  final String weekID, workoutID;
  CustomLabel(
      {Key key,
      this.finishedWorkout,
      this.userDocument,
      this.userTrainerDocument,
      this.weekID,
      this.workoutID})
      : super(key: key);

  @override
  _CustomLabelState createState() => _CustomLabelState();
}

class _CustomLabelState extends State<CustomLabel> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        setState(() {
          checked = !checked;
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
      child: Container(
        child: Text(
          'Mark workout as DONE',
          style: TextStyle(
            color: MyColors().white,
            fontSize: SizeConfig.blockSizeHorizontal * 5,
          ),
        ),
      ),
    );
  }
}
