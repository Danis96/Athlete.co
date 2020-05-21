import 'dart:io';
import 'package:attt/utils/colors.dart';
import 'package:attt/utils/size_config.dart';
import 'package:attt/view/trainingPlan/widgets/listOfWeeks.dart';
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
                Container(
                    child: FlatButton.icon(
                  onPressed: () => showSocialMediaDialog(context),
                  label: Text('Feel free to ask', style: TextStyle(color: MyColors().lightWhite, fontSize: SizeConfig.safeBlockHorizontal * 4),),
                  icon: FaIcon(
                    FontAwesomeIcons.questionCircle,
                    color: Colors.white,
                    size: SizeConfig.blockSizeHorizontal * 9,
                  ),
                )),
                listOfWeeks(
                  widget.userDocument,
                  widget.userTrainerDocument,
                  widget.userDocument.data['weeks_finished'],
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

//+44 7725 514766  NUMBER TO PUT IN SOCIAL MEDIA BUTTONS

showSocialMediaDialog(BuildContext context) {
  Widget whatsAppButton = IconButton(
    icon: Icon(
      FontAwesomeIcons.whatsapp,
      size: SizeConfig.blockSizeHorizontal * 10,
    ),
    color: Color.fromRGBO(37, 211, 102, 1),
    onPressed: () => TrainingPlanViewModel().whatsAppOpen(
        '+38762623629', 'Hello from Athlete.co!!!', 'Training Plan', context),
  );
  Widget viberButton = IconButton(
    icon: Icon(
      FontAwesomeIcons.viber,
      size: SizeConfig.blockSizeHorizontal * 10,
    ),
    color: Color.fromRGBO(102, 92, 172, 1),
    onPressed: () => TrainingPlanViewModel().launchViber(),
  );
  Widget messengerButton = IconButton(
      icon: Icon(
        FontAwesomeIcons.facebookMessenger,
        size: SizeConfig.blockSizeHorizontal * 10,
      ),
      color: Color.fromRGBO(0, 120, 255, 1),
      onPressed: () => TrainingPlanViewModel().launchMessenger());
  Widget emailButton = IconButton(
      icon: Icon(
        FontAwesomeIcons.envelope,
        color: Colors.redAccent,
        size: SizeConfig.blockSizeHorizontal * 10,
      ),
      onPressed: () => TrainingPlanViewModel().launchEmail());

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    backgroundColor: Color.fromRGBO(0, 0, 0, 0.7),
    title: Text(
      "Feel free to contact us",
      style: TextStyle(color: MyColors().lightWhite),
    ),
    content: Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          whatsAppButton,
          viberButton,
          messengerButton,
          emailButton
        ],
      ),
    ),
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
