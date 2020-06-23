import 'dart:io';
import 'package:attt/utils/checkForInternet.dart';
import 'package:attt/utils/colors.dart';
import 'package:attt/utils/size_config.dart';
import 'package:attt/view/trainingPlan/widgets/listOfWeeks.dart';
import 'package:attt/view/trainingPlan/widgets/socialMediaDialog.dart';
import 'package:attt/view/trainingPlan/widgets/trainingCustomBottomNavigationBar.dart';
import 'package:attt/view/trainingPlan/widgets/trainingPlanGuides.dart';
import 'package:attt/view/trainingPlan/widgets/trainingPlanHeadline.dart';
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
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    InternetConnectivity().checkForConnectivity();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget _plan;

  @override
  Widget build(BuildContext context) {
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
              top: MediaQuery.of(context).orientation == Orientation.portrait
                  ? SizeConfig.blockSizeVertical * 8
                  : SizeConfig.blockSizeVertical * 10,
              left: MediaQuery.of(context).orientation == Orientation.portrait
                  ? SizeConfig.blockSizeHorizontal * 4.5
                  : SizeConfig.blockSizeHorizontal * 2,
              right: MediaQuery.of(context).orientation == Orientation.portrait
                  ? SizeConfig.blockSizeHorizontal * 4.5
                  : SizeConfig.blockSizeHorizontal * 2),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                trainingPlanHeadline(widget.userDocument,
                    widget.userTrainerDocument, context, widget.userUID),
                SizedBox(
                  height: SizeConfig.blockSizeVertical * 2.5,
                ),
                trainingPlanGuides(widget.userTrainerDocument, context),
                SizedBox(
                  height: SizeConfig.blockSizeVertical * 2.5,
                ),
                Container(
                    child: FlatButton.icon(
                  onPressed: () => showSocialMediaDialog(context, widget.userDocument.data['display_name']),
                  label: Text(
                    'Can we help? Contact us.',
                    style: TextStyle(
                        color: MyColors().lightWhite,
                        fontSize: MediaQuery.of(context).orientation ==
                                Orientation.portrait
                            ? SizeConfig.safeBlockHorizontal * 4
                            : SizeConfig.safeBlockHorizontal * 2),
                  ),
                  icon: FaIcon(
                    FontAwesomeIcons.questionCircle,
                    color: Colors.white,
                    size: MediaQuery.of(context).orientation ==
                            Orientation.portrait
                        ? SizeConfig.blockSizeHorizontal * 7
                        : SizeConfig.blockSizeHorizontal * 4,
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
