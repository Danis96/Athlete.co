import 'package:attt/utils/alertDialog.dart';
import 'package:attt/utils/colors.dart';
import 'package:attt/utils/fullTrainingStopwatch/fullTrainingStopwatch.dart';
import 'package:attt/utils/globals.dart';
import 'package:attt/utils/size_config.dart';
import 'package:attt/view/trainingPlan/widgets/socialMediaDialog.dart';
import 'package:attt/view_model/chewieVideoViewModel.dart';
import 'package:attt/view_model/signInViewModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:attt/view/trainingPlan/pages/trainingPlan.dart';
import 'package:intl/intl.dart';

class FinishWorkout extends StatefulWidget {
  final DocumentSnapshot userDocument, userTrainerDocument;
  final String workoutID, weekID;
  final Function close;
  final bool finishedWorkout;
  FinishWorkout({
    Key key,
    this.weekID,
    this.close,
    this.finishedWorkout,
    this.workoutID,
    this.userDocument,
    this.userTrainerDocument,
  }) : super(key: key);

  @override
  _FinishWorkoutState createState() => _FinishWorkoutState();
}

class _FinishWorkoutState extends State<FinishWorkout> {
  List<String> notes = [];
  String newNote;
  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: MyColors().lightBlack,
      resizeToAvoidBottomPadding: false,
      appBar: new AppBar(
        backgroundColor: MyColors().lightBlack,
        leading: IconButton(
          icon: Icon(
            Icons.clear,
            size: SizeConfig.blockSizeHorizontal * 8,
          ),
          onPressed: () {
            FocusScope.of(context).requestFocus(new FocusNode());
            _onWillPop();
          },
        ),
        title: Text(
          'WORKOUT COMPLETED',
          style: TextStyle(
            fontSize: SizeConfig.blockSizeHorizontal * 5,
          ),
        ),
      ),
      body: WillPopScope(
        onWillPop: () => _onWillPop(),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(new FocusNode());
          },
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: <Widget>[
                Container(
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: SizeConfig.blockSizeVertical * 4,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        child: Text(
                          displayTime,
                          style: TextStyle(
                            color: Colors.white,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.bold,
                            fontSize: SizeConfig.blockSizeHorizontal * 20,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(
                        height: SizeConfig.blockSizeVertical * 1,
                      ),
                      Text(
                        'Workout Time',
                        style: TextStyle(
                          color: Colors.white,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.bold,
                          fontSize: SizeConfig.blockSizeHorizontal * 7,
                        ),
                      ),
                      SizedBox(
                        height: SizeConfig.blockSizeVertical * 4,
                      ),
                    ],
                  ),
                ),
                new TextFormField(
                  enableInteractiveSelection: false,
                  onChanged: (input) {
                    newNote = input;
                  },
                  initialValue: userNotes,
                  autofocus: false,
                  enableSuggestions: false,
                  minLines: 1,
                  maxLines: 12,
                  autocorrect: false,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: SizeConfig.safeBlockHorizontal * 4.5,
                  ),
                  cursorColor: Colors.white60,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(
                      vertical: SizeConfig.blockSizeVertical * 2.5,
                    ),
                    labelStyle: TextStyle(
                      color: Colors.white60,
                      fontSize: SizeConfig.safeBlockHorizontal * 4.5,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Roboto',
                      fontStyle: FontStyle.italic,
                    ),
                    labelText: 'Add a note',
                    filled: true,
                    fillColor: MyColors().black,
                    prefixIcon: Icon(
                      Icons.edit,
                      color: MyColors().white,
                    ),
                  ),
                ),
                SizedBox(
                  height: SizeConfig.blockSizeVertical * 4,
                ),
                TextFormField(
                  onTap: () => showSocialMediaDialog(context),
                  readOnly: true,
                  enableInteractiveSelection: false,
                  initialValue: 'ANY QUESTIONS FEEL FREE TO ASK',
                  autofocus: false,
                  enableSuggestions: false,
                  maxLines: 1,
                  autocorrect: false,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: SizeConfig.safeBlockHorizontal * 4.5,
                  ),
                  cursorColor: Colors.white60,
                  decoration: InputDecoration(
                    enabled: false,
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(
                      vertical: SizeConfig.blockSizeVertical * 3,
                    ),
                    filled: true,
                    fillColor: MyColors().black,
                    prefixIcon: Icon(
                      Icons.mail,
                      color: MyColors().white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        width: MediaQuery.of(context).size.width,
        child: RaisedButton(
          elevation: 0,
          onPressed: () async {
            String currentTime = DateTime.now().toString();
            String note;
            String historyNote;
            List<dynamic> historyNotes = [];
            if (newNote != null) {
              note = widget.userDocument.data['userUID'] + '_!_?_' + newNote;
              notes.add(note);
              userNotes = note.split('_!_?_')[1];
              ChewieVideoViewModel().updateWorkoutWithNote(
                widget.userTrainerDocument.data['trainerID'],
                widget.weekID,
                widget.workoutID,
                notes,
              );
            } else {
              newNote = userNotes;
            }
            note = widget.userDocument.data['userUID'] +
                '_!_?_' +
                newNote +
                '_!_?_' +
                currentTime;
            historyNotes.add(note);
            ChewieVideoViewModel().updateWorkoutHistoryNote(
              widget.userTrainerDocument.data['trainerID'],
              widget.weekID,
              widget.workoutID,
              historyNotes,
            );
            updateUserWithFinishedWorkout(
              widget.userDocument,
              widget.userTrainerDocument.data['trainerID'],
              widget.weekID,
              widget.workoutID,
              currentTime,
              widget.finishedWorkout,
            );
            List<dynamic> currentUserDocuments = [];
            DocumentSnapshot currentUserDocument;
            currentUserDocuments = await SignInViewModel()
                .getCurrentUserDocument(widget.userDocument.data['userUID']);
            currentUserDocument = currentUserDocuments[0];
            FocusScope.of(context).requestFocus(new FocusNode());
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (_) => TrainingPlan(
                    userDocument: currentUserDocument,
                    userTrainerDocument: widget.userTrainerDocument,
                    userUID: currentUserDocument.data['userUID'],
                  ),
                ),
                (Route<dynamic> route) => false);
            userNotes = '';
            await Future.delayed(
              Duration(seconds: 1),
              () {
                FullTrainingStopwatch().resetStopwtach();
              },
            );
          },
          child: Padding(
            padding: EdgeInsets.all(22.0),
            child: Text(
              'FINISH',
              style: TextStyle(
                fontStyle: FontStyle.italic,
                fontSize: SizeConfig.blockSizeHorizontal * 4,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          color: Colors.white,
        ),
      ),
    );
  }

  updateUserWithFinishedWorkout(
    DocumentSnapshot userDocument,
    String trainerID,
    String weekID,
    String workoutID,
    String currentTime,
    bool finishedWorkout,
  ) async {
    List<String> note = [];
    String currentDay = DateFormat.d().format(DateTime.now());
    String currentMonth = DateFormat.MMM().format(DateTime.now()).toUpperCase();
    note.add(trainerID +
        '_' +
        weekID +
        '_' +
        workoutID +
        '_' +
        currentDay +
        ' ' +
        currentMonth +
        '_' +
        currentTime);
    final db = Firestore.instance;

    !finishedWorkout
        ? await db
            .collection('Users')
            .document(userDocument.documentID)
            .updateData({"workouts_finished": FieldValue.arrayUnion(note)})
        : print('WORKOUT ALREADY FINISHED');

    await db
        .collection('Users')
        .document(userDocument.documentID)
        .updateData({"workouts_finished_history": FieldValue.arrayUnion(note)});
  }

  Future<bool> _onWillPop() async {
    return showDialog(
          context: context,
          builder: (context) => MyAlertDialog(
              no: 'Cancel',
              yes: 'Continue',
              title: 'Back to Training plan?',
              content: 'If you go back all your progress will be lost',
              userDocument: widget.userDocument,
              userTrainerDocument: widget.userTrainerDocument,
              close: widget.close,
              ctrl: true),
        ) ??
        true;
  }
}
