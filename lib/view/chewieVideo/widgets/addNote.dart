import 'package:attt/utils/colors.dart';
import 'package:attt/utils/globals.dart';
import 'package:attt/utils/size_config.dart';
import 'package:attt/view_model/chewieVideoViewModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_box/video.controller.dart';

class AddNote extends StatefulWidget {
  bool timerPaused;
  final VideoController controller;
  final DocumentSnapshot userDocument, userTrainerDocument;
  final int index, listLenght;
  final int duration;
  final Function showRest, showAddNote;
  final int isReps, sets, reps;
  final String name;
  final String workoutID, weekID;
  AddNote(
      {Key key,
      this.timerPaused,
      this.weekID,
      this.workoutID,
      this.controller,
      this.userDocument,
      this.userTrainerDocument,
      this.index,
      this.listLenght,
      this.duration,
      this.showAddNote,
      this.showRest,
      this.isReps,
      this.sets,
      this.name,
      this.reps})
      : super(key: key);

  @override
  _AddNoteState createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  List<String> notes = [];
  String newNote;
  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  }

  Widget _screenView;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    if (_screenView == null) {
      _screenView = _createScreenView(context);
    }
    return _screenView;
  }

  Widget _createScreenView(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        backgroundColor: MyColors().lightBlack,
        leading: new IconButton(
          icon: new Icon(
            Icons.clear,
            size: MediaQuery.of(context).orientation == Orientation.portrait
                ? SizeConfig.blockSizeHorizontal * 5.5
                : SizeConfig.blockSizeHorizontal * 3,
          ),
          onPressed: () {
            FocusScope.of(context).requestFocus(new FocusNode());
            setState(() {
              noteClicked = true;
            });
            Navigator.of(context).pop();
            checkForOrientationOnBack();
          },
        ),
        title: new Text(
          'ADD NOTE',
          style: new TextStyle(
            fontSize: MediaQuery.of(context).orientation == Orientation.portrait
                ? SizeConfig.blockSizeHorizontal * 5
                : SizeConfig.blockSizeHorizontal * 2.5,
          ),
        ),
      ),
      body: new WillPopScope(
        onWillPop: () => _onWillPop(),
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            new Expanded(
              child: new Material(
                color: MyColors().lightBlack,
                child: new TextFormField(
                  enableInteractiveSelection: false,
                  onChanged: (input) {
                    newNote = input;
                  },
                  initialValue: userNotes,
                  autofocus: false,
                  enableSuggestions: false,
                  maxLines: null,
                  autocorrect: false,
                  style: new TextStyle(
                    color: Colors.white,
                    fontSize:MediaQuery.of(context).orientation ==
                        Orientation.portrait
                        ? SizeConfig.safeBlockHorizontal * 4.5
                        : SizeConfig.safeBlockHorizontal * 2.5,
                  ),
                  cursorColor: Colors.white60,
                  decoration: new InputDecoration(
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(
                        vertical: SizeConfig.blockSizeVertical * 2.5),
                    labelStyle: new TextStyle(
                      color: Colors.white60,
                      fontSize: MediaQuery.of(context).orientation ==
                              Orientation.portrait
                          ? SizeConfig.safeBlockHorizontal * 4.5
                          : SizeConfig.safeBlockHorizontal * 2.5,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Roboto',
                      fontStyle: FontStyle.italic,
                    ),
                    labelText: 'Add a note',
                    filled: true,
                    fillColor: MyColors().black,
                    prefixIcon: new Icon(
                      Icons.edit,
                      color: MyColors().white,
                    ),
                  ),
                ),
              ),
            ),
            new Container(
              width: MediaQuery.of(context).size.width,
              child: new RaisedButton(
                elevation: 0,
                onPressed: () {
                  String note;
                  if (newNote != null) {
                    note =
                        widget.userDocument.data['userUID'] + '_!_?_' + newNote;
                    notes.add(note);
                    userNotes = note.split('_!_?_')[1];
                    ChewieVideoViewModel().updateWorkoutWithNote(
                        widget.userTrainerDocument.data['trainerID'],
                        widget.weekID,
                        widget.workoutID,
                        notes);
                  }
                  FocusScope.of(context).requestFocus(new FocusNode());
                  setState(() {
                    widget.timerPaused = false;
                    noteClicked = true;
                  });
                  Navigator.of(context).pop();
                  checkForOrientationOnBack();
                },
                child: new Padding(
                  padding:  EdgeInsets.all(22.0),
                  child: new Text(
                    'DONE',
                    style: new TextStyle(
                        fontStyle: FontStyle.italic,
                        fontSize: MediaQuery.of(context).orientation ==
                            Orientation.portrait
                            ? SizeConfig.safeBlockHorizontal * 4
                            : SizeConfig.safeBlockHorizontal * 2.5,
                        fontWeight: FontWeight.w700),
                  ),
                ),
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<bool> _onWillPop() async {
    FocusScope.of(context).requestFocus(new FocusNode());
    setState(() {
      noteClicked = true;
    });
    Navigator.of(context).pop();
    checkForOrientationOnBack();
  }
}

checkForOrientationOnBack() {
  isFromPortrait
      ? SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      : SystemChrome.setPreferredOrientations(
          [DeviceOrientation.landscapeRight]);
}
