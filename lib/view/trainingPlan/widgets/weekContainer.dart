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
        title: Text(
              userTrainerDocument.data['trainer_name'] +
              ' ' +
              snapshot.data[index]['name']
                  .toString()
                  .substring(0, 1)
                  .toUpperCase() +
              snapshot.data[index]['name'].toString().substring(1),
          style: TextStyle(
              color: Colors.white,
              fontFamily: 'Roboto',
              fontSize: SizeConfig.blockSizeVertical * 2.5,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.w500),
        ),
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