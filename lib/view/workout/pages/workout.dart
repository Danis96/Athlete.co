import 'package:attt/utils/colors.dart';
import 'package:attt/utils/emptyContainer.dart';
import 'package:attt/utils/globals.dart';
import 'package:attt/utils/size_config.dart';
import 'package:attt/view/workout/widgets/bottomStartButton.dart';
import 'package:attt/view/workout/widgets/workoutList.dart';
import 'package:attt/view_model/workoutViewModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Workout extends StatefulWidget {
  final DocumentSnapshot userDocument, userTrainerDocument;
  final String trainerID;
  final String workoutName, workoutID, weekID, warmupDesc, weekName;
  final List<dynamic> listOfNotes;
  final bool alreadyFinishedWorkout, finishedWorkout;

  Workout({
    Key key,
    this.userDocument,
    this.listOfNotes,
    this.userTrainerDocument,
    this.trainerID,
    this.workoutName,
    this.workoutID,
    this.alreadyFinishedWorkout,
    this.weekID,
    this.warmupDesc,
    this.weekName,
    this.finishedWorkout,
  }) : super(key: key);

  @override
  _WorkoutState createState() => _WorkoutState();
}

class _WorkoutState extends State<Workout> {
  String _seriesName,
      _exerciseName,
      _exerciseVideo,
      _exerciseImage,
      _exerciseID,
      _trainerName,
      _weekName,
      _workoutName;

  int _exerciseIsReps, _exerciseReps, _exerciseRest, _exerciseSets;

  List<dynamic> _series = [], _exercises = [], _exerciseTips = [];
  List<dynamic> serije = [];

  refreshFromInfo() {
    setState(() {});
    print('refreshed from info');
  }

  @override
  void initState() {
    super.initState();
    if (!widget.alreadyFinishedWorkout) {
      userNotes = WorkoutViewModel().getUserNotes(
          widget.listOfNotes, widget.userDocument.data['userUID']);
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    _trainerName = widget.userTrainerDocument.data['trainer_name'];
    _weekName = widget.weekName;
    _workoutName = widget.workoutName;
    //getExerciseVideosAndImages(widget.userTrainerDocument.data['trainerID'],
    //widget.weekID, widget.workoutID);
    return Scaffold(
      appBar: AppBar(
        /// workout name
        title: Text(
          widget.workoutName.toUpperCase(),
          style: TextStyle(fontSize: SizeConfig.blockSizeHorizontal * 5),
        ),
        backgroundColor: MyColors().lightBlack,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.clear,
            color: MyColors().white,
            size: SizeConfig.blockSizeHorizontal * 5.5,
          ),
          onPressed: () => WorkoutViewModel().xBack(context),
        ),
      ),
      bottomNavigationBar: bottomButtonStart(
          widget.userDocument,
          widget.userTrainerDocument,
          context,
          widget.workoutID,
          widget.weekID,
          serije,
          widget.finishedWorkout),
      backgroundColor: MyColors().lightBlack,
      body: ListView(
        shrinkWrap: true,
        children: <Widget>[
          getSeries(),

          /// workoutList
          workoutList(
            widget.trainerID,
            _trainerName,
            _weekName,
            _workoutName,
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

  getSeries() {
    return FutureBuilder(
        future: WorkoutViewModel().getSeries(
            widget.userTrainerDocument.data['trainerID'],
            widget.weekID,
            widget.workoutID),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  serije.add(snapshot.data[index].data['seriesID']);
                  return EmptyContainer();
                });
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}
