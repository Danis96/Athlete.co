import 'package:attt/utils/emptyContainer.dart';
import 'package:attt/view/trainingPlan/widgets/listOfWorkouts.dart';
import 'package:attt/view/trainingPlan/widgets/weekContainer.dart';
import 'package:attt/view_model/signInViewModel.dart';
import 'package:attt/view_model/trainingPlanViewModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:attt/utils/size_config.dart';

Widget listOfWeeks(DocumentSnapshot userDocument,
    DocumentSnapshot userTrainerDocument, BuildContext context) {
  SizeConfig().init(context);
  List<dynamic> weeksFinished = [];
  List<dynamic> weeksToKeep = [];
  weeksFinished = userDocument.data['workouts_finished'];
  List<dynamic> weekIDs = [];
  for (var i = 0; i < weeksFinished.length; i++) {
    if (weeksFinished[i].toString().split('_')[0] ==
        userTrainerDocument.data['trainerID']) {
      weekIDs.add(weeksFinished[i].toString().split('_')[1]);
    } else {
      weeksToKeep.add(weeksFinished[i]);
    }
  }

  updateUserWithFinisheAthlete(
      DocumentSnapshot userDocument, String trainerID) async {
    List<String> note = [];
    note.add(trainerID);
    final db = Firestore.instance;
    await db
        .collection('Users')
        .document(userDocument.documentID)
        .updateData({"trainers_finished": FieldValue.arrayUnion(note)});
  }

  return FutureBuilder(
      future: TrainingPlanViewModel()
          .getWeeks(userTrainerDocument.data['trainerID']),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          //int counter = 0;
          if (weekIDs.length == snapshot.data.length) {
            updateUserWithFinisheAthlete(
                userDocument, userTrainerDocument.data['trainerID']);
            SignInViewModel().updateUserProgress(userDocument, weeksToKeep);
          }
          return ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                if (weekIDs.contains(snapshot.data[index]['weekID'])) {
                  print(snapshot.data[index]['weekID'] +
                      ' SEDMICA GOTOVAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA');
                  //   counter = counter + 1;
                  //   return Container(
                  //     height: 0,
                  //     width: 0,
                  //   );
                }
                //else {
                //   if (index == counter) {
                //     String weekName = snapshot.data[index]['name'];
                //     return listOfWorkouts(userDocument, userTrainerDocument,
                //         snapshot, index, weekName);
                //   } else {
                //     if (index < snapshot.data.length)
                //       return weekContainer(snapshot, index);
                //   }
                // }
                return weekContainer(snapshot, index, userTrainerDocument,
                    context, userDocument);
              });
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      });
}
