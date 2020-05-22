import 'package:attt/utils/colors.dart';
import 'package:attt/utils/customScreenAnimation.dart';
import 'package:attt/utils/globals.dart';
import 'package:attt/utils/size_config.dart';
import 'package:attt/view/trainingPlan/pages/trainingPlan.dart';
import 'package:attt/view_model/signInViewModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:attt/view/chooseAthlete/widgets/trainerInfo.dart';

/// [tName] - trainer Name
/// [tPD] - training plan duration
/// [tPN] - training plan name

Widget trainerContainer(
  BuildContext context,
  String trainerID,
  String tName,
  String tPD,
  String tPN,
  String trainerImage,
  String name,
  String photo,
  String email,
  DocumentSnapshot userDocument,
  String userUID,
) {
  SizeConfig().init(context);

  String _trainerName = tName;
  String _trainingPlanName = tPN;
  String _trainingPlanDuration = tPD;

  totalWeeks = int.parse(_trainingPlanDuration);

  return GestureDetector(
    onTap: () =>
        // isFromSettings
        //     ? showAlertDialog(context, userDocument, userUID, _trainerName)
        //     :
        onClickContainer(context, userDocument, userUID, _trainerName),
    child: Container(
      margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical * 1),
      child: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: new BorderRadius.only(
                  topLeft: const Radius.circular(8),
                  topRight: const Radius.circular(8),
                  bottomLeft: const Radius.circular(8),
                  bottomRight: const Radius.circular(8),
                )),
            width: SizeConfig.blockSizeHorizontal * 95,
            height: SizeConfig.blockSizeVertical * 32,
          ),
          Container(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.network(
                trainerImage,
                fit: BoxFit.fill,
              ),
            ),
            height: SizeConfig.blockSizeVertical * 30,
            width: SizeConfig.blockSizeHorizontal * 95,
          ),
          trainerInfo(
              context, _trainerName, _trainingPlanDuration, _trainingPlanName),
        ],
      ),
    ),
  );
}

// showAlertDialog(BuildContext context, DocumentSnapshot userDocument,
//     String userUID, _trainerName) {
//   // set up the buttons

//   Widget cancelButton = FlatButton(
//     child: Text(
//       "Cancel",
//       style: TextStyle(color: MyColors().lightWhite),
//     ),
//     onPressed: () => Navigator.of(context).pop(),
//   );
//   Widget continueButton = FlatButton(
//       child: Text(
//         "Continue",
//         style: TextStyle(color: MyColors().error),
//       ),
//       onPressed: () async {
//         isFromSettings = false;
//         SignInViewModel()
//             .updateUserWithTrainer(userDocument, userUID, _trainerName);
//         //SignInViewModel().updateUserProgress(userDocument);
//         List<DocumentSnapshot> currentUserTrainerDocuments = [];
//         DocumentSnapshot currentUserTrainerDocument;

//         currentUserTrainerDocuments =
//             await SignInViewModel().getCurrentUserTrainer(_trainerName);
//         currentUserTrainerDocument = currentUserTrainerDocuments[0];

//         Navigator.of(context).push(CardAnimationTween(
//             widget: TrainingPlan(
//           userTrainerDocument: currentUserTrainerDocument,
//           userDocument: userDocument,
//           userUID: userUID,
//         )));
//       });

//   // set up the AlertDialog
//   AlertDialog alert = AlertDialog(
//     backgroundColor: MyColors().lightBlack,
//     title: Text(
//       "Change Athlete?",
//       style: TextStyle(color: MyColors().lightWhite),
//     ),
//     content: Text(
//       "If you continue, all your progress will be lost",
//       style: TextStyle(color: MyColors().lightWhite),
//     ),
//     actions: [
//       cancelButton,
//       continueButton,
//     ],
//   );

//   // show the dialog
//   showDialog(
//     context: context,
//     builder: (BuildContext context) {
//       return alert;
//     },
//   );
// }

onClickContainer(BuildContext context, DocumentSnapshot userDocument,
    String userUID, String _trainerName) async {
  SignInViewModel().updateUserWithTrainer(userDocument, userUID, _trainerName);
  List<DocumentSnapshot> currentUserTrainerDocuments = [];
  DocumentSnapshot currentUserTrainerDocument;

  currentUserTrainerDocuments =
      await SignInViewModel().getCurrentUserTrainer(_trainerName);
  currentUserTrainerDocument = currentUserTrainerDocuments[0];

  Navigator.of(context).push(CardAnimationTween(
      widget: TrainingPlan(
    userTrainerDocument: currentUserTrainerDocument,
    userDocument: userDocument,
    userUID: userUID,
  )));
}
