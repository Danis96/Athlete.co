import 'package:attt/utils/globals.dart';
import 'package:attt/utils/size_config.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:attt/view/chooseAthlete/widgets/nameHeadline.dart';
import 'package:attt/view/chooseAthlete/widgets/trainerList.dart';

class ChooseAthlete extends StatelessWidget {
  final String name, email, photo;
  ChooseAthlete({Key key, this.email, this.name, this.photo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    String usersName = name;
    String usersPhoto = photo;
    FirebaseUser currentUser;

    return Scaffold(
      body: ListView(
        children: <Widget>[
          nameHeadline(usersName, usersPhoto, context),
          trainersList(context, currentUser),
        ],
      ),
    );
  }
}
