import 'dart:io';

import 'package:attt/storage/storage.dart';
import 'package:attt/utils/colors.dart';
import 'package:attt/utils/size_config.dart';
import 'package:flutter/material.dart';

class ExerciseCard extends StatefulWidget {
  final String exerciseName;
  final String exerciseTips;
  final String exerciseVideo;
  final String exerciseImage;
  final int exerciseIsReps;
  final int exerciseReps;
  final int exerciseRest;
  final int exerciseSets;
  final Storage storage;

  ExerciseCard(
      {this.exerciseImage,
      this.exerciseIsReps,
      this.exerciseName,
      this.exerciseReps,
      this.exerciseRest,
      this.exerciseSets,
      this.exerciseTips,
      this.exerciseVideo, 
      @required this.storage,
      });

  @override
  _ExerciseCardState createState() => _ExerciseCardState();
}

class _ExerciseCardState extends State<ExerciseCard> {
  /// for saving state 
   String state;

  @override
  void initState() {
    super.initState();
    writeToData();
  }
  
  Future<File> writeToData() async {
      setState(() {
          state = widget.exerciseVideo;
      });
      print('Succesfully write to file system');
      return widget.storage.writeData(state);   
  }
  

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        /// image thumbnail
        Container(
          margin: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal * 5),
          width: 90.0,
          height: 90.0,
          child: Image.network(
            widget.exerciseImage,
            height: SizeConfig.blockSizeVertical * 10,
            width: SizeConfig.blockSizeHorizontal * 10,
            fit: BoxFit.contain,
          ),
        ),
        Container(
          padding: EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                child: Text(widget.exerciseName,
                    style: TextStyle(
                        color: MyColors().white,
                        fontSize: SizeConfig.blockSizeHorizontal * 4,
                        fontWeight: FontWeight.w500)),
              ),
              Row(
                children: <Widget>[
                  Text(
                    widget.exerciseIsReps == 0
                        ? 'Sets ${widget.exerciseSets} | Reps ${widget.exerciseReps} | Rest ${widget.exerciseRest} s '
                        : 'Sets ${widget.exerciseSets} |  Rest ${widget.exerciseRest} s ',
                    style: TextStyle(
                        color: MyColors().lightWhite,
                        fontSize: SizeConfig.blockSizeHorizontal * 3),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
