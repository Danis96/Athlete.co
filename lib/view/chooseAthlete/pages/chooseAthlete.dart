import 'package:attt/utils/colors.dart';
import 'package:attt/utils/globals.dart';
import 'package:attt/utils/size_config.dart';
import 'package:attt/view/chewieVideo/widgets/globals.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:attt/view/chooseAthlete/widgets/nameHeadline.dart';
import 'package:attt/view/chooseAthlete/widgets/trainerList.dart';

class ChooseAthlete extends StatefulWidget {
  final String name, email, photo;
  final DocumentSnapshot userDocument;
  ChooseAthlete({Key key, this.email, this.name, this.photo, this.userDocument}) : super(key: key);

  @override
  _ChooseAthleteState createState() => _ChooseAthleteState();
}

class _ChooseAthleteState extends State<ChooseAthlete> {
  
  @override
  void initState() { 
    super.initState();
    print('IZ INITA ');
  }


  @override
  Widget build(BuildContext context) {
    

    SizeConfig().init(context);
    String usersName = widget.name;
    String usersPhoto = widget.photo;

    return Scaffold(
      backgroundColor: MyColors().lightBlack,
      body: ListView(
        children: <Widget>[
          nameHeadline(usersName, usersPhoto, context, widget.userDocument),
          trainersList(context, userName, userPhoto, userEmail, widget.userDocument),
        ],
      ),
    );
  }
}
