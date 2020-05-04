import 'package:attt/storage/storage.dart';
import 'package:attt/utils/colors.dart';
import 'package:attt/utils/globals.dart';
import 'package:attt/utils/size_config.dart';
import 'package:attt/utils/text.dart';
import 'package:attt/view/workout/widgets/exerciseCard.dart';
import 'package:attt/view_model/workoutViewModel.dart';
import 'package:flutter/material.dart';
import 'package:attt/utils/customExpansion.dart' as custom;

Widget warmupContainer(
  String _trainerName,
  String _weekName,
  String _workoutName,
  String _seriesName,
  String warmupDesc,
  String trainerID,
  String weekID,
  String workoutID,
  String image,
  int isReps,
  String name,
  int reps,
  int rest,
  int sets,
  List<String> tips,
  String video,
  Function refreshFromInfo,
) {
  return Container(
    color: MyColors().black,
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
            future: WorkoutViewModel()
                .getWarmupDocumentID(trainerID, weekID, workoutID),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      print(_trainerName +
                          _weekName +
                          _workoutName +
                          _seriesName +
                          snapshot.data[index].data['name'] +
                          '.mp4');
                      return ExerciseCard(
                        exerciseImage: snapshot.data[index].data['image'],
                        exerciseIsReps: snapshot.data[index].data['isReps'],
                        exerciseName: snapshot.data[index].data['name'],
                        exerciseReps: snapshot.data[index].data['reps'],
                        exerciseRest: snapshot.data[index].data['rest'],
                        exerciseSets: snapshot.data[index].data['sets'],
                        exerciseTips: snapshot.data[index].data['tips'],
                        exerciseVideo: snapshot.data[index].data['video'],
                        exerciseID: snapshot.data[index].data['exerciseID'],
                        storage: Storage(),
                        refreshParent: refreshFromInfo,
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
}
