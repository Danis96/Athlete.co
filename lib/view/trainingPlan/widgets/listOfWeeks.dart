import 'package:attt/utils/size_config.dart';
import 'package:attt/view/trainingPlan/widgets/weekContainer.dart';
import 'package:attt/view/trainingPlan/widgets/workoutContainer.dart';
import 'package:attt/view/workout/pages/workout.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

Widget listOfWeeks(DocumentSnapshot userTrainerDocument) {
  Future getWeeks(String trainerID) async {
    var firestore = Firestore.instance;
    QuerySnapshot qn = await firestore
        .collection('Trainers')

        /// treba i trainerID
        .document(trainerID)
        .collection('weeks')
        .getDocuments();
    return qn.documents;
  }

  Future getWorkouts(String trainerID, String weekID) async {
    var firestore = Firestore.instance;
    QuerySnapshot qn = await firestore
        .collection('Trainers')

        /// treba mi trainerID
        .document(trainerID)
        .collection('weeks')

        /// treba mi weekID
        .document(weekID)
        .collection('workouts')
        .getDocuments();
    return qn.documents;
  }

  return FutureBuilder(
      future: getWeeks(userTrainerDocument.data['trainerID']),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                if (index == 0) {
                  return FutureBuilder(
                    future: getWorkouts(userTrainerDocument.data['trainerID'],
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
                                return workoutContainer(
                                    snapshot2,
                                    index2,
                                    userTrainerDocument,
                                    snapshot,
                                    index,
                                    context);
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
                } else {
                  return weekContainer(snapshot, index);
                }
              });
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      });
}
