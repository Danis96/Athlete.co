import 'package:attt/utils/size_config.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:attt/view/chooseAthlete/widgets/nameHeadline.dart';
import 'package:attt/view/chooseAthlete/widgets/trainerList.dart';



class ChooseAthlete extends StatelessWidget {
  final FirebaseUser currentUser;
  ChooseAthlete({Key key, this.currentUser}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    String usersName = currentUser.displayName;
    String usersPhoto = currentUser.photoUrl;
    

    return Scaffold(
      body: ListView(
        children: <Widget>[
          nameHeadline(usersName, usersPhoto ,context),
          trainersList(context),
        ],
      ),
    );
  }
}








