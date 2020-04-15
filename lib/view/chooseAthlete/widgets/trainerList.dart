import 'package:attt/models/trainerModel.dart';
import 'package:attt/utils/size_config.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:attt/view/chooseAthlete/widgets/trainerContainer.dart';
import 'package:attt/view_model/chooseAthleteViewModel.dart';

Widget trainersList(BuildContext context, String name, String photo, String email) {
  String _trainerName;
  String _trainingPlanName;
  String _trainingPlanDuration;
  List<dynamic> _trainerData = [];


  SizeConfig().init(context);
  return Container(
    margin: EdgeInsets.only(bottom: SizeConfig.blockSizeVertical * 2),
    child: FutureBuilder(
        future: ChooseAthleteViewModel().getTrainers(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            _trainerData =
                snapshot.data.map((doc) => Trainer.fromDocument(doc)).toList();
            return ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  _trainerName = _trainerData[index].trainerName;
                  _trainingPlanName = _trainerData[index].trainingPlanName;
                  _trainingPlanDuration =
                      _trainerData[index].trainingPlanDuration;
                  return Center(
                      child: trainerContainer(context, _trainerName,
                          _trainingPlanDuration, _trainingPlanName, name, photo, email));
                });
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        }),
  );
}
