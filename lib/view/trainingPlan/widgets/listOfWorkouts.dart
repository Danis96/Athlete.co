import 'package:attt/utils/colors.dart';
import 'package:attt/utils/size_config.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:attt/view/trainingPlan/widgets/listOfWorkoutsBody.dart';

class ListOfWorkouts extends StatelessWidget {
  final DocumentSnapshot userDocument, userTrainerDocument;
  final AsyncSnapshot snapshot;
  final int index;
  final String weekName;
  const ListOfWorkouts(
      {Key key,
      this.userDocument,
      this.weekName,
      this.index,
      this.snapshot,
      this.userTrainerDocument})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    String trainerName = userTrainerDocument.data['trainer_name'];
    String workoutName =
        snapshot.data[index]['name'].toString().substring(0, 1).toUpperCase() +
            snapshot.data[index]['name'].toString().substring(1);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          trainerName + ' ' + workoutName,
          style: TextStyle(
            fontSize: SizeConfig.blockSizeHorizontal * 5,
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
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      backgroundColor: Color.fromRGBO(28, 28, 28, 1.0),
      body: Padding(
        padding: EdgeInsets.only(
            top: SizeConfig.blockSizeVertical * 2,
            left: SizeConfig.blockSizeHorizontal * 4.5,
            right: SizeConfig.blockSizeHorizontal * 4.5),
        child: listOfWorkoutsBody(
            weekName, snapshot, index, userDocument, userTrainerDocument),
      ),
    );
  }
}
