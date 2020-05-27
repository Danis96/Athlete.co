import 'package:attt/interface/trainingPlanInterface.dart';
import 'package:attt/utils/customScreenAnimation.dart';
import 'package:attt/utils/globals.dart';
import 'package:attt/utils/colors.dart';
import 'package:attt/view/history/page/history.dart';
import 'package:attt/view/trainingPlan/pages/trainingPlan.dart';
import 'package:attt/view/workout/pages/workout.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class TrainingPlanViewModel implements TrainingPlanInterface {
  @override
  Future getWeeks(String trainerID) async {
    var firestore = Firestore.instance;
    QuerySnapshot qn = await firestore
        .collection('Trainers')

        /// treba i trainerID
        .document(trainerID)
        .collection('weeks')
        .orderBy('name')
        .getDocuments();
    return qn.documents;
  }

  @override
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
          finishedWorkout: finishedWorkout
        )));
  }

  @override
  whatsAppOpen(String phoneNumber, String message, String screen, BuildContext context) async {
    var whatsappUrl = "whatsapp://send?phone=$phoneNumber&text=$message";
    if (await canLaunch(whatsappUrl)) {
      await launch(whatsappUrl);
    } else {
      if(screen == 'Training Plan') {
        showAlertDialog(context);
      } else {
        launchEmail();
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

  launchEmail() async {
    String email = 'jusuf97elfarahati@gmail.com';
    if (await canLaunch("mailto:$email")) {
      await launch("mailto:$email");
    } else {
      throw 'Could not launch';
    }
  }
   

   /// launch messenger 
  launchMessenger()async {
     var messengerUrl = 'http://m.me/dzefka.dzefka.3';
     if(await canLaunch(messengerUrl))
     {
         await launch(messengerUrl);
     } else {
         throw 'Could not launch';
     }
  }
  /// launch viber
  launchViber() async {
     var viberUrl = 'viber://contact?number=%2B38762748065';
     if(await canLaunch(viberUrl)) {
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
          widget: History(
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
}
