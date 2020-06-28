import 'package:attt/utils/colors.dart';
import 'package:attt/utils/globals.dart';
import 'package:attt/view/chewieVideo/widgets/addNote/appBarIcon.dart';
import 'package:attt/view/chewieVideo/widgets/addNote/doneButton.dart';
import 'package:attt/view/chewieVideo/widgets/addNote/noteTextField.dart';
import 'package:attt/view_model/chewieVideoViewModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'appBarTitle.dart';

class CreateScreenView extends StatefulWidget {
  final DocumentSnapshot userDocument, userTrainerDocument;
  final String weekID, workoutID;
  CreateScreenView(
      {Key key,
      this.workoutID,
      this.weekID,
      this.userDocument,
      this.userTrainerDocument})
      : super(key: key);

  @override
  _CreateScreenViewState createState() => _CreateScreenViewState();
}

class _CreateScreenViewState extends State<CreateScreenView> {
  List<String> notes = [];
  String newNote;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        backgroundColor: MyColors().lightBlack,
        leading: AppBarIcon(
          onWillPop: _onWillPop,
        ),
        title: appBarTitle(context),
      ),
      body: new WillPopScope(
        onWillPop: () => _onWillPop(),
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            NoteTextField(
              updateNewNote: updateNewNote,
              finishScreen: false,
            ),
            DoneButton(
                newNote: newNote,
                notes: notes,
                userUID: widget.userDocument.data['userUID'],
                trainerID: widget.userTrainerDocument.data['trainerID'],
                weekID: widget.weekID,
                workoutID: widget.workoutID),
          ],
        ),
      ),
    );
  }

  Future<bool> _onWillPop() async {
    FocusScope.of(context).requestFocus(new FocusNode());
    Navigator.of(context).pop();
    ChewieVideoViewModel().checkForOrientationOnBack();
      noteClicked = true;
  }

  updateNewNote(String note) {
    setState(() {
      newNote = note;
    });
  }
}