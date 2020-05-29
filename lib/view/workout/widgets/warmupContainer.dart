import 'package:attt/storage/storage.dart';
import 'package:attt/utils/colors.dart';
import 'package:attt/utils/emptyContainer.dart';
import 'package:attt/utils/globals.dart';
import 'package:attt/utils/size_config.dart';
import 'package:attt/view/workout/widgets/exerciseCard.dart';
import 'package:attt/view_model/workoutViewModel.dart';
import 'package:flutter/material.dart';
import 'package:attt/utils/customExpansion.dart' as custom;
import 'package:cloud_firestore/cloud_firestore.dart';

class WarmupContainer extends StatefulWidget {
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
  int reps;
  int rest;
  int sets;
  List<String> tips;
  String video;
  Function refreshFromInfo;
  Source source;
  WarmupContainer(
      {Key key,
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
                  child: CircularProgressIndicator(),
                );
              }
            }),
        Container(
          color: MyColors().black,
          child: custom.ExpansionTile(
            title: Text(
              widget.seriesName,
              style: TextStyle(
                  color: MyColors().white,
                  fontSize: SizeConfig.blockSizeHorizontal * 5),
            ),
            subtitle: warmupDescription,
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
                      return ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: snapshot.data.length,
                          itemBuilder: (BuildContext context, int index) {
                            return ExerciseCard(
                              exerciseImage: snapshot.data[index].data['image'],
                              exerciseIsReps:
                                  snapshot.data[index].data['isReps'],
                              exerciseName: snapshot.data[index].data['name'],
                              exerciseReps: snapshot.data[index].data['reps'],
                              exerciseRest: snapshot.data[index].data['rest'],
                              exerciseSets: snapshot.data[index].data['sets'],
                              exerciseTips: snapshot.data[index].data['tips'],
                              exerciseVideo: snapshot.data[index].data['video'],
                              exerciseID:
                                  snapshot.data[index].data['exerciseID'],
                              storage: Storage(),
                              refreshParent: widget.refreshFromInfo,
                              source: widget.source,
                            );
                          });
                    } else {
                      return Center(
                        child: CircularProgressIndicator(),
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
