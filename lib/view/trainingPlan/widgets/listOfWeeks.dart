import 'package:attt/utils/globals.dart';
import 'package:attt/view/subscription/page/widgets/subscriptionLoader.dart';
import 'package:attt/view/trainingPlan/widgets/weekContainer.dart';
import 'package:attt/view_model/trainingPlanViewModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:attt/utils/size_config.dart';

Widget listOfWeeks(DocumentSnapshot userDocument,
    DocumentSnapshot userTrainerDocument, BuildContext context) {

  SizeConfig().init(context);
  String trainerID = userTrainerDocument.data['trainerID'];
  String emailOfUser = userDocument.data['email'];
  String nameOfUser = userDocument.data['display_name'];
  String photoOfUser = userDocument.data['image'];
  String userUID = userDocument.data['userUID'];
  List<dynamic> weeksFinished = [];
  weeksFinished = userDocument.data['workouts_finished'];
  List<dynamic> weekIDs = [];
  weekIDs = TrainingPlanViewModel().getWeekIDs(weeksFinished, trainerID);
  List<dynamic> weeksToKeep = [];
  weeksToKeep =
      TrainingPlanViewModel().getWeeksToKeep(weeksFinished, trainerID);
  finishedWeeks = [];

  final Source source =
      hasActiveConnection ? Source.serverAndCache : Source.cache;

  return FutureBuilder(

    future: TrainingPlanViewModel()
        .getWeeks(userTrainerDocument.data['trainerID'], source),
    builder: (BuildContext context, AsyncSnapshot snapshot) {
      if (snapshot.hasData) {
        for (int i = 0; i < snapshot.data.length; i++) {
          DocumentSnapshot doc = snapshot.data.elementAt(i);
          // Check manually if the data you're referring to is coming from the cache.
          print(doc.metadata.isFromCache ? "Cached" : "Not Cached");
        }
        return ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: snapshot.data.length,
          itemBuilder: (BuildContext context, int index) {
            TrainingPlanViewModel().getFinishedWeeks(weekIDs, snapshot, index);
            TrainingPlanViewModel().deleteUserProgressAndShowAlertDialog(
                snapshot,
                userDocument,
                weeksToKeep,
                context,
                userUID,
                userTrainerDocument,
                emailOfUser,
                nameOfUser,
                photoOfUser);
            return weekContainer(
                snapshot, index, userTrainerDocument, context, userDocument);
          },
        );
      } else {
        return Center(
          child: SubLoader().subLoader(),
        );
      }
    },
  );
}