import 'package:attt/utils/colors.dart';
import 'package:attt/utils/emptyContainer.dart';
import 'package:attt/utils/globals.dart';
import 'package:attt/utils/size_config.dart';
import 'package:attt/view/workout/widgets/bottomStartButton.dart';
import 'package:attt/view/workout/widgets/info.dart';
import 'package:attt/view/workout/widgets/workoutList.dart';
import 'package:attt/view_model/workoutViewModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Workout extends StatefulWidget {
  final DocumentSnapshot userDocument, userTrainerDocument;
  final String trainerID;
  final String workoutName, workoutID, weekID, warmupDesc;

  Workout(
      {Key key,
      this.userDocument,
      this.userTrainerDocument,
      this.trainerID,
      this.workoutName,
      this.workoutID,
      this.weekID,
      this.warmupDesc})
      : super(key: key);

  @override
  _WorkoutState createState() => _WorkoutState();
}

class _WorkoutState extends State<Workout> {
  String _seriesName,
      _exerciseName,
      _exerciseVideo,
      _exerciseImage,
      _exerciseID;

  int _exerciseIsReps, _exerciseReps, _exerciseRest, _exerciseSets;

  List<dynamic> _series = [], _exercises = [], _exerciseTips = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  refreshFromInfo() {
    setState(() {
    });
    print('refreshed from info');
  }

  @override
  Widget build(BuildContext context) {
    
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        /// workout name
        title: Text(widget.workoutName.toUpperCase()),
        backgroundColor: MyColors().lightBlack,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.clear,
            color: MyColors().white,
          ),
          onPressed: () => WorkoutViewModel().xBack(context),
          iconSize: 30.0,
        ),
      ),
      bottomNavigationBar: isInfo ? InfoExercise(exerciseTips: exerciseTipsforView,refreshParent: refreshFromInfo) : bottomButtonStart(
          widget.userDocument, widget.userTrainerDocument, context),
      backgroundColor: Colors.transparent,
      body: ListView(
        shrinkWrap: true,
        children: <Widget>[
          /// workoutList
          workoutList(
            widget.trainerID,
            _seriesName,
            _series,
            _exercises,
            _exerciseName,
            _exerciseTips,
            _exerciseVideo,
            _exerciseImage,
            _exerciseIsReps,
            _exerciseReps,
            _exerciseRest,
            _exerciseSets,
            widget.weekID,
            widget.workoutID,
            widget.warmupDesc,
            _exerciseID,
            refreshFromInfo,
          ),
        ],
      ),
    );
  }
}
