import 'package:attt/models/warmUpModel.dart';
import 'package:attt/utils/colors.dart';
import 'package:attt/utils/customExpansion.dart' as custom;
import 'package:attt/utils/size_config.dart';
import 'package:attt/utils/text.dart';
import 'package:attt/view/workout/widgets/warmupContainer.dart';
import 'package:attt/view_model/workoutViewModel.dart';
import 'package:flutter/material.dart';

List<dynamic> _warmupList = [];
List<String> _warmups = [];
String _warmupDesc = '', _warmupImage, _singleWarmup;

bool isPressedArrow = false;

Widget warmupWidget(BuildContext context ,String trainerID, String workoutID, String weekID) {

    SizeConfig().init(context);
    return Container(
      color: MyColors().black,
      margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical * 3),
      child: custom.ExpansionTile(
        title: Text(
          MyText().warmUp,
          style: TextStyle(
              color: MyColors().white,
              fontSize: SizeConfig.blockSizeHorizontal * 5),
        ),
        subtitle: _warmupDesc,
        iconColor: MyColors().white,
        backgroundColor: MyColors().black,
        initiallyExpanded: false,
        children: <Widget>[
          FutureBuilder(
              future:
                  WorkoutViewModel().getWarmups(trainerID, weekID, workoutID),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  
                  _warmupList = snapshot.data
                      .map((doc) => Warmup.fromDocument(doc))
                      .toList();

                  return ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: _warmupList.length,
                      itemBuilder: (BuildContext context, int index) {
                        _warmupDesc = _warmupList[index].warmupDescription;
                        _warmupImage = _warmupList[index].warmupImage;
                        _warmups = _warmupDesc.split(',');
                        return ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: _warmups.length,
                          itemBuilder: (BuildContext context, int index) {
                            _singleWarmup = _warmups[index];

                            return warmupContainer(_warmupImage, _singleWarmup);
                          },
                        );
                      });
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              }),
        ],
      ),
    );
  }



