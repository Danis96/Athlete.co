import 'package:attt/utils/emptyContainer.dart';
import 'package:attt/utils/globals.dart';
import 'package:attt/view_model/historyViewModel.dart';
import 'package:flutter/material.dart';
import 'package:attt/view/history/widgets/emptyHisotryWorkoutContainer.dart';
import 'package:attt/view/history/widgets/historyWorkoutContainer.dart';

class FutureWorkoutContainer extends StatefulWidget {
  final List<dynamic> finishedWeeksWithAthlete, workoutsList;
  final int index, index2;
  FutureWorkoutContainer(
      {Key key,
      this.finishedWeeksWithAthlete,
      this.index,
      this.index2,
      this.workoutsList})
      : super(key: key);

  @override
  _FutureWorkoutContainerState createState() => _FutureWorkoutContainerState();
}

class _FutureWorkoutContainerState extends State<FutureWorkoutContainer> {
  String workoutName = '';
  String workoutTag = '';
  List<dynamic> workoutNotes = [];

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: HistoryViewModel().getWorkoutName(
          widget.finishedWeeksWithAthlete[widget.index]
              .toString()
              .split('_')[0],
          widget.finishedWeeksWithAthlete[widget.index]
              .toString()
              .split('_')[1],
          widget.workoutsList[widget.index2].toString().split(' ')[0]),
      builder: (BuildContext context, AsyncSnapshot snapshot3) {
        if (snapshot3.hasData) {
          userNotesHistory = '';
          if (snapshot3 != null && snapshot3.data.length != 0) {
            workoutName = snapshot3.data[0].data['name'];
            workoutTag = snapshot3.data[0].data['tag'];
            workoutNotes = snapshot3.data[0].data['historyNotes'];
            HistoryViewModel().getUserNotesHistory(
                workoutNotes, widget.workoutsList, widget.index2);
          } else {
            return EmptyContainer();
          }
          return historyWorkoutContainer(
              workoutTag, workoutName, widget.workoutsList, widget.index2);
        } else {
          return emptyHistoryWorkoutContainer();
        }
      },
    );
  }
}
