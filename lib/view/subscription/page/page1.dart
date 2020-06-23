import 'package:attt/utils/size_config.dart';
import 'package:attt/view/subscription/page/widgets/centerText.dart';
import 'package:attt/view/subscription/page/widgets/headlineCont.dart';
import 'package:attt/view/subscription/page/widgets/phasesCont.dart';
import 'package:attt/view/subscription/page/widgets/subText.dart';
import 'package:attt/view/subscription/page/widgets/textReviews.dart';
import 'package:flutter/material.dart';

Widget pageOne(PageController pageController) {
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
        color: Colors.indigo.withOpacity(0.7),
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
            child: Text('Become Athlete'),
          ),
        ),
      ),
      Container(
          margin: EdgeInsets.only(
              top: SizeConfig.blockSizeVertical * 36,
              left: SizeConfig.blockSizeHorizontal * 2),
          child: headlineStart()),
      Container(
          margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical * 52),
          child: subText('Train with UFC athlete and future champion ',
              'Aleksandar Rakic')),
      Container(
          margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical * 59),
          child: subText('Program design by world class performance coach',
              ' Richard Staudner')),
      Container(
          margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical * 39),
          child: centerText(ReviewText().text10,
          '')),
      Container(
          margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical * 72),
          child: Column(
            children: <Widget>[
              phasesCont(ReviewText().text3, '1.', ' Control your ', 'bodyweight'),
              phasesCont('', '2.', ' Control external ', 'weight'),
              phasesCont('', '3.', ' Control your ', 'opponent'),
            ],
          )),
    ],
  );
}
