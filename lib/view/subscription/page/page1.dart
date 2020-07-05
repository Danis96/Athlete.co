import 'package:attt/utils/colors.dart';
import 'package:attt/utils/size_config.dart';
import 'package:attt/view/chooseAthlete/pages/chooseAthlete.dart';
import 'package:attt/view/subscription/page/widgets/centerText.dart';
import 'package:attt/view/subscription/page/widgets/headlineCont.dart';
import 'package:attt/view/subscription/page/widgets/phasesCont.dart';
import 'package:attt/view/subscription/page/widgets/subText.dart';
import 'package:attt/view/subscription/page/widgets/textReviews.dart';
import 'package:attt/view/trainingPlan/pages/trainingPlan.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

Widget pageOne(
    PageController pageController,
    BuildContext context,
    DocumentSnapshot currentUserDocument,
    currentUserTrainerDocument,
    String userName,
    userPhoto,
    userUID,
    userEmail,
    bool userExist) {
  return Stack(
    children: <Widget>[
      Container(
        width: SizeConfig.blockSizeHorizontal * 100,
        height: SizeConfig.blockSizeVertical * 100,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/rakic.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Text(''),
      ),
      Container(
        width: SizeConfig.blockSizeHorizontal * 100,
        height: SizeConfig.blockSizeVertical * 100,
        color: MyColors().lightBlack.withOpacity(0.5),
      ),
/// GO IN BUTTON (comment for apks and release)
      Container(
        margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical * 5),
        child: RaisedButton(
            child: Text('GO IN'),
            onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (_) => userExist
                    ? currentUserDocument.data['trainer'] != null &&
                    currentUserDocument.data['trainer'] != ''
                    ? TrainingPlan(
                  userTrainerDocument: currentUserTrainerDocument,
                  userDocument: currentUserDocument,
                )
                    : ChooseAthlete(
                  userDocument: currentUserDocument,
                  name: userName,
                  email: userEmail,
                  photo: userPhoto,
                  userUID: userUID,
                )
                    : ChooseAthlete(
                  userDocument: currentUserDocument,
                  name: userName,
                  email: userEmail,
                  photo: userPhoto,
                  userUID: userUID,
                )))),
      ),
      Container(
        width: SizeConfig.blockSizeHorizontal * 100,
        alignment: Alignment.bottomCenter,
        child: Container(
          margin: EdgeInsets.only(bottom: SizeConfig.blockSizeVertical * 1),
          height: SizeConfig.blockSizeHorizontal * 12,
          width: SizeConfig.blockSizeHorizontal * 90,
          child: RaisedButton(
            color: Colors.amber.withOpacity(0.8),
            onPressed: () => pageController.animateToPage(2,
                duration: Duration(milliseconds: 1500),
                curve: Curves.easeInOut),
            child: Text('Start Today'),
          ),
        ),
      ),
      Container(
          margin: EdgeInsets.only(
              top: SizeConfig.blockSizeVertical * 15,
              left: SizeConfig.blockSizeHorizontal * 2),
          child: headlineStart()),
      Container(
          margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical * 26),
          child: subText('Train with UFC athlete and future champion ',
              'Aleksandar Rakic')),
      Container(
          margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical * 32),
          child: subText('Program design by his world class performance coach',
              ' Richard Staudner')),
      Container(
          margin: EdgeInsets.only(bottom: SizeConfig.blockSizeVertical * 17),
          child: centerText('This program include: ', '')),
      Center(
        child: Container(
            margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical * 41),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                phasesCont(
                    '', 'Full Program', 'Strength and conditioning for MMA', ''),
                phasesCont('', 'Bodyweight Only', ' At home, no equipment ', ''),
                phasesCont('', 'Tabata', 'Intense HIIT Conditioning', ''),
                phasesCont('', 'Fighter Pull Up Program', '', '+ more...'),
              ],
            )),
      ),
    ],
  );
}
