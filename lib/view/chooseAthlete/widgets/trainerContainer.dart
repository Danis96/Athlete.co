import 'package:attt/utils/colors.dart';
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
    String name,
    String photo,
    String email,
    DocumentSnapshot userDocument) {
  SizeConfig().init(context);

  String _trainerID = trainerID;
  String _trainerName = tName;
  String _trainingPlanName = tPN;
  String _trainingPlanDuration = tPD;

  totalWeeks = int.parse(_trainingPlanDuration);

  return GestureDetector(
    onTap: () async {
      SignInViewModel()
          .updateUserWithTrainer(userDocument, email, _trainerName);
      List<DocumentSnapshot> currentUserTrainerDocuments = [];
      DocumentSnapshot currentUserTrainerDocument;

      currentUserTrainerDocuments =
          await SignInViewModel().getCurrentUserTrainer(_trainerName);
      currentUserTrainerDocument = currentUserTrainerDocuments[0];

      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
              builder: (_) => TrainingPlan(
                    trainerID: _trainerID,
                    userTrainerDocument: currentUserTrainerDocument,
                    userDocument: userDocument,
                    trainerName: _trainerName,
                    trainingPlanDuration: _trainingPlanDuration,
                    trainingPlanName: _trainingPlanName,
                    name: name,
                    photo: photo,
                    email: email,
                  )),
          (Route<dynamic> route) => false);
    },
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
            height: SizeConfig.blockSizeVertical * 30,
          ),
          Container(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.asset(
                'assets/images/ar.jpg',
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
