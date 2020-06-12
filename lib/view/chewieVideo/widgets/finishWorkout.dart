import 'package:attt/utils/alertDialog.dart';
import 'package:attt/utils/colors.dart';
import 'package:attt/utils/globals.dart';
import 'package:attt/utils/size_config.dart';
import 'package:attt/view/chewieVideo/widgets/addNote/noteTextField.dart';
import 'package:attt/view/chewieVideo/widgets/finishWorkout/anyQuestionContainer.dart';
import 'package:attt/view/chewieVideo/widgets/finishWorkout/finishWorkoutButton.dart';
import 'package:attt/view/chewieVideo/widgets/finishWorkout/iconAppBar.dart';
import 'package:attt/view/chewieVideo/widgets/finishWorkout/timerWidgets.dart';
import 'package:attt/view/chewieVideo/widgets/finishWorkout/titleAppBar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
    return GestureDetector(
      onTap: () {
        setState(() {
          focused = false;
        });
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: Scaffold(
        backgroundColor: MyColors().lightBlack,
        resizeToAvoidBottomPadding: false,
        appBar: new AppBar(
          backgroundColor: MyColors().lightBlack,
          leading: IconAppBar(
            onWillPop: _onWillPop,
          ),
          title: titleAppBar(),
        ),
        body: WillPopScope(
          onWillPop: () => _onWillPop(),
          child: GestureDetector(
            onTap: () {
              setState(() {
                focused = false;
              });
              FocusScope.of(context).requestFocus(new FocusNode());
            },
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Column(
                children: <Widget>[
                  timerWidgets(context, displayTime),
                  NoteTextField(
                    updateNewNote: updateNewNote,
                    finishScreen: true,
                  ),
                  SizedBox(
                    height: SizeConfig.blockSizeVertical * 1.5,
                  ),
                  AnyQuestionContainer(
                      userName: widget.userDocument.data['display_name']),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: finishWorkoutButton(
            context,
            notes,
            newNote,
            widget.userDocument,
            widget.userTrainerDocument,
            widget.weekID,
            widget.workoutID,
            widget.finishedWorkout),
      ),
    );
  }

  updateNewNote(String note) {
    setState(() {
      newNote = note;
    });
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
