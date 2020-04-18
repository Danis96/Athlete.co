import 'package:attt/utils/colors.dart';
import 'package:attt/utils/size_config.dart';
import 'package:attt/view/workout/widgets/warmUp.dart';
import 'package:attt/view/workout/widgets/workoutList.dart';
import 'package:flutter/material.dart';

class Workout extends StatelessWidget {
  final String trainerID;
  final String workoutName;

  final String workoutID, weekID;
  Workout({Key key, this.trainerID, this.workoutName, this.workoutID, this.weekID}) : super(key: key);

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
        title: Text('Workout 1'.toUpperCase()),
        backgroundColor: MyColors().lightBlack,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.clear,
            color: MyColors().white,
          ),
          onPressed: null,
          iconSize: 30.0,
        ),
      ),
      backgroundColor: MyColors().lightBlack,
      body: ListView(
        shrinkWrap: true,
        children: <Widget>[
          /// warmup
          warmup(context),

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
