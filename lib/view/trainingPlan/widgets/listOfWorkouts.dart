import 'package:attt/utils/size_config.dart';
import 'package:attt/view/trainingPlan/widgets/workoutContainer.dart';
import 'package:attt/view_model/trainingPlanViewModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

Widget listOfWorkouts(DocumentSnapshot userDocument,
    DocumentSnapshot userTrainerDocument, AsyncSnapshot snapshot, int index) {
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
                return workoutContainer(userDocument, snapshot2, index2, userTrainerDocument,
                    snapshot, index, context);
              },
            ),
            SizedBox(
              height: SizeConfig.blockSizeVertical * 1.25,
            ),
            Divider(
              height: SizeConfig.blockSizeVertical * 0.16,
              thickness: SizeConfig.blockSizeVertical * 0.16,
              color: Color.fromRGBO(255, 255, 255, 0.2),
            ),
            SizedBox(
              height: SizeConfig.blockSizeVertical * 3,
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
