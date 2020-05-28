//import 'package:attt/models/exerciseModel.dart';
//import 'package:attt/storage/storage.dart';
//import 'package:attt/utils/colors.dart';
//import 'package:attt/utils/globals.dart';
//import 'package:attt/utils/size_config.dart';
//import 'package:attt/view/workout/widgets/exerciseCard.dart';
//import 'package:attt/view_model/workoutViewModel.dart';
//import 'package:flutter/material.dart';
//
//class SeriesCard extends StatefulWidget {
//  String trainerName;
//  String weekName;
//  String workoutName;
//  String seriesName;
//  BuildContext context;
//  String trainerID;
//  List<dynamic> exercises;
//  String exerciseName;
//  List<dynamic> exerciseTips;
//  String exerciseVideo;
//  String exerciseImage;
//  int exerciseIsReps;
//  int exerciseReps;
//  int exerciseRest;
//  int exerciseSets;
//  String weekID;
//  String workoutID;
//  String seriesID;
//  String exerciseID;
//  Function refreshFromInfo;
//  SeriesCard(
//      {Key key,
//      this.trainerName,
//      this.weekName,
//      this.workoutName,
//      this.context,
//      this.exerciseID,
//      this.exerciseImage,
//      this.exerciseIsReps,
//      this.exerciseName,
//      this.exerciseReps,
//      this.exerciseRest,
//      this.exerciseSets,
//      this.exerciseTips,
//      this.exerciseVideo,
//      this.exercises,
//      this.refreshFromInfo,
//      this.seriesID,
//      this.seriesName,
//      this.trainerID,
//      this.weekID,
//      this.workoutID})
//      : super(key: key);
//
//  @override
//  _SeriesCardState createState() => _SeriesCardState();
//}
//
//class _SeriesCardState extends State<SeriesCard> {
//  Future _future;
//  @override
//  void initState() {
//    super.initState();
//    _future = WorkoutViewModel().getExercises(
//        widget.trainerID, widget.weekID, widget.workoutID, widget.seriesID), ;
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    SizeConfig().init(context);
//    onlineExercises = [];
//    return Column(
//      children: <Widget>[
//        Container(
//          color: MyColors().lightBlack,
//          height: SizeConfig.safeBlockVertical * 2.5,
//        ),
//        Container(
//          margin: EdgeInsets.only(bottom: SizeConfig.blockSizeVertical * 5),
//          child: Column(
//            crossAxisAlignment: CrossAxisAlignment.start,
//            children: <Widget>[
//              Container(
//                padding: EdgeInsets.all(10.0),
//                margin:
//                    EdgeInsets.only(left: SizeConfig.blockSizeHorizontal * 2),
//                child: Text(widget.seriesName,
//                    style: TextStyle(
//                        color: MyColors().white,
//                        fontSize: SizeConfig.blockSizeHorizontal * 5)),
//              ),
//              FutureBuilder(
//                  future: Future.delayed(Duration(milliseconds: 500))
//                      .then((value) => _future),
//                  builder: (BuildContext context, AsyncSnapshot snapshot) {
//                    if (snapshot.hasData) {
//                      widget.exercises = snapshot.data
//                          .map((doc) => Exercise.fromDocument(doc))
//                          .toList();
//                      return ListView.builder(
//                          shrinkWrap: true,
//                          physics: NeverScrollableScrollPhysics(),
//                          itemCount: widget.exercises.length,
//                          itemBuilder: (BuildContext context, int index) {
//                            widget.exerciseName = widget.exercises[index].name;
//                            widget.exerciseImage =
//                                widget.exercises[index].image;
//                            widget.exerciseIsReps =
//                                widget.exercises[index].isReps;
//                            widget.exerciseReps = widget.exercises[index].reps;
//                            widget.exerciseRest = widget.exercises[index].rest;
//                            widget.exerciseSets = widget.exercises[index].sets;
//                            widget.exerciseTips = widget.exercises[index].tips;
//                            exTips = widget.exercises[index].tips;
//                            widget.exerciseID =
//                                widget.exercises[index].exerciseID;
//                            widget.exerciseVideo =
//                                widget.exercises[index].video;
//                            exVideo = widget.exercises[index].video;
//
//                            onlineExercises
//                                .add(snapshot.data[index].data['video']);
//                            exerciseSnapshots.add(snapshot.data[index]);
//                            //print(onlineVideos.length);
//
//                            return ExerciseCard(
//                              exerciseImage: widget.exerciseImage,
//                              exerciseIsReps: widget.exerciseIsReps,
//                              exerciseName: widget.exerciseName,
//                              exerciseReps: widget.exerciseReps,
//                              exerciseRest: widget.exerciseRest,
//                              exerciseSets: widget.exerciseSets,
//                              exerciseTips: widget.exerciseTips,
//                              exerciseVideo: widget.exerciseVideo,
//                              storage: Storage(),
//                              exerciseID: widget.exerciseID,
//                              refreshParent: widget.refreshFromInfo,
//                            );
//                          });
//                    } else {
//                      return Center(
//                        child: CircularProgressIndicator(),
//                      );
//                    }
//                  })
//            ],
//          ),
//        ),
//        Container(
//          color: MyColors().lightBlack,
//          height: SizeConfig.safeBlockVertical * 2.5,
//        ),
//      ],
//    );
//  }
//}
