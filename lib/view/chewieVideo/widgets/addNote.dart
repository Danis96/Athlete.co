import 'package:attt/utils/size_config.dart';
import 'package:attt/view/chewieVideo/widgets/addNote/createScreenView.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_box/video.controller.dart';

class AddNote extends StatefulWidget {
  final VideoController controller;
  final DocumentSnapshot userDocument, userTrainerDocument;
  final int index, listLenght;
  final int isReps, sets;
  final String name, reps;
  final String workoutID, weekID;
  bool isOrientationFull;
  AddNote({
    Key key,
    this.weekID,
    this.workoutID,
    this.controller,
    this.userDocument,
    this.userTrainerDocument,
    this.index,
    this.listLenght,
    this.isReps,
    this.sets,
    this.name,
    this.reps,
    this.isOrientationFull,
  }) : super(key: key);

  @override
  _AddNoteState createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  Widget _screenView;

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    if (_screenView == null) {
      _screenView = CreateScreenView(
        workoutID: widget.workoutID,
        weekID: widget.weekID,
        userDocument: widget.userDocument,
        userTrainerDocument: widget.userTrainerDocument,
        isOrientationFull: widget.isOrientationFull,
      );
    }
    return _screenView;
  }
}
