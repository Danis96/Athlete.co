import 'package:attt/models/exerciseModel.dart';
import 'package:attt/storage/storage.dart';
import 'package:attt/utils/colors.dart';
import 'package:attt/utils/emptyContainer.dart';
import 'package:attt/utils/globals.dart';
import 'package:attt/utils/size_config.dart';
import 'package:attt/view/subscription/page/widgets/subscriptionLoader.dart';
import 'package:attt/view/workout/widgets/exerciseCard.dart';
import 'package:attt/view_model/workoutViewModel.dart';
import 'package:flutter/material.dart';
import 'package:attt/utils/customExpansion.dart' as custom;
import 'package:cloud_firestore/cloud_firestore.dart';

class WarmupContainer extends StatefulWidget {
  String circuit;
  String trainerName;
  String weekName;
  String workoutName;
  String seriesName;
  String warmupDesc;
  String trainerID;
  String weekID;
  String workoutID, seriesID;
  String image;
  int isReps;
  String name;
  var reps;
  int rest;
  int sets;
  List<String> tips;
  String video;
  Function refreshFromInfo;
  Source source;
  WarmupContainer(
      {Key key,
      this.circuit,
      this.trainerID,
      this.warmupDesc,
      this.workoutID,
      this.seriesName,
      this.workoutName,
      this.weekName,
      this.image,
      this.isReps,
      this.name,
      this.seriesID,
      this.refreshFromInfo,
      this.reps,
      this.rest,
      this.sets,
      this.tips,
      this.trainerName,
      this.video,
      this.weekID,
      this.source})
      : super(key: key);

  @override
  _WarmupContainerState createState() => _WarmupContainerState();
}

class _WarmupContainerState extends State<WarmupContainer> {
  Future _future;
  bool refreshed = false;
  String warmupDescription = '';
  List<DocumentSnapshot> warmupDoc;
  List<dynamic> exercises = [];
  @override
  void initState() {
    super.initState();
    getWarmupDescription();
    _future = WorkoutViewModel().getExercises(widget.trainerID, widget.weekID,
        widget.workoutID, widget.seriesID, widget.source);
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    onlineWarmup = [];
    return Column(
      children: <Widget>[
        FutureBuilder(
            future: _future,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      onlineWarmup.add(snapshot.data[index].data['video']);
                      exerciseSnapshots.add(snapshot.data[index]);
                      return EmptyContainer();
                    });
              } else {
                return Center(
                  child: EmptyContainer(),
                );
              }
            }),
        Container(
          margin: EdgeInsets.only(top: checkIsIosTablet(context) ? SizeConfig.blockSizeVertical * 3 : SizeConfig.blockSizeVertical * 0),
          color: MyColors().black,
          child: custom.ExpansionTile(
            title: Text(
              widget.seriesName,
              style: TextStyle(
                  color: MyColors().white,
                  fontSize: SizeConfig.blockSizeHorizontal * 5),
            ),
            subtitle: widget.circuit == null ? warmupDescription : widget.seriesName + ' ' + widget.circuit,
            iconColor: MyColors().white,
            backgroundColor: MyColors().black,
            initiallyExpanded: false,
            children: <Widget>[
              FutureBuilder(
                  future: WorkoutViewModel().getExercises(
                      widget.trainerID,
                      widget.weekID,
                      widget.workoutID,
                      widget.seriesID,
                      widget.source),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      exercises = snapshot.data
                          .map((e) => Exercise.fromDocument(e))
                          .toList();
                      return ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: snapshot.data.length,
                          itemBuilder: (BuildContext context, int index) {
                            return ExerciseCard(
                              exerciseImage: exercises[index].image,
                              exerciseIsReps: exercises[index].isReps,
                              exerciseName: exercises[index].name,
                              exerciseReps: exercises[index].reps,
                              exerciseRest: exercises[index].rest,
                              exerciseSets: exercises[index].sets,
                              exerciseTips: exercises[index].tips,
                              exerciseVideo: exercises[index].video,
                              exerciseID: exercises[index].exerciseID,
                              repsDescription: exercises[index].repsDescription,
                              time: exercises[index].time,
                              storage: Storage(),
                              refreshParent: widget.refreshFromInfo,
                              source: widget.source,
                            );
                          });
                    } else {
                      return Center(
                        child: SubLoader().subLoader(),
                      );
                    }
                  }),
            ],
          ),
        ),
        Container(
          color: MyColors().lightBlack,
          height: SizeConfig.blockSizeVertical * 1.25,
        ),
      ],
    );
  }

  getWarmupDescription() async {
    warmupDoc = await WorkoutViewModel().getExercises(widget.trainerID,
        widget.weekID, widget.workoutID, widget.seriesID, widget.source);
    for (var i = 0; i < warmupDoc.length; i++) {
      if (warmupDescription == '') {
        setState(() {
          warmupDescription = warmupDescription + warmupDoc[i].data['name'];
        });
      } else {
        setState(() {
          warmupDescription =
              warmupDescription + ' - ' + warmupDoc[i].data['name'];
        });
      }
    }
  }
}

/// checking responsive
bool checkIsIosTablet(BuildContext context) {
  if (MediaQuery.of(context).size.width > 1000) {
    return true;
  } else {
    return false;
  }
}