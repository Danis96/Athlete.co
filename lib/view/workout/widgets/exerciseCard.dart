import 'package:attt/storage/storage.dart';
import 'package:attt/utils/colors.dart';
import 'package:attt/utils/customScreenAnimation.dart';
import 'package:attt/utils/emptyContainer.dart';
import 'package:attt/utils/globals.dart';
import 'package:attt/utils/size_config.dart';
import 'package:attt/view/workout/widgets/info.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ExerciseCard extends StatefulWidget {
  final String exerciseName;
  final List<dynamic> exerciseTips;
  final String exerciseVideo;
  final String exerciseImage;
  final int exerciseIsReps;
  final exerciseReps;
  final int exerciseRest;
  final int exerciseSets;
  final Storage storage;
  final String exerciseID;
  final Function refreshParent;
  final Source source;
  final String time;

  ExerciseCard({
    this.exerciseImage,
    this.exerciseIsReps,
    this.exerciseName,
    this.exerciseReps,
    this.exerciseRest,
    this.exerciseSets,
    this.exerciseTips,
    this.exerciseVideo,
    @required this.storage,
    this.exerciseID,
    this.refreshParent,
    this.source,
    this.time,
  });

  @override
  _ExerciseCardState createState() => _ExerciseCardState();
}

class _ExerciseCardState extends State<ExerciseCard> {
  /// for saving state
  String state;

  @override
  Widget build(BuildContext context) {
    /// for tips
    keyOfExercise = widget.exerciseID;
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () => Navigator.of(context).push(CardAnimationTween(
          widget: InfoExercise(
        exerciseTips: widget.exerciseTips,
        exerciseNameForInfo: widget.exerciseName,
        exerciseVideoForInfo: widget.exerciseVideo,
      ))),
      child: Container(
        child: Row(
          key: ValueKey(widget.exerciseID),
          children: <Widget>[
            /// image thumbnail
            Container(
              margin: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal * 5),
              width: SizeConfig.blockSizeHorizontal * 15,
              height: SizeConfig.blockSizeVertical * 5,
              child: Image.network(
                widget.exerciseImage,
                height: SizeConfig.blockSizeVertical * 10,
                width: SizeConfig.blockSizeHorizontal * 10,
                fit: BoxFit.cover,
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      child: Text(
                        widget.exerciseName,
                        overflow: TextOverflow.clip,
                        style: TextStyle(
                            color: MyColors().white,
                            fontSize: SizeConfig.blockSizeHorizontal * 4,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    Row(
                      children: <Widget>[
                        Text(
                          widget.time == null
                              ? widget.exerciseReps == null
                                  ? 'Sets ${widget.exerciseSets} '
                                  : 'Sets ${widget.exerciseSets} | Reps ${widget.exerciseReps} '
                              : widget.exerciseReps == null
                                  ? 'Sets ${widget.exerciseSets} |  Time ${widget.time}'
                                  : 'Sets ${widget.exerciseSets} | Reps ${widget.exerciseReps} | Time ${widget.time}',
                          style: TextStyle(
                              color: MyColors().lightWhite,
                              fontSize: SizeConfig.blockSizeHorizontal * 3),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
