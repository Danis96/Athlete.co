import 'dart:async';
import 'package:attt/utils/colors.dart';
import 'package:attt/utils/customScreenAnimation.dart';
import 'package:attt/utils/emptyContainer.dart';
import 'package:attt/utils/globals.dart';
import 'package:attt/view/chooseAthlete/pages/chooseAthlete.dart';
import 'package:attt/view/trainingPlan/pages/trainingPlan.dart';
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
  List<dynamic> finishedWeeks = [];
  List<dynamic> weekIDs = [];
  List<dynamic> weeksToKeep = [];
  weeksFinished = userDocument.data['workouts_finished'];
  print(weeksFinished.toString() + ' LLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLL   ' + weekIDs.toString());
  for (var i = 0; i < weeksFinished.length; i++) {
    if (weeksFinished[i].toString().split('_')[0] ==
        userTrainerDocument.data['trainerID']) {
      weekIDs.add(weeksFinished[i].toString().split('_')[1]);
    } else {
      weeksToKeep.add(weeksFinished[i]);
    }
  }
  weekIDs.sort();
  print('WEEEEEEEEKS: ' + weekIDs.toString());

  // updateUserWithFinisheAthlete(
  //     DocumentSnapshot userDocument, String trainerID) async {
  //   List<String> note = [];
  //   note.add(trainerID);
  //   final db = Firestore.instance;
  //   await db
  //       .collection('Users')
  //       .document(userDocument.documentID)
  //       .updateData({"trainers_finished": FieldValue.arrayUnion(note)});
  // }

  showAlertDialog(
      BuildContext context, DocumentSnapshot userDocument, String userUID) {
    // set up the buttons

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
          Navigator.of(context).push(CardAnimationTween(
              widget: TrainingPlan(
            userTrainerDocument: userTrainerDocument,
            userDocument: currentUserDocument,
            userUID: userUID,
          )));
        });
    Widget continueButton = FlatButton(
        child: Text(
          "Change",
          style: TextStyle(color: MyColors().error),
        ),
        onPressed: () async {
          // SignInViewModel()
          //     .updateUserWithTrainer(userDocument, userUID, _trainerName);
          // List<DocumentSnapshot> currentUserTrainerDocuments = [];
          // DocumentSnapshot currentUserTrainerDocument;

          // currentUserTrainerDocuments =
          //     await SignInViewModel().getCurrentUserTrainer(_trainerName);
          // currentUserTrainerDocument = currentUserTrainerDocuments[0];

          Navigator.of(context).push(CardAnimationTween(
              widget: ChooseAthlete(
            userTrainerDocument: userTrainerDocument,
            userDocument: userDocument,
            userUID: userUID,
            email: userDocument.data['email'],
            name: userDocument.data['display_name'],
            photo: userDocument.data['image'],
          )));
        });

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

  getNewDocument(String userUID) async {
    List<dynamic> currentUserDocuments = [];
    DocumentSnapshot currentUserDocument;
    currentUserDocuments =
        await SignInViewModel().getCurrentUserDocument(userUID);
    currentUserDocument = currentUserDocuments[0];
    Navigator.of(context).push(CardAnimationTween(
        widget: TrainingPlan(
      userTrainerDocument: userTrainerDocument,
      userDocument: currentUserDocument,
      userUID: userUID,
    )));
  }

  return FutureBuilder(
      future: TrainingPlanViewModel()
          .getWeeks(userTrainerDocument.data['trainerID']),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          //int counter = 0;
          ///NE VALJA OVO, TREBA OVO PRERADITI
          ///------------------------------------------------------------------------------------------------------------
          //if (weekIDs.length == snapshot.data.length) {
          //   // updateUserWithFinisheAthlete(
          //   //     userDocument, userTrainerDocument.data['trainerID']);
          //SignInViewModel().updateUserProgress(userDocument, weeksToKeep);

          //getNewDocument(userDocument.data['userUID']);
          //   Timer(Duration(milliseconds: 250), () {
          //     showAlertDialog(
          //         context, userDocument, userDocument.data['userUID']);
          //   });
          //}
          return ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                print('NUMBER OF WORKOUTS: ' +
                    snapshot.data[index]['numberOfWorkouts'].toString());
                print('FINISHED WORKOUTS: ' + weekIDs.toString());
                int counter = 0;
                for (var i = 0; i < weekIDs.length; i++) {
                  if (weekIDs[i] == snapshot.data[index]['weekID'].toString()) {
                    counter++;
                    print(counter);
                    if (counter == snapshot.data[index]['numberOfWorkouts']) {
                      finishedWeeks
                          .add(snapshot.data[index]['weekID'].toString());
                    }
                  }
                }

                print(noteClicked);
                if (finishedWeeks.length == snapshot.data.length) {
                  print('TRAINING PLAN FINISHED');
                  //   updateUserWithFinisheAthlete(
                  // userDocument, userTrainerDocument.data['trainerID']);
                  SignInViewModel()
                      .updateUserProgress(userDocument, weeksToKeep);

                  //getNewDocument(userDocument.data['userUID']);
                  Timer(Duration(milliseconds: 250), () {
                    showAlertDialog(
                        context, userDocument, userDocument.data['userUID']);
                  });
                }

                print('FINISHED WEEKS FINAL: ' + finishedWeeks.toString());

                // if (weekIDs.contains(snapshot.data[index]['weekID'])) {
                //   print(snapshot.data[index]['weekID'] +
                //       ' SEDMICA GOTOVAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA');
                //   //   counter = counter + 1;
                //   //   return Container(
                //   //     height: 0,
                //   //     width: 0,
                //   //   );
                // }
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
