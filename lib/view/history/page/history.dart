import 'dart:async';

import 'package:attt/utils/checkForInternet.dart';
import 'package:attt/utils/colors.dart';
import 'package:attt/utils/emptyContainer.dart';
import 'package:attt/utils/globals.dart';
import 'package:attt/utils/size_config.dart';
import 'package:attt/view/history/widgets/emptyHisotryWorkoutContainer.dart';
import 'package:attt/view/history/widgets/settingIcon.dart';
import 'package:attt/view/history/widgets/historyEmptyState.dart';
import 'package:attt/view/history/widgets/historyList.dart';
import 'package:attt/view/history/widgets/historyCustomBottomNavigationBar.dart';
import 'package:attt/view_model/signInViewModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:attt/view_model/historyViewModel.dart';

class History extends StatefulWidget {
  final DocumentSnapshot userDocument;
  final DocumentSnapshot userTrainerDocument;
  final String userUID;
  const History(
      {Key key, this.userTrainerDocument, this.userDocument, this.userUID})
      : super(key: key);

  @override
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  List<dynamic> finishedWeeksWithAthlete = [];
  List<dynamic> finishedWorkouts = [];
  bool gettingDone = false;
  DocumentSnapshot currentUserDocument;

  @override
  void initState() {
    super.initState();
    InternetConnectivity().checkForConnectivity();
    newMethod();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => Timer(Duration(seconds: 5), () {
              setState(() {
                loadingFinished = true;
              });
            }));
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: MyColors().lightBlack,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
            top: SizeConfig.blockSizeVertical * 8,
            left: SizeConfig.blockSizeHorizontal * 4.5,
            right: SizeConfig.blockSizeHorizontal * 4.5,
          ),
          child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                          height: 90.0,
                          width: MediaQuery.of(context).orientation ==
                                  Orientation.portrait
                              ? SizeConfig.blockSizeHorizontal * 4.3
                              : SizeConfig.blockSizeHorizontal * 3.5,
                        ),
                        settingsIcon(
                            widget.userDocument, widget.userUID, context)
                      ],
                    ),
                    finishedWorkouts.isEmpty
                        ? Center(
                          child: CircularProgressIndicator(),
                        )
                        : historyList(
                            finishedWeeksWithAthlete, finishedWorkouts),
                  ],
                )
        ),
      ),
      bottomNavigationBar: historyCustomBottomNavigationBar(
          context, widget.userDocument, widget.userTrainerDocument),
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
