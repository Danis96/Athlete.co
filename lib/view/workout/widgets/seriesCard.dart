import 'package:attt/models/exerciseModel.dart';
import 'package:attt/utils/colors.dart';
import 'package:attt/utils/size_config.dart';
import 'package:attt/view/workout/widgets/exerciseCard.dart';
import 'package:attt/view_model/workoutViewModel.dart';
import 'package:flutter/material.dart';

Widget seriesCard(
  BuildContext context,
  String _seriesName,
  String trainerID,
  List<dynamic> _exercises,
  String _exerciseName,
  String _exerciseTips,
  String _exerciseVideo,
  String _exerciseImage,
  int _exerciseIsReps,
  int _exerciseReps,
  int _exerciseRest,
  int _exerciseSets,
  String weekID,
  String workoutID,
  String seriesID,
) {
  SizeConfig().init(context);
  return Container(
    margin: EdgeInsets.only(bottom: SizeConfig.blockSizeVertical * 5),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(10.0),
          margin: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal * 2),
          child: Text(_seriesName,
              style: TextStyle(
                  color: MyColors().white,
                  fontSize: SizeConfig.blockSizeHorizontal * 5)),
        ),
        FutureBuilder(
            future: WorkoutViewModel().getExercises(trainerID, weekID, workoutID, seriesID),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                _exercises = snapshot.data
                    .map((doc) => Exercise.fromDocument(doc))
                    .toList();

                return ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: _exercises.length,
                    itemBuilder: (BuildContext context, int index) {
                      _exerciseName = _exercises[index].name;
                      _exerciseImage = _exercises[index].image;
                      _exerciseIsReps = _exercises[index].isReps;
                      _exerciseReps = _exercises[index].reps;
                      _exerciseRest = _exercises[index].rest;
                      _exerciseSets = _exercises[index].sets;
                      _exerciseTips = _exercises[index].tips;
                      _exerciseVideo = _exercises[index].video;

                      return exerciseCard(
                          _exerciseName,
                          _exerciseTips,
                          _exerciseVideo,
                          _exerciseImage,
                          _exerciseIsReps,
                          _exerciseReps,
                          _exerciseRest,
                          _exerciseSets);
                    });
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            })
      ],
    ),
  );
}