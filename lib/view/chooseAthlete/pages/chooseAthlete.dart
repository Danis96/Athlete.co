import 'package:attt/utils/colors.dart';
import 'package:attt/utils/globals.dart';
import 'package:attt/utils/size_config.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:attt/view/chooseAthlete/widgets/nameHeadline.dart';
import 'package:attt/view/chooseAthlete/widgets/trainerList.dart';

class ChooseAthlete extends StatelessWidget {
  final String name, email, photo;
  final DocumentSnapshot userDocument;
  ChooseAthlete({Key key, this.email, this.name, this.photo, this.userDocument}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    String usersName = name;
    String usersPhoto = photo;

    return Scaffold(
      backgroundColor: MyColors().lightBlack,
      body: ListView(
        children: <Widget>[
          nameHeadline(usersName, usersPhoto, context),
          trainersList(context, userName, userPhoto, userEmail, userDocument),
        ],
      ),
    );
  }
}
