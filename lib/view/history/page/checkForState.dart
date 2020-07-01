import 'dart:async';

import 'package:attt/utils/checkForInternet.dart';
import 'package:attt/utils/colors.dart';
import 'package:attt/utils/customScreenAnimation.dart';
import 'package:attt/utils/size_config.dart';
import 'package:attt/view/history/page/history.dart';
import 'package:attt/view/subscription/page/widgets/subscriptionLoader.dart';
import 'package:attt/view_model/historyViewModel.dart';
import 'package:attt/view_model/signInViewModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CheckForHistoryState extends StatefulWidget {
  final DocumentSnapshot userDocument;
  final DocumentSnapshot userTrainerDocument;
  final String userUID;

  CheckForHistoryState(
      {this.userUID, this.userDocument, this.userTrainerDocument});

  @override
  _CheckForHistoryStateState createState() => _CheckForHistoryStateState();
}

class _CheckForHistoryStateState extends State<CheckForHistoryState> {
  List<dynamic> finishedWeeksWithAthlete = [];
  List<dynamic> finishedWorkouts = [];
  bool gettingDone = false;
  DocumentSnapshot currentUserDocument;

  @override
  void initState() {
    InternetConnectivity().checkForConnectivity();
    newMethod();
    loading();
    super.initState();
  }

  Future<Timer> loading() async {
    return Timer(Duration(milliseconds: 500), onDoneChecking);
  }

  onDoneChecking() {
    Navigator.of(context).push(CardAnimationTween(
        widget: History(
      userUID: widget.userUID,
      userDocument: widget.userDocument,
      finishedWeeksWithAthlete: finishedWeeksWithAthlete,
      finishedWorkouts: finishedWorkouts,
      userTrainerDocument: widget.userTrainerDocument,
    )));
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: MyColors().lightBlack,
      body: Center(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SubLoader().subLoader(),
              SubLoader().subLoaderText(),
            ],
          ),
        ),
      ),
    );
  }

  newMethod() async {
    List<dynamic> currentUserDocuments = [];
    currentUserDocuments = await SignInViewModel()
        .getCurrentUserDocument(widget.userDocument.data['userUID']);
    setState(() {
      currentUserDocument = currentUserDocuments[0];
      finishedWorkouts = currentUserDocument.data['workouts_finished_history'];
      finishedWeeksWithAthlete =
          HistoryViewModel().getfinishedWeeksWithAthlete(finishedWorkouts);
      gettingDone = true;
    });
  }
}
