import 'package:attt/utils/colors.dart';
import 'package:attt/utils/size_config.dart';
import 'package:attt/view/workout/widgets/bottomStartButton.dart';
import 'package:attt/view/workout/widgets/warmUp.dart';
import 'package:attt/view/workout/widgets/workoutList.dart';
import 'package:attt/view_model/workoutViewModel.dart';
import 'package:flutter/material.dart';

class Workout extends StatelessWidget {
  final String trainerID;
  final String workoutName, workoutID, weekID, warmupDesc;
  Workout(
      {Key key,
      this.trainerID,
      this.workoutName,
      this.workoutID,
      this.weekID,
      this.warmupDesc})
      : super(key: key);

  String _seriesName,
      _exerciseName,
      _exerciseTips,
      _exerciseVideo,
      _exerciseImage;
  int _exerciseIsReps, _exerciseReps, _exerciseRest, _exerciseSets;

  List<dynamic> _series = [], _exercises = [];

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        /// workout name
        title: Text(workoutName.toUpperCase()),
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
      bottomNavigationBar: bottomButtonStart(context),
      backgroundColor: MyColors().lightBlack,
      body: ListView(
        shrinkWrap: true,
        children: <Widget>[
          /// warmup
          warmupWidget(context, trainerID, workoutID, weekID, warmupDesc),

          /// workoutList
          workoutList(
            trainerID,
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
            weekID,
            workoutID,
          ),
        ],
      ),
    );
  }
}
