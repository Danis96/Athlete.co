import 'package:attt/utils/colors.dart';
import 'package:attt/utils/emptyContainer.dart';
import 'package:attt/utils/size_config.dart';
import 'package:attt/view/trainingPlan/widgets/workoutContainer.dart';
import 'package:attt/view_model/trainingPlanViewModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

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
    return Scaffold(
      appBar: AppBar(
        /// workout name
        title: Text(
          userTrainerDocument.data['trainer_name'] +
              ' ' +
              snapshot.data[index]['name']
                  .toString()
                  .substring(0, 1)
                  .toUpperCase() +
              snapshot.data[index]['name'].toString().substring(1),
          style: TextStyle(fontSize: SizeConfig.blockSizeHorizontal * 5),
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
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              weekDescription(weekName, snapshot, index),
              SizedBox(
                height: SizeConfig.blockSizeVertical * 1.5,
              ),
              Divider(
                height: 1,
                thickness: 1,
                color: Colors.white24,
              ),
              SizedBox(
                height: SizeConfig.blockSizeVertical * 1.5,
              ),
              listOfWorkouts(
                  userDocument, userTrainerDocument, snapshot, index, weekName),
            ],
          ),
        ),
      ),
    );
  }
}

Widget weekDescription(String weekName, AsyncSnapshot snapshot, int index) {
  String description = snapshot.data[index]['weekDescription'];
  return Container(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          "Welcome to " +
              weekName.substring(0, 1).toUpperCase() +
              weekName.substring(1) +
              "\n",
          style: TextStyle(
              color: Color.fromRGBO(255, 255, 255, 0.8),
              fontFamily: 'Roboto',
              fontSize: SizeConfig.blockSizeVertical * 2.2,
              fontWeight: FontWeight.w400),
        ),
        Text(
          description.replaceAll("\\n", "\n"),
          style: TextStyle(
              color: Color.fromRGBO(255, 255, 255, 0.8),
              fontFamily: 'Roboto',
              fontSize: SizeConfig.blockSizeVertical * 2.2,
              fontWeight: FontWeight.w400),
        )
      ],
    ),
  );
}

Widget listOfWorkouts(
    DocumentSnapshot userDocument,
    DocumentSnapshot userTrainerDocument,
    AsyncSnapshot snapshot,
    int index,
    String weekName) {
  List<dynamic> workoutsFinished = [];
  workoutsFinished = userDocument.data['workouts_finished'];
  List<dynamic> workoutIDs = [];
  for (var i = 0; i < workoutsFinished.length; i++) {
    if (workoutsFinished[i].toString().split('_')[0] ==
        userTrainerDocument.data['trainerID']) {
      workoutIDs.add(workoutsFinished[i].split('_')[2]);
    }
  }
  return FutureBuilder(
    future: TrainingPlanViewModel().getWorkouts(
        userTrainerDocument.data['trainerID'],
        snapshot.data[index].data['weekID']),
    builder: (BuildContext context, AsyncSnapshot snapshot2) {
      if (snapshot2.hasData) {
        return Column(
          children: <Widget>[
            ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: snapshot2.data.length,
              itemBuilder: (BuildContext context, int index2) {
                String workoutID = snapshot2.data[index2].data['workoutID'];
                return workoutContainer(
                    userDocument,
                    snapshot2,
                    index2,
                    userTrainerDocument,
                    snapshot,
                    index,
                    context,
                    weekName,
                    workoutID,
                    workoutIDs);
              },
            ),
          ],
        );
      } else {
        return Center(
          child: CircularProgressIndicator(),
        );
      }
    },
  );
}
