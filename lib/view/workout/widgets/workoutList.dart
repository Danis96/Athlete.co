import 'package:attt/models/seriesModel.dart';
import 'package:attt/utils/colors.dart';
import 'package:attt/view/workout/widgets/seriesCard.dart';
import 'package:attt/view/workout/widgets/warmupContainer.dart';
import 'package:attt/view_model/workoutViewModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

String seriesID;

Widget workoutList(
  String trainerID,
  String _trainerName,
  String _weekName,
  String _workoutName,
  String _seriesName,
  List<dynamic> _series,
  List<dynamic> _exercises,
  String _exerciseName,
  List<dynamic> _exerciseTips,
  String _exerciseVideo,
  String _exerciseImage,
  int _exerciseIsReps,
  int _exerciseReps,
  int _exerciseRest,
  int _exerciseSets,
  String weekID,
  String workoutID,
  String warmupDesc,
  String _exerciseID,
  Function refreshFromInfo,
    Source source,
) {



  return Container(
    color: MyColors().black,
    child: FutureBuilder(
        future: WorkoutViewModel().getSeries(trainerID, weekID, workoutID, source),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            _series =
                snapshot.data.map((doc) => Series.fromDocument(doc)).toList();
            return ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: _series.length,
                itemBuilder: (BuildContext context, int index) {
                  seriesID = _series[index].seriesID;
                  _seriesName = _series[index].name;

                  //if (_seriesName == 'Warm Up') {
                    return WarmupContainer(
                      trainerName: _trainerName,
                      weekName: _weekName,
                      workoutName: _workoutName,
                      seriesName: _seriesName,
                      warmupDesc: warmupDesc,
                      trainerID: trainerID,
                      weekID: weekID,
                      workoutID: workoutID,
                      seriesID: seriesID,
                      image: snapshot.data[index].data['image'],
                      isReps: snapshot.data[index].data['isReps'],
                      name: snapshot.data[index].data['name'],
                      reps: snapshot.data[index].data['reps'],
                      rest: snapshot.data[index].data['rest'],
                      sets: snapshot.data[index].data['sets'],
                      tips: snapshot.data[index].data['tips'],
                      video: snapshot.data[index].data['video'],
                      source: source,
                    );
                  //} //else {
                  //   return SeriesCard(
                  //     trainerName: _trainerName,
                  //     weekName: _weekName,
                  //     workoutName: _workoutName,
                  //     seriesName: _seriesName,
                  //     context: context,
                  //     trainerID: trainerID,
                  //     exercises: _exercises,
                  //     exerciseName: _exerciseName,
                  //     exerciseTips: _exerciseTips,
                  //     exerciseVideo: _exerciseVideo,
                  //     exerciseImage: _exerciseImage,
                  //     exerciseIsReps: _exerciseIsReps,
                  //     exerciseReps: _exerciseReps,
                  //     exerciseRest: _exerciseRest,
                  //     exerciseSets: _exerciseSets,
                  //     weekID: weekID,
                  //     workoutID: workoutID,
                  //     seriesID: seriesID,
                  //     exerciseID: _exerciseID,
                  //   );
                  // }
                });
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        }),
  );
}
