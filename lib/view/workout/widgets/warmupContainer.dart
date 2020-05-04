import 'package:attt/storage/storage.dart';
import 'package:attt/utils/colors.dart';
import 'package:attt/utils/emptyContainer.dart';
import 'package:attt/utils/globals.dart';
import 'package:attt/utils/size_config.dart';
import 'package:attt/utils/text.dart';
import 'package:attt/view/workout/widgets/exerciseCard.dart';
import 'package:attt/view_model/workoutViewModel.dart';
import 'package:flutter/material.dart';
import 'package:attt/utils/customExpansion.dart' as custom;

class WarmupContainer extends StatefulWidget {
  String trainerName;
  String weekName;
  String workoutName;
  String seriesName;
  String warmupDesc;
  String trainerID;
  String weekID;
  String workoutID;
  String image;
  int isReps;
  String name;
  int reps;
  int rest;
  int sets;
  List<String> tips;
  String video;
  Function refreshFromInfo;
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
      this.refreshFromInfo,
      this.reps,
      this.rest,
      this.sets,
      this.tips,
      this.trainerName,
      this.video,
      this.weekID})
      : super(key: key);

  @override
  _WarmupContainerState createState() => _WarmupContainerState();
}

class _WarmupContainerState extends State<WarmupContainer> {
  Future _future;
  @override
  void initState() {
    super.initState();
    _future = WorkoutViewModel()
        .getWarmupDocumentID(widget.trainerID, widget.weekID, widget.workoutID);
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    onlineVideos = [];
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
                      print(widget.trainerName +
                          widget.weekName +
                          widget.workoutName +
                          widget.seriesName +
                          snapshot.data[index].data['name'] +
                          '.mp4');
                      onlineVideos.add(snapshot.data[index].data['video']);
                      print(onlineVideos.length);
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
              MyText().warmUp,
              style: TextStyle(
                  color: MyColors().white,
                  fontSize: SizeConfig.blockSizeHorizontal * 5),
            ),
            subtitle: widget.warmupDesc,
            iconColor: MyColors().white,
            backgroundColor: MyColors().black,
            initiallyExpanded: false,
            children: <Widget>[
              FutureBuilder(
                  future: WorkoutViewModel().getWarmupDocumentID(
                      widget.trainerID, widget.weekID, widget.workoutID),
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
      ],
    );
  }
}

// Widget warmupContainer(
//   String _trainerName,
//   String _weekName,
//   String _workoutName,
//   String _seriesName,
//   String warmupDesc,
//   String trainerID,
//   String weekID,
//   String workoutID,
//   String image,
//   int isReps,
//   String name,
//   int reps,
//   int rest,
//   int sets,
//   List<String> tips,
//   String video,
//   Function refreshFromInfo,
// ) {
//   return Column(
//     children: <Widget>[
//       FutureBuilder(
//             future: WorkoutViewModel()
//                 .getWarmupDocumentID(trainerID, weekID, workoutID),
//             builder: (BuildContext context, AsyncSnapshot snapshot) {
//               if (snapshot.hasData) {
//                 return ListView.builder(
//                     shrinkWrap: true,
//                     physics: NeverScrollableScrollPhysics(),
//                     itemCount: snapshot.data.length,
//                     itemBuilder: (BuildContext context, int index) {
//                       print(_trainerName +
//                           _weekName +
//                           _workoutName +
//                           _seriesName +
//                           snapshot.data[index].data['name'] +
//                           '.mp4');
//                       onlineVideos.add(snapshot.data[index].data['video']);
//                       print(onlineVideos);
//                       return EmptyContainer();
//                     });
//               } else {
//                 return Center(
//                   child: CircularProgressIndicator(),
//                 );
//               }
//             }),
//       Container(
//         color: MyColors().black,
//         child: custom.ExpansionTile(
//           title: Text(
//             MyText().warmUp,
//             style: TextStyle(
//                 color: MyColors().white,
//                 fontSize: SizeConfig.blockSizeHorizontal * 5),
//           ),
//           subtitle: warmupDesc,
//           iconColor: MyColors().white,
//           backgroundColor: MyColors().black,
//           initiallyExpanded: false,
//           children: <Widget>[
//             FutureBuilder(
//                 future: WorkoutViewModel()
//                     .getWarmupDocumentID(trainerID, weekID, workoutID),
//                 builder: (BuildContext context, AsyncSnapshot snapshot) {
//                   if (snapshot.hasData) {
//                     return ListView.builder(
//                         shrinkWrap: true,
//                         physics: NeverScrollableScrollPhysics(),
//                         itemCount: snapshot.data.length,
//                         itemBuilder: (BuildContext context, int index) {
//                           return ExerciseCard(
//                             exerciseImage: snapshot.data[index].data['image'],
//                             exerciseIsReps: snapshot.data[index].data['isReps'],
//                             exerciseName: snapshot.data[index].data['name'],
//                             exerciseReps: snapshot.data[index].data['reps'],
//                             exerciseRest: snapshot.data[index].data['rest'],
//                             exerciseSets: snapshot.data[index].data['sets'],
//                             exerciseTips: snapshot.data[index].data['tips'],
//                             exerciseVideo: snapshot.data[index].data['video'],
//                             exerciseID: snapshot.data[index].data['exerciseID'],
//                             storage: Storage(),
//                             refreshParent: refreshFromInfo,
//                           );
//                         });
//                   } else {
//                     return Center(
//                       child: CircularProgressIndicator(),
//                     );
//                   }
//                 }),
//           ],
//         ),
//       ),
//     ],
//   );
// }
