import 'package:attt/models/seriesModel.dart';
import 'package:attt/utils/emptyContainer.dart';
import 'package:attt/utils/globals.dart';
import 'package:attt/view/workout/widgets/markDone.dart';
import 'package:attt/view/workout/widgets/warmupContainer.dart';
import 'package:attt/view_model/workoutViewModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

String seriesID;

class WorkoutList extends StatefulWidget {
  final DocumentSnapshot userDocument, userTrainerDocument;
  final String trainerID;
  final String trainerName;
  final String weekName;
  final String workoutName;
  final String seriesName;
  final List<dynamic> series;
  final List<dynamic> exercises;
  final String exerciseName;
  final List<dynamic> exerciseTips;
  final String exerciseVideo;
  final String exerciseImage;
  final int exerciseIsReps;
  final exerciseReps;
  final int exerciseSets;
  final String weekID;
  final String workoutID;
  final String warmupDesc;
  final String exerciseID;
  final bool finishedWorkout;
  final Function refreshFromInfo;
  final Source source;
  WorkoutList({
    Key key,
    this.trainerID,
    this.finishedWorkout,
    this.weekID,
    this.workoutID,
    this.userTrainerDocument,
    this.userDocument,
    this.exerciseID,
    this.exerciseImage,
    this.exerciseIsReps,
    this.exerciseName,
    this.exerciseReps,
    this.exerciseSets,
    this.exerciseTips,
    this.exerciseVideo,
    this.exercises,
    this.refreshFromInfo,
    this.series,
    this.seriesName,
    this.source,
    this.trainerName,
    this.warmupDesc,
    this.weekName,
    this.workoutName,
  }) : super(key: key);

  @override
  _WorkoutListState createState() => _WorkoutListState();
}

class _WorkoutListState extends State<WorkoutList> {
  List<dynamic> series;
  String seriesName;

  @override
  void initState() {
    super.initState();
    checked = false;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
        future: WorkoutViewModel().getSeries(
            widget.trainerID, widget.weekID, widget.workoutID, widget.source),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            series =
                snapshot.data.map((doc) => Series.fromDocument(doc)).toList();
            return Column(
              children: <Widget>[
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: series.length,
                  itemBuilder: (BuildContext context, int index) {
                    seriesID = series[index].seriesID;
                    seriesName = series[index].name;
                    return WarmupContainer(
                      circuit: series[index].circuit,
                      trainerName: widget.trainerName,
                      weekName: widget.weekName,
                      workoutName: widget.workoutName,
                      seriesName: seriesName,
                      warmupDesc: widget.warmupDesc,
                      trainerID: widget.trainerID,
                      weekID: widget.weekID,
                      workoutID: widget.workoutID,
                      seriesID: seriesID,
                      image: snapshot.data[index].data['image'],
                      isReps: snapshot.data[index].data['isReps'],
                      name: snapshot.data[index].data['name'],
                      reps: snapshot.data[index].data['reps'],
                      rest: snapshot.data[index].data['rest'],
                      sets: snapshot.data[index].data['sets'],
                      tips: snapshot.data[index].data['tips'],
                      video: snapshot.data[index].data['video'],
                      source: widget.source,
                    );
                  },
                ),
                !widget.finishedWorkout
                    ? markDone(
                        context,
                        widget.finishedWorkout,
                        widget.userDocument,
                        widget.userTrainerDocument,
                        widget.weekID,
                        widget.workoutID)
                    : EmptyContainer()
              ],
            );
          } else {
            return Center(
              child: EmptyContainer(),
            );
          }
        },
      ),
    );
  }
}
