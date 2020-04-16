import 'package:attt/utils/colors.dart';
import 'package:attt/utils/size_config.dart';
import 'package:attt/view/trainingPlan/pages/trainingPlan.dart';
import 'package:flutter/material.dart';
import 'package:attt/view/chooseAthlete/widgets/trainerInfo.dart';

/// [tName] - trainer Name
/// [tPD] - training plan duration
/// [tPN] - training plan name

Widget trainerContainer(BuildContext context, String tName, String tPD,
    String tPN, String name, String photo, String email) {
  SizeConfig().init(context);

  String _trainerName = tName;
  String _trainingPlanName = tPN;
  String _trainingPlanDuration = tPD;

  return GestureDetector(
    onTap: () => Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => TrainingPlan(
          trainerName: _trainerName,
          trainingPlanDuration: _trainingPlanDuration,
          trainingPlanName: _trainingPlanName,
          name: name,
          photo: photo,
          email: email,
        ),
      ),
    ),
    child: Container(
      margin: EdgeInsets.only(
        top: SizeConfig.blockSizeVertical * 1,
      ),
      child: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
                color: MyColors().black,
                borderRadius: new BorderRadius.only(
                  topLeft: const Radius.circular(8),
                  topRight: const Radius.circular(8),
                  bottomLeft: const Radius.circular(8),
                  bottomRight: const Radius.circular(8),
                )),
            width: SizeConfig.blockSizeHorizontal * 95,
            height: SizeConfig.blockSizeVertical * 35,
          ),
          trainerInfo(
              context, _trainerName, _trainingPlanDuration, _trainingPlanName),
        ],
      ),
    ),
  );
}
