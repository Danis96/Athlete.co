import 'package:attt/utils/colors.dart';
import 'package:attt/utils/size_config.dart';
import 'package:attt/view/chooseAthlete/pages/chooseAthlete.dart';
import 'package:attt/view/subscription/page/widgets/headlineCont.dart';
import 'package:attt/view/subscription/page/widgets/subText.dart';
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
    bool userExist,
    Function checkIsIosTablet,
    ) {
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
      //      /// GO IN BUTTON (comment for apks and release)
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
            color: Color.fromRGBO(255, 198, 7, 1.0),
            onPressed: () => pageController.animateToPage(3,
                duration: Duration(milliseconds: 2000),
                curve: Curves.easeInOut),
            child: Text(
              'Start Today'.toUpperCase(),
              style: TextStyle(fontSize: SizeConfig.safeBlockHorizontal * 4),
            ),
          ),
        ),
      ),
      Container(
          margin: EdgeInsets.only(
              top: checkIsIosTablet(context) ? SizeConfig.blockSizeVertical * 50  : SizeConfig.blockSizeVertical * 60,
              left: SizeConfig.blockSizeHorizontal * 2),
          child: headlineStart()),
      Container(
          margin: EdgeInsets.only(top: checkIsIosTablet(context) ? SizeConfig.blockSizeVertical * 68 : SizeConfig.blockSizeVertical * 74),
          child: subText('Train with UFC athlete and future champion\n',
              'Aleksandar Rakic')),
      Container(
        margin: EdgeInsets.only(top: checkIsIosTablet(context) ? SizeConfig.blockSizeVertical * 68  : SizeConfig.blockSizeVertical * 71),
        alignment: Alignment.center,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              child: Text(
                'Swipe up'.toUpperCase(),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: SizeConfig.safeBlockHorizontal * 4,
                ),
              ),
            ),
            Container(
              child: Icon(
                Icons.keyboard_arrow_down,
                color: Colors.white,
                size: SizeConfig.safeBlockHorizontal * 7,
              ),
            )
          ],
        ),
      ),
    ],
  );
}


