import 'dart:async';
import 'package:attt/utils/colors.dart';
import 'package:attt/utils/size_config.dart';
import 'package:attt/view/home/pages/signin.dart';
import 'package:attt/view/trainingPlan/pages/trainingPlan.dart';
import 'package:attt/view_model/signInViewModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CustomSplashScreen extends StatefulWidget {
  const CustomSplashScreen({Key key}) : super(key: key);

  @override
  _CustomSplashScreenState createState() => _CustomSplashScreenState();
}

class _CustomSplashScreenState extends State<CustomSplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 2), navigation);
  }

  navigation() async {
    List<DocumentSnapshot> currentUserDocuments = await SignInViewModel().getCurrentUserDocument('UEb2j1j22oQsItZDHcvgvshikEa2');
    DocumentSnapshot currentUserDocument = currentUserDocuments[0];
    
    List<DocumentSnapshot> currentUserTrainerDocuments =
          await SignInViewModel().getCurrentUserTrainer(currentUserDocument.data['trainer']);
    DocumentSnapshot  currentUserTrainerDocument = currentUserTrainerDocuments[0];
    
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (_) => TrainingPlan(
            userTrainerDocument: currentUserTrainerDocument,
            userDocument: currentUserDocument,
            userUID: 'UEb2j1j22oQsItZDHcvgvshikEa2',
          ),
        ),
        (Route<dynamic> route) => false);
  }


  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
        backgroundColor: MyColors().lightBlack,
        body: Center(
            child: Column(children: <Widget>[
          SizedBox(height: SizeConfig.safeBlockVertical * 35),
          ClipRRect(
            borderRadius: BorderRadius.circular(6.0),
            child: Image.asset(
              'assets/images/athlete.png',
              width: SizeConfig.blockSizeHorizontal * 44.444,
            ),
          ),
        ],
            ),
        ),
    );
  }
}
