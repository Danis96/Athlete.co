import 'package:attt/utils/size_config.dart';
import 'package:flutter/material.dart';

/// [tName] - trainer Name
/// [tPD] - training plan duration
/// [tPN] - training plan name

Widget trainerInfo(BuildContext context, String tName, String tPD, String tPN) {
  SizeConfig().init(context);

  String _trainerName = tName;
  String _trainingPlanName = tPN;
  String _trainingPlanDuration = tPD;

  return Container(
    height: SizeConfig.blockSizeVertical * 35,
    padding: EdgeInsets.all(10),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(3),
          child: Text(
            _trainingPlanDuration + ' weeks',
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontSize: SizeConfig.safeBlockVertical * 2),
          ),
        ),
        Container(
            padding: EdgeInsets.all(3),
            child: Text(
              _trainerName.toUpperCase(),
              style: TextStyle(
                color: Colors.white,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.w700,
                fontSize: SizeConfig.safeBlockHorizontal * 5,
              ),
            )),
        Container(
          padding: EdgeInsets.all(3),
          child: Text(
            _trainingPlanName.toUpperCase(),
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontSize: SizeConfig.safeBlockVertical * 1.8),
          ),
        ),
      ],
    ),
  );
}
