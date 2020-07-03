import 'dart:async';

import 'package:attt/utils/globals.dart';
import 'package:attt/utils/size_config.dart';
import 'package:attt/view_model/chewieVideoViewModel.dart';
import 'package:flutter/material.dart';

class DoneButton extends StatefulWidget {
  final String newNote, userUID, trainerID, weekID, workoutID;
  final List<dynamic> notes;
  bool isOrientationFull;
  DoneButton({
    Key key,
    this.newNote,
    this.notes,
    this.trainerID,
    this.userUID,
    this.weekID,
    this.workoutID,
    this.isOrientationFull,
  }) : super(key: key);

  @override
  _DoneButtonState createState() => _DoneButtonState();
}

class _DoneButtonState extends State<DoneButton> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return new Container(
      width: MediaQuery.of(context).size.width,
      child: new RaisedButton(
        elevation: 0,
        onPressed: () {
          FocusScope.of(context).requestFocus(FocusNode());
          Timer(Duration(milliseconds: 500), () {
            ChewieVideoViewModel().donePressed(
                widget.newNote,
                widget.notes,
                widget.userUID,
                widget.trainerID,
                widget.weekID,
                widget.workoutID,
                context);
            noteClicked = true;
            widget.isOrientationFull = true;
          });
        },
        child: new Text(
          'DONE',
          style: new TextStyle(
              fontStyle: FontStyle.italic,
              fontSize:
                  MediaQuery.of(context).orientation == Orientation.portrait
                      ? SizeConfig.safeBlockHorizontal * 4
                      : SizeConfig.safeBlockHorizontal * 2.5,
              fontWeight: FontWeight.w700),
        ),
        color: Colors.white,
      ),
    );
  }
}
