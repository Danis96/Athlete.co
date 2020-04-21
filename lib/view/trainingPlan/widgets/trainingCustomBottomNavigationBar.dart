import 'package:attt/utils/colors.dart';
import 'package:attt/utils/size_config.dart';
import 'package:attt/view/trainingPlan/widgets/firstTab.dart';
import 'package:attt/view/trainingPlan/widgets/secondTab.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

Widget trainingCustomBottomNavigationBar(DocumentSnapshot userDocument,
    DocumentSnapshot userTrainerDocument, BuildContext context) {
  SizeConfig().init(context);
  return Container(
    height: SizeConfig.blockSizeVertical * 8.75,
    decoration: BoxDecoration(
      color: MyColors().lightBlack,
      boxShadow: [
        BoxShadow(
          color: MyColors().black,
          blurRadius: 5,
        ),
      ],
    ),
    child: BottomAppBar(
      child: Container(
        width: double.infinity,
        color: MyColors().lightBlack,
        child: Row(
          children: <Widget>[
            firstTab(context),
            secondTab(context, userTrainerDocument, userDocument)
          ],
        ),
      ),
    ),
  );
}
