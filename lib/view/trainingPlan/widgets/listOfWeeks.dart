import 'dart:async';
import 'package:attt/utils/colors.dart';
import 'package:attt/utils/customScreenAnimation.dart';
import 'package:attt/utils/globals.dart';
import 'package:attt/view/chooseAthlete/pages/chooseAthlete.dart';
import 'package:attt/view/trainingPlan/pages/trainingPlan.dart';
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
  List<dynamic> finishedWeeks = [];
  List<dynamic> weekIDs = [];
  List<dynamic> weeksToKeep = [];
  weeksFinished = userDocument.data['workouts_finished'];
  for (var i = 0; i < weeksFinished.length; i++) {
    if (weeksFinished[i].toString().split('_')[0] ==
        userTrainerDocument.data['trainerID']) {
      weekIDs.add(weeksFinished[i].toString().split('_')[1]);
    } else {
      weeksToKeep.add(weeksFinished[i]);
    }
  }
  weekIDs.sort();

  showAlertDialog(
      BuildContext context, DocumentSnapshot userDocument, String userUID) {
    Widget cancelButton = FlatButton(
      child: Text(
        "Continue with same trainer",
        style: TextStyle(color: MyColors().lightWhite),
      ),
      onPressed: () async {
        List<dynamic> currentUserDocuments = [];
        DocumentSnapshot currentUserDocument;
        currentUserDocuments =
            await SignInViewModel().getCurrentUserDocument(userUID);
        currentUserDocument = currentUserDocuments[0];
        Navigator.of(context).push(
          CardAnimationTween(
            widget: TrainingPlan(
              userTrainerDocument: userTrainerDocument,
              userDocument: currentUserDocument,
              userUID: userUID,
            ),
          ),
        );
      },
    );
    Widget continueButton = FlatButton(
      child: Text(
        "Change",
        style: TextStyle(color: MyColors().error),
      ),
      onPressed: () async {
        Navigator.of(context).push(
          CardAnimationTween(
            widget: ChooseAthlete(
              userTrainerDocument: userTrainerDocument,
              userDocument: userDocument,
              userUID: userUID,
              email: userDocument.data['email'],
              name: userDocument.data['display_name'],
              photo: userDocument.data['image'],
            ),
          ),
        );
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      backgroundColor: MyColors().lightBlack,
      title: Text(
        "Congradulations! You have completed this training plan.",
        style: TextStyle(color: MyColors().lightWhite),
      ),
      content: Text(
        "Do you want to train again with the same trainer, or you want to change your trainer?",
        style: TextStyle(color: MyColors().lightWhite),
      ),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

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
            int counter = 0;
            for (var i = 0; i < weekIDs.length; i++) {
              if (weekIDs[i] == snapshot.data[index]['weekID'].toString()) {
                counter++;
                if (counter == snapshot.data[index]['numberOfWorkouts']) {
                  finishedWeeks.add(snapshot.data[index]['weekID'].toString());
                }
              }
            }
            if (finishedWeeks.length == snapshot.data.length) {
              SignInViewModel().updateUserProgress(userDocument, weeksToKeep);
              Timer(
                Duration(milliseconds: 250),
                () {
                  showAlertDialog(
                      context, userDocument, userDocument.data['userUID']);
                },
              );
            }
            return weekContainer(
                snapshot, index, userTrainerDocument, context, userDocument);
          },
        );
      } else {
        return Center(
          child: CircularProgressIndicator(),
        );
      }
    },
  );
}
