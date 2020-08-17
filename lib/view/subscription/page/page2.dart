import 'package:attt/utils/colors.dart';
import 'package:attt/utils/size_config.dart';
import 'package:attt/view/subscription/page/widgets/reviews.dart';
import 'package:attt/view/subscription/page/widgets/starRow.dart';
import 'package:attt/view/subscription/page/widgets/textReviews.dart';
import 'package:flutter/material.dart';


Widget pageTwo(BuildContext context, PageController pageController, Function checkIsIosTablet) {
  return Stack(
    children: <Widget>[
      Container(
        width: SizeConfig.blockSizeHorizontal * 100,
        height: SizeConfig.blockSizeVertical * 100,
        color: MyColors().lightBlack.withOpacity(0.5),
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
                duration: Duration(milliseconds: 1500),
                curve: Curves.easeInOut),
            child: Text(
              'Start Today'.toUpperCase(),
              style: TextStyle(fontSize: SizeConfig.safeBlockHorizontal * 4),
            ),
          ),
        ),
      ),
            Container(
        margin: EdgeInsets.only(top: checkIsIosTablet(context) ?  SizeConfig.blockSizeVertical * 1 : SizeConfig.blockSizeVertical * 1),
        child: Column(
          children: <Widget>[
            Container(
              child: Text('100% Satisfaction Guarantee',
                textAlign: TextAlign.center,
                style: TextStyle(
                 color: Colors.white,
                 fontSize: SizeConfig.safeBlockHorizontal * 10
              ),),
            ),
            starsRow(),
          ],
        ),
      ),
      Container(
        margin: EdgeInsets.only(
          top: SizeConfig.blockSizeVertical * 19,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            reviews(ReviewText().name1, ReviewText().rev1, context),
            Container(
              margin: EdgeInsets.only(right: SizeConfig.blockSizeHorizontal * 50),
              alignment: Alignment.centerLeft,
              width: SizeConfig.blockSizeHorizontal * 100,
              child: Divider(
                 color: MyColors().lightWhite,
              ),
            ),
            reviews(ReviewText().name3, ReviewText().rev3, context),
            Container(
              margin: EdgeInsets.only(right: SizeConfig.blockSizeHorizontal * 50),
              alignment: Alignment.centerLeft,
              width: SizeConfig.blockSizeHorizontal * 100,
              child: Divider(
                color: MyColors().lightWhite,
              ),
            ),
            reviews(ReviewText().name2, ReviewText().rev2, context),
            Container(
              margin: EdgeInsets.only(right: SizeConfig.blockSizeHorizontal * 50),
              alignment: Alignment.centerLeft,
              width: SizeConfig.blockSizeHorizontal * 100,
              child: Divider(
                color: MyColors().lightWhite,
              ),
            ),
          ],
        ),
      )
    ],
  );
}
