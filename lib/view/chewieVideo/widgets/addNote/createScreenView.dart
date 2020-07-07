import 'package:attt/utils/colors.dart';
import 'package:attt/utils/globals.dart';
import 'package:attt/utils/size_config.dart';
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
  bool isOrientationFull;
  CreateScreenView({
    Key key,
    this.workoutID,
    this.weekID,
    this.userDocument,
    this.userTrainerDocument,
    this.isOrientationFull,
  }) : super(key: key);

  @override
  _CreateScreenViewState createState() => _CreateScreenViewState();
}

class _CreateScreenViewState extends State<CreateScreenView> {
  List<String> notes = [];
  String newNote;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      resizeToAvoidBottomPadding: false,
      resizeToAvoidBottomInset: false,
      backgroundColor: MyColors().lightBlack,
      appBar: new AppBar(
        backgroundColor: MyColors().lightBlack,
        leading: AppBarIcon(
          onWillPop: _onWillPop,
        ),
        title: appBarTitle(context),
      ),
      body: new WillPopScope(
        onWillPop: () => _onWillPop(),
        child: new Stack(
          children: <Widget>[
            NoteTextField(
              updateNewNote: updateNewNote,
              finishScreen: false,
            ),
            Container(
              margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical * 80),
              width: SizeConfig.blockSizeHorizontal * 100,
              alignment: Alignment.center,
              child: Container(
                width: SizeConfig.blockSizeHorizontal * 90,
                height: SizeConfig.blockSizeVertical * 5,
                child: DoneButton(
                  newNote: newNote,
                  notes: notes,
                  userUID: widget.userDocument.data['userUID'],
                  trainerID: widget.userTrainerDocument.data['trainerID'],
                  weekID: widget.weekID,
                  workoutID: widget.workoutID,
                  isOrientationFull: widget.isOrientationFull,
                ),
              ),
            ),
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
      newNote = note;
  }
}
