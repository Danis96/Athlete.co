import 'dart:io';
import 'package:attt/utils/size_config.dart';
import 'package:attt/view/trainingPlan/widgets/listOfWeeks.dart';
import 'package:attt/view/trainingPlan/widgets/trainingCustomBottomNavigationBar.dart';
import 'package:attt/view/trainingPlan/widgets/trainingPlanGuides.dart';
import 'package:attt/view/trainingPlan/widgets/trainingPlanHeadline.dart';
import 'package:attt/view/trainingPlan/widgets/whatsAppButton.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';

class TrainingPlan extends StatefulWidget {
  final DocumentSnapshot userDocument;
  final DocumentSnapshot userTrainerDocument;
  TrainingPlan({
    this.userTrainerDocument,
    this.userDocument,
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
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp
    ]);

  }

  @override
  Widget build(BuildContext context) {
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
                trainingPlanHeadline(
                    widget.userDocument, widget.userTrainerDocument),
                SizedBox(
                  height: SizeConfig.blockSizeVertical * 2.5,
                ),
                trainingPlanGuides(widget.userTrainerDocument),
                SizedBox(
                  height: SizeConfig.blockSizeVertical * 2.5,
                ),
                whatsAppButton(),
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
