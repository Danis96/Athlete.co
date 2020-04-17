import 'package:attt/models/seriesModel.dart';
import 'package:attt/utils/colors.dart';
import 'package:attt/utils/size_config.dart';
import 'package:attt/view/workout/widgets/seriesCard.dart';
import 'package:attt/view_model/workoutViewModel.dart';
import 'package:flutter/material.dart';

Widget workoutList(
  String trainerName,
  String _seriesName,
  List<dynamic> _series,
  List<dynamic> _exercises,
  String _exerciseName,
  String _exerciseTips,
  String _exerciseVideo,
  String _exerciseImage,
  int _exerciseIsReps,
  int _exerciseReps,
  int _exerciseRest,
  int _exerciseSets,
) {
  return Container(
    margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical * 5),
    color: MyColors().black,
    child: FutureBuilder(
        future: WorkoutViewModel().getSeries(trainerName),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            _series =
                snapshot.data.map((doc) => Series.fromDocument(doc)).toList();

            return ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: _series.length,
                itemBuilder: (BuildContext context, int index) {
                  _seriesName = _series[index].name;
                  return seriesCard(
                      context,
                      _seriesName,
                      trainerName,
                      _exercises,
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
        }),
  );
}