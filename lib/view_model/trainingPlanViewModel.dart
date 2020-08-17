import 'dart:async';
import 'dart:io';
import 'package:attt/view/history/page/checkForState.dart';
import 'package:attt/view/trainingPlan/widgets/alertDialogTrainingPlanFinished.dart';
import 'package:attt/interface/trainingPlanInterface.dart';
import 'package:attt/utils/customScreenAnimation.dart';
import 'package:attt/utils/globals.dart';
import 'package:attt/utils/colors.dart';
import 'package:attt/view/chooseAthlete/pages/chooseAthlete.dart';
import 'package:attt/view/trainingPlan/pages/trainingPlan.dart';
import 'package:attt/view/workout/pages/workout.dart';
import 'package:attt/view_model/signInViewModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_appavailability/flutter_appavailability.dart';
import 'package:url_launcher/url_launcher.dart';

class TrainingPlanViewModel implements TrainingPlanInterface {

  @override
  Future getWeeks(String trainerID, Source source) async {
    var firestore = Firestore.instance;
    QuerySnapshot qn = await firestore
        .collection('Trainers')
        .document(trainerID)
        .collection('weeks')
        .orderBy('order')
        .getDocuments(source: source);
    return qn.documents;
  }

  @override
  Future getWorkouts(String trainerID, String weekID) async {
    var firestore = Firestore.instance;
    QuerySnapshot qn = await firestore
        .collection('Trainers')
        .document(trainerID)
        .collection('weeks')
        .document(weekID)
        .collection('workouts')
        .orderBy('order')
        .getDocuments();
    return qn.documents;
  }

  @override
  navigateToWorkout(
    DocumentSnapshot userDocument,
    DocumentSnapshot userTrainerDocument,
    String trainerID,
    String workoutName,
    String weekID,
    String workoutID,
    String warmupDesc,
    BuildContext context,
    String weekName,
    List<dynamic> listOfNotes,
    bool alreadyFinishedWorkout,
    bool finishedWorkout,
      String tag,
  ) {
    Navigator.push(
        context,
        CardAnimationTween(
            widget: Workout(
                userDocument: userDocument,
                userTrainerDocument: userTrainerDocument,
                trainerID: trainerID,
                workoutName: workoutName,
                weekID: weekID,
                workoutID: workoutID,
                warmupDesc: warmupDesc,
                weekName: weekName,
                listOfNotes: listOfNotes,
                alreadyFinishedWorkout: alreadyFinishedWorkout,
                finishedWorkout: finishedWorkout,
                tag: tag,
            )));
  }

  @override
  whatsAppOpen(String phoneNumber, String message, String screen, String userName,
      BuildContext context) async {

    var whatsappUrl;

    if(Platform.isIOS) {
      whatsappUrl = 'whatsapp://wa.me/$phoneNumber/?text=${Uri.parse(message)}';
    } else {
      whatsappUrl = "whatsapp://send?phone=$phoneNumber&text=$message";
    }
    if (await canLaunch(whatsappUrl)) {
      await launch(whatsappUrl);
    } else {
      if (screen == 'Training Plan') {
        showAlertDialog(context);
      } else {
        launchEmail(userName);
      }
    }
  }                                                                                                                                     

  @override
  showAlertDialog(BuildContext context) {
    // set up the button
    Widget okButton = FlatButton(
      child: Text(
        "OK",
        style: TextStyle(color: MyColors().lightWhite),
      ),
      onPressed: () => Navigator.of(context).pop(),
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(
        "Could not launch WhatsApp!",
        style: TextStyle(color: MyColors().lightWhite),
      ),
      content: Text(
        "Please check if you have WhatsApp application installed on your device. If no, please install it.",
        style: TextStyle(color: MyColors().lightWhite),
      ),
      backgroundColor: Color.fromRGBO(37, 211, 102, 1.0),
      actions: [
        okButton,
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

  launchEmail(String userName) async {
    final Uri params = Uri(
      scheme: 'mailto',
      path: 'hello@athlete.co',
      query: 'subject=Customer Service Enquiry from ATHLETE.CO App Feedback&body=Hi, my name is $userName.', //add subject and body here
    );
    var url = params.toString();
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }



  /// launch messenger
  launchMessenger() async {
    var messengerUrl = 'https://m.facebook.com/messages/?id=2050729918315322&env=messenger';
    if (await canLaunch(messengerUrl)) {
      await launch(messengerUrl);
    } else {
      throw 'Could not launch';
    }
  }

  /// launch viber
  launchViber() async {
    var viberUrl = 'viber://contact?number=%2B447725514766';
    if (await canLaunch(viberUrl)) {
      await launch(viberUrl);
    } else {
      throw 'Could not';
    }
  }

  @override
  secondTabPressed(BuildContext context, DocumentSnapshot userTrainerDocument,
      DocumentSnapshot userDocument, String userUID) {
    Navigator.push(
        context,
        CardAnimationTween(
          widget: CheckForHistoryState(
            userTrainerDocument: userTrainerDocument,
            userDocument: userDocument,
            userUID: userUIDPref,
          ),
        ));
  }

  @override
  firstTabPressed(BuildContext context, DocumentSnapshot userTrainerDocument,
      DocumentSnapshot userDocument) {
    Navigator.push(
        context,
        CardAnimationTween(
          widget: TrainingPlan(
            userDocument: userDocument,
            userTrainerDocument: userTrainerDocument,
          ),
        ));
  }

  @override
  List<dynamic> getWorkoutIDs(
      List<dynamic> workoutsFinished, String trainerID) {
    List<dynamic> workoutIDs = [];
    for (var i = 0; i < workoutsFinished.length; i++) {
      if (workoutsFinished[i].toString().split('_')[0] == trainerID) {
        workoutIDs.add(workoutsFinished[i].split('_')[2]);
      }
    }
    return workoutIDs;
  }

  @override
  List<dynamic> getWeekIDs(List<dynamic> weeksFinished, String trainerID) {
    List<dynamic> weekIDs = [];
    for (var i = 0; i < weeksFinished.length; i++) {
      if (weeksFinished[i].toString().split('_')[0] == trainerID) {
        weekIDs.add(weeksFinished[i].toString().split('_')[1]);
      }
    }
    weekIDs.sort();
    return weekIDs;
  }

  @override
  List<dynamic> getWeeksToKeep(List<dynamic> weeksFinished, String trainerID) {
    List<dynamic> weeksToKeep = [];
    for (var i = 0; i < weeksFinished.length; i++) {
      if (weeksFinished[i].toString().split('_')[0] != trainerID) {
        weeksToKeep.add(weeksFinished[i]);
      }
    }
    return weeksToKeep;
  }

  @override
  continueWithSameTrainer(String userUID, BuildContext context,
      DocumentSnapshot userTrainerDocument) async {
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
  }

  @override
  changeTrainer(
      DocumentSnapshot userTrainerDocument,
      DocumentSnapshot userDocument,
      String userUID,
      String emailOfUser,
      String nameOfUser,
      String photoOfUser,
      BuildContext context) {
    Navigator.of(context).push(
      CardAnimationTween(
        widget: ChooseAthlete(
          userTrainerDocument: userTrainerDocument,
          userDocument: userDocument,
          userUID: userUID,
          email: emailOfUser,
          name: nameOfUser,
          photo: photoOfUser,
        ),
      ),
    );
  }

  @override
  getFinishedWeeks(List<dynamic> weekIDs, AsyncSnapshot snapshot, int index) {
    int counter = 0;
    for (var i = 0; i < weekIDs.length; i++) {
      if (weekIDs[i] == snapshot.data[index]['weekID'].toString()) {
        counter++;
        if (counter == snapshot.data[index]['numberOfWorkouts']) {
          finishedWeeks.add(snapshot.data[index]['weekID'].toString());
        }
      }
    }
  }

  @override
  deleteUserProgressAndShowAlertDialog(
      AsyncSnapshot snapshot,
      DocumentSnapshot userDocument,
      List<dynamic> weeksToKeep,
      BuildContext context,
      String userUID,
      DocumentSnapshot userTrainerDocument,
      String emailOfUser,
      String nameOfUser,
      String photoOfUser) {
    if (finishedWeeks.length == snapshot.data.length) {
      SignInViewModel().updateUserProgress(userDocument, weeksToKeep);
      Timer(
        Duration(milliseconds: 250),
        () {
          alertDialogTrainingPlanFinished(context, userDocument, userUID,
              userTrainerDocument, emailOfUser, nameOfUser, photoOfUser);
        },
      );
    }
  }

}
