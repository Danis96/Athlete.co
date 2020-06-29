import 'package:attt/utils/colors.dart';
import 'package:attt/utils/size_config.dart';
import 'package:attt/utils/text.dart';
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
    height: SizeConfig.blockSizeVertical * 32,
    padding: EdgeInsets.all(20),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Container(
          width: SizeConfig.blockSizeHorizontal * 40,
          padding: EdgeInsets.all(3),
          child: Text(
            _trainingPlanDuration + MyText().weeks,
            style: TextStyle(
                color: MyColors().white,
                fontWeight: FontWeight.w500,
                fontSize: SizeConfig.safeBlockVertical * 2),
          ),
        ),
        Container(
          width: SizeConfig.blockSizeHorizontal * 70,
            padding: EdgeInsets.all(3),
            child: Text(
              _trainerName.toUpperCase(),
              style: TextStyle(
                color: MyColors().white,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.w700,
                fontSize: SizeConfig.safeBlockHorizontal * 6,
              ),
            )),
        Container(
          width: SizeConfig.blockSizeHorizontal * 67,
          padding: EdgeInsets.all(3),
          child: Text(
            _trainingPlanName.replaceAll('\\n', '\n').toUpperCase(),
            style: TextStyle(
                color: MyColors().white,
                fontWeight: FontWeight.w500,
                fontSize: SizeConfig.safeBlockVertical * 1.9),
          ),
        ),
      ],
    ),
  );
}
