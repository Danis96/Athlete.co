import 'package:attt/utils/colors.dart';
import 'package:attt/utils/size_config.dart';
import 'package:attt/view/history/widgets/firstTab.dart';
import 'package:attt/view/history/widgets/secondTab.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

Widget historyCustomBottomNavigationBar(BuildContext context,
    DocumentSnapshot userDocument, DocumentSnapshot userTrainerDocument) {
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
            firstTab(context, userDocument, userTrainerDocument),
            secondTab(context),
          ],
        ),
      ),
    ),
  );
}
