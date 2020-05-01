import 'package:attt/models/seriesModel.dart';
import 'package:attt/storage/storage.dart';
import 'package:attt/utils/colors.dart';
import 'package:attt/utils/customExpansion.dart' as custom;
import 'package:attt/utils/emptyContainer.dart';
import 'package:attt/utils/size_config.dart';
import 'package:attt/utils/text.dart';
import 'package:attt/view/workout/widgets/exerciseCard.dart';
import 'package:attt/view/workout/widgets/seriesCard.dart';
import 'package:attt/view_model/workoutViewModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

String seriesID;

Widget workoutList(
    String trainerID,
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
    String weekID,
    String workoutID,
    String warmupDesc) {
  return Container(
    margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical * 5),
    color: MyColors().black,
    child: FutureBuilder(
        future: WorkoutViewModel().getSeries(trainerID, weekID, workoutID),
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
                  if (_seriesName == 'Warm Up') {
                    return Container(
                      color: MyColors().black,
                      margin: EdgeInsets.only(
                          top: SizeConfig.blockSizeVertical * 3),
                      child: custom.ExpansionTile(
                        title: Text(
                          MyText().warmUp,
                          style: TextStyle(
                              color: MyColors().white,
                              fontSize: SizeConfig.blockSizeHorizontal * 5),
                        ),
                        subtitle: warmupDesc,
                        iconColor: MyColors().white,
                        backgroundColor: MyColors().black,
                        initiallyExpanded: false,
                        children: <Widget>[
                          FutureBuilder(
                              future: WorkoutViewModel().getWarmupDocumentID(
                                  trainerID, weekID, workoutID),
                              builder: (BuildContext context,
                                  AsyncSnapshot snapshot) {
                                if (snapshot.hasData) {
                                  return ListView.builder(
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      itemCount: snapshot.data.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return ExerciseCard(
                                          exerciseImage: snapshot
                                              .data[index].data['image'],
                                          exerciseIsReps: snapshot
                                              .data[index].data['isReps'],
                                          exerciseName:
                                              snapshot.data[index].data['name'],
                                          exerciseReps:
                                              snapshot.data[index].data['reps'],
                                          exerciseRest:
                                              snapshot.data[index].data['rest'],
                                          exerciseSets:
                                              snapshot.data[index].data['sets'],
                                          exerciseTips:
                                              snapshot.data[index].data['tips'],
                                          exerciseVideo: snapshot
                                              .data[index].data['video'],
                                          storage: Storage(),
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
                    );
                  } else {
                    return seriesCard(
                      context,
                      _seriesName,
                      trainerID,
                      _exercises,
                      _exerciseName,
                      _exerciseTips,
                      _exerciseVideo,
                      _exerciseImage,
                      _exerciseIsReps,
                      _exerciseReps,
                      _exerciseRest,
                      _exerciseSets,
                      weekID,
                      workoutID,
                      seriesID,
                    );
                  }
                });
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        }),
  );
}
