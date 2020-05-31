import 'package:attt/utils/checkForInternet.dart';
import 'package:attt/utils/colors.dart';
import 'package:attt/utils/size_config.dart';
import 'package:attt/view/history/widgets/settingIcon.dart';
import 'package:attt/view/history/widgets/historyEmptyState.dart';
import 'package:attt/view/history/widgets/historyList.dart';
import 'package:attt/view/history/widgets/historyCustomBottomNavigationBar.dart';
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
  @override
  void initState() {
    super.initState();
    InternetConnectivity().checkForConnectivity();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    List<dynamic> finishedWorkouts =
        widget.userDocument.data['workouts_finished_history'];
    List<dynamic> finishedWeeksWithAthlete = [];
    finishedWeeksWithAthlete =
        HistoryViewModel().getfinishedWeeksWithAthlete(finishedWorkouts);
    return Scaffold(
      backgroundColor: MyColors().lightBlack,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
            top: SizeConfig.blockSizeVertical * 5,
            left: SizeConfig.blockSizeHorizontal * 4.5,
            right: SizeConfig.blockSizeHorizontal * 4.5,
          ),
          child: Column(
            children: <Widget>[
              settingsIcon(widget.userDocument, widget.userUID, context),
              finishedWorkouts.isEmpty
                  ? historyEmptyState()
                  : historyList(finishedWeeksWithAthlete, finishedWorkouts),
            ],
          ),
        ),
      ),
      bottomNavigationBar: historyCustomBottomNavigationBar(
          context, widget.userDocument, widget.userTrainerDocument),
    );
  }
}
