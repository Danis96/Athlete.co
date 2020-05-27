import 'dart:io';
import 'package:attt/utils/colors.dart';
import 'package:attt/utils/size_config.dart';
import 'package:attt/view/trainingPlan/widgets/listOfWeeks.dart';
import 'package:attt/view/trainingPlan/widgets/socialMediaDialog.dart';
import 'package:attt/view/trainingPlan/widgets/trainingCustomBottomNavigationBar.dart';
import 'package:attt/view/trainingPlan/widgets/trainingPlanGuides.dart';
import 'package:attt/view/trainingPlan/widgets/trainingPlanHeadline.dart';
import 'package:attt/view_model/trainingPlanViewModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:attt/utils/globals.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget _plan;

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

    if (_plan == null) {
      _plan = _createPlan(context);
    }

    return _plan;
  }

  Widget _createPlan(BuildContext context) {
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
                Container(
                    child: FlatButton.icon(
                  onPressed: () => showSocialMediaDialog(context),
                  label: Text(
                    'Feel free to ask',
                    style: TextStyle(
                        color: MyColors().lightWhite,
                        fontSize: SizeConfig.safeBlockHorizontal * 4),
                  ),
                  icon: FaIcon(
                    FontAwesomeIcons.questionCircle,
                    color: Colors.white,
                    size: SizeConfig.blockSizeHorizontal * 9,
                  ),
                )),
                listOfWeeks(
                  widget.userDocument,
                  widget.userTrainerDocument,
                  context,
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
