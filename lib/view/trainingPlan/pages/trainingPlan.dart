import 'package:attt/utils/size_config.dart';
import 'package:attt/view/trainingPlan/widgets/listOfWeeks.dart';
import 'package:attt/view/trainingPlan/widgets/trainingCustomBottomNavigationBar.dart';
import 'package:attt/view/trainingPlan/widgets/trainingPlanGuides.dart';
import 'package:attt/view/trainingPlan/widgets/trainingPlanHeadline.dart';
import 'package:attt/view/trainingPlan/widgets/whatsAppButton.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TrainingPlan extends StatelessWidget {
  final DocumentSnapshot userDocument;
  final DocumentSnapshot userTrainerDocument;
  TrainingPlan({
    this.userTrainerDocument,
    this.userDocument,
  });

  /// treba danisu warmup
  String warmup;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Color.fromRGBO(28, 28, 28, 1.0),
      body: Padding(
        padding: EdgeInsets.only(
            top: SizeConfig.blockSizeVertical * 8,
            left: SizeConfig.blockSizeHorizontal * 4.5,
            right: SizeConfig.blockSizeHorizontal * 4.5),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              trainingPlanHeadline(userDocument, userTrainerDocument),
              SizedBox(
                height: SizeConfig.blockSizeVertical * 2.5,
              ),
              trainingPlanGuides(userTrainerDocument),
              SizedBox(
                height: SizeConfig.blockSizeVertical * 2.5,
              ),
              whatsAppButton(),
              listOfWeeks(
                  userTrainerDocument, userDocument.data['weeks_finished']),
            ],
          ),
        ),
      ),
      bottomNavigationBar: trainingCustomBottomNavigationBar(userDocument, userTrainerDocument, context),
    );
  }
}
