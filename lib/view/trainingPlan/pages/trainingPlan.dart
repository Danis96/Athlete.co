import 'dart:io';
import 'package:attt/utils/size_config.dart';
import 'package:attt/view/trainingPlan/widgets/listOfWeeks.dart';
import 'package:attt/view/trainingPlan/widgets/trainingCustomBottomNavigationBar.dart';
import 'package:attt/view/trainingPlan/widgets/trainingPlanGuides.dart';
import 'package:attt/view/trainingPlan/widgets/trainingPlanHeadline.dart';
import 'package:attt/view/trainingPlan/widgets/whatsAppButton.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:attt/utils/globals.dart';

class TrainingPlan extends StatefulWidget {
  final DocumentSnapshot userDocument;
  final DocumentSnapshot userTrainerDocument;
  final String userUID;
  TrainingPlan({
    this.userTrainerDocument,
    this.userDocument,
    this.userUID,
  });

  @override
  _TrainingPlanState createState() => _TrainingPlanState();
}

class _TrainingPlanState extends State<TrainingPlan> {
  /// treba danisu warmup
  String warmup;

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print(readyGoing.toString() +
        ' ready iz bilda || rest iz builda ' +
        restGoing.toString());
    print(alertQuit.toString() + ' == ALERTQUIT');

    if (alertQuit) {
      SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    }

    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Color.fromRGBO(28, 28, 28, 1.0),
      body: WillPopScope(
        onWillPop: () => _onWillPop(),
        child: Padding(
          padding: EdgeInsets.only(
              top: SizeConfig.blockSizeVertical * 8,
              left: SizeConfig.blockSizeHorizontal * 4.5,
              right: SizeConfig.blockSizeHorizontal * 4.5),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                trainingPlanHeadline(widget.userDocument,
                    widget.userTrainerDocument, context, widget.userUID),
                SizedBox(
                  height: SizeConfig.blockSizeVertical * 2.5,
                ),
                trainingPlanGuides(widget.userTrainerDocument),
                SizedBox(
                  height: SizeConfig.blockSizeVertical * 2.5,
                ),
                whatsAppButton(context),
                listOfWeeks(
                  widget.userDocument,
                  widget.userTrainerDocument,
                  widget.userDocument.data['weeks_finished'],
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: trainingCustomBottomNavigationBar(
          widget.userDocument, widget.userTrainerDocument, context),
    );
  }

  _onWillPop() async {
    exit(0);
  }
}
