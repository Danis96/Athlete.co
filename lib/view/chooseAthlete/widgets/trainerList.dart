import 'package:attt/models/trainerModel.dart';
import 'package:attt/utils/size_config.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:attt/view/chooseAthlete/widgets/trainerContainer.dart';
import 'package:attt/view_model/chooseAthleteViewModel.dart';

Widget trainersList(BuildContext context, String name, String photo,
    String email, DocumentSnapshot userDocument, String userUID) {
  String _trainerID, _trainerName, _trainingPlanName, _trainingPlanDuration, _trainerImage;
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
                  _trainerID = _trainerData[index].trainerID;
                  _trainerName = _trainerData[index].trainerName;
                  _trainingPlanName = _trainerData[index].trainingPlanName;
                  _trainingPlanDuration =
                      _trainerData[index].trainingPlanDuration;
                  _trainerImage = _trainerData[index].trainerImage;
                    return Center(
                        child: trainerContainer(
                            context,
                            _trainerID,
                            _trainerName,
                            _trainingPlanDuration,
                            _trainingPlanName,
                            _trainerImage,
                            name,
                            photo,
                            email,
                            userDocument, 
                            userUID,
                            ));
                });
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        }),
  );
}
