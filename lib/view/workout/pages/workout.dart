import 'package:attt/utils/checkForInternet.dart';
import 'package:attt/utils/colors.dart';
import 'package:attt/utils/emptyContainer.dart';
import 'package:attt/utils/globals.dart';
import 'package:attt/utils/size_config.dart';
import 'package:attt/view/subscription/page/widgets/subscriptionLoader.dart';
import 'package:attt/view/workout/widgets/bottomStartButton.dart';
import 'package:attt/view/workout/widgets/workoutList.dart';
import 'package:attt/view_model/workoutViewModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Workout extends StatefulWidget {
  final DocumentSnapshot userDocument, userTrainerDocument;
  final String trainerID;
  final String workoutName, workoutID, weekID, warmupDesc, weekName, tag;
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
    this.tag,
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
  int _exerciseIsReps, _exerciseSets;
  var _exerciseReps;
  List<dynamic> _series = [], _exercises = [], _exerciseTips = [];
  List<dynamic> serije = [];

  refreshFromInfo() {
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    InternetConnectivity().checkForConnectivity();
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
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.weekName + ' ' + widget.workoutName + ' ' + widget.tag,
          style: TextStyle(
            fontSize: SizeConfig.safeBlockHorizontal * 5,
          ),
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
        widget.finishedWorkout,
        source,
      ),
      backgroundColor: MyColors().lightBlack,
      body: ListView(
        shrinkWrap: true,
        children: <Widget>[
          getSeries(),
          WorkoutList(
            finishedWorkout: widget.finishedWorkout,
            userDocument: widget.userDocument,
            userTrainerDocument: widget.userTrainerDocument,
            trainerID: widget.trainerID,
            trainerName: _trainerName,
            weekName: _weekName,
            workoutName: _workoutName,
            seriesName: _seriesName,
            series: _series,
            exercises: _exercises,
            exerciseName: _exerciseName,
            exerciseTips: _exerciseTips,
            exerciseVideo: _exerciseVideo,
            exerciseImage: _exerciseImage,
            exerciseIsReps: _exerciseIsReps,
            exerciseReps: _exerciseReps,
            exerciseSets: _exerciseSets,
            weekID: widget.weekID,
            workoutID: widget.workoutID,
            warmupDesc: widget.warmupDesc,
            exerciseID: _exerciseID,
            refreshFromInfo: refreshFromInfo,
            source: source,
          ),
        ],
      ),
    );
  }

  final Source source =
      hasActiveConnection ? Source.serverAndCache : Source.cache;

  getSeries() {
    return FutureBuilder(
      future: WorkoutViewModel().getSeries(
        widget.userTrainerDocument.data['trainerID'],
        widget.weekID,
        widget.workoutID,
        source,
      ),
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
          return Container(
            margin:EdgeInsets.only(top: SizeConfig.blockSizeVertical * 40),
            child: Center(
              child: SubLoader().subLoader(),
            ),
          );
        }
      },
    );
  }
}
