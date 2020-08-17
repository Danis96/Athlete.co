import 'package:attt/utils/colors.dart';
import 'package:attt/utils/customScreenAnimation.dart';
import 'package:attt/utils/size_config.dart';
import 'package:attt/view/trainingPlan/widgets/listOfWorkouts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

Widget weekContainer(
    AsyncSnapshot snapshot,
    int index,
    DocumentSnapshot userTrainerDocument,
    BuildContext context,
    DocumentSnapshot userDocument) {
  SizeConfig().init(context);

  String trainerName = userTrainerDocument.data['trainer_name'];
  String phase = snapshot.data[index]['phase'].toString();
  String name1 =
      snapshot.data[index]['name'].toString().substring(0, 1).toUpperCase();
  String name2 = snapshot.data[index]['name'].toString().substring(1);

  return GestureDetector(
    onTap: () {
      String weekName = snapshot.data[index]['name'];
      Navigator.push(
        context,
        CardAnimationTween(
          widget: ListOfWorkouts(
            index: index,
            snapshot: snapshot,
            userDocument: userDocument,
            userTrainerDocument: userTrainerDocument,
            weekName: weekName,
          ),
        ),
      );
    },
    child: Container(
      margin: EdgeInsets.only(bottom: SizeConfig.blockSizeVertical * 1.25),
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: Color.fromRGBO(255, 255, 255, 0.2)),
        borderRadius: BorderRadius.all(
          Radius.circular(4),
        ),
      ),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(
            vertical: SizeConfig.blockSizeVertical * 0.5,
            horizontal: SizeConfig.blockSizeHorizontal * 4),
        title: RichText(
            text: TextSpan(
                text: trainerName,
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Roboto',
                    fontSize: SizeConfig.safeBlockHorizontal * 5,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.w500),
                children: <TextSpan>[
              TextSpan(
                text: phase == null || phase == 'null' ? '' : ' Phase ' + phase,
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Roboto',
                    fontSize: SizeConfig.safeBlockHorizontal * 6,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.w500),
              ),
              TextSpan(
                text: name1 == null || name1 == 'null' ? '\n' : '\n' + name1,
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Roboto',
                    fontSize: SizeConfig.safeBlockHorizontal * 6,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.w500),
              ),
              TextSpan(
                text: name2 == null || name2 == 'null' ? '' : name2,
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Roboto',
                    fontSize: SizeConfig.safeBlockHorizontal * 6,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.w500),
              )
            ])),
        subtitle: Text(
          snapshot.data[index].data['numberOfWorkouts'].toString() +
              ' Workouts',
          style: TextStyle(
              color: Colors.white60,
              fontFamily: 'Roboto',
              fontSize: SizeConfig.blockSizeVertical * 2,
              fontWeight: FontWeight.w400),
        ),
        trailing: Icon(
          Icons.arrow_forward_ios,
          size: SizeConfig.blockSizeHorizontal * 5,
          color: MyColors().white,
        ),
      ),
    ),
  );
}
