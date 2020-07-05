import 'package:attt/utils/colors.dart';
import 'package:attt/utils/emptyContainer.dart';
import 'package:attt/utils/size_config.dart';
import 'package:attt/view/subscription/page/widgets/centerText.dart';
import 'package:attt/view/subscription/page/widgets/phasesCont.dart';
import 'package:attt/view/subscription/page/widgets/reviews.dart';
import 'package:attt/view/subscription/page/widgets/textReviews.dart';
import 'package:flutter/material.dart';

Widget pageOneToTwo(BuildContext context) {
  return Stack(
    children: <Widget>[
      Container(
        width: SizeConfig.blockSizeHorizontal * 100,
        height: SizeConfig.blockSizeVertical * 100,
        color: MyColors().lightBlack.withOpacity(0.5),
      ),
      Container(
        margin: EdgeInsets.only(
          top: SizeConfig.blockSizeVertical * 10,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Center(
                child: Container(
                  child: phasesCont(
                      '', '', 'New content released every month including: ', ''),
                )),
            Center(
                child: Container(
                    margin: EdgeInsets.only(
                      top: SizeConfig.blockSizeVertical * 10,
                    ),
                    child: centerText('', 'Kettlebell Workouts'))
            ),
            Center(
                child: Container(
                    margin: EdgeInsets.only(
                      top: SizeConfig.blockSizeVertical * 3,
                    ),
                    child: centerText('', 'Barbell Workouts'))),
            Center(
                child: Container(
                    margin: EdgeInsets.only(
                      top: SizeConfig.blockSizeVertical * 3,
                    ),
                    child: centerText('', 'Strong Human'))),
            Center(
                child: Container(
                    margin: EdgeInsets.only(
                      top: SizeConfig.blockSizeVertical * 3,
                    ),
                    child: centerText('', 'Mobility'))),
            Center(
                child: Container(
                    margin: EdgeInsets.only(
                      top: SizeConfig.blockSizeVertical * 3,
                    ),child: centerText('', 'Rowing Machine'))),
            Center(
                child: Container(
                    margin: EdgeInsets.only(
                      top: SizeConfig.blockSizeVertical * 3,
                    ),child: centerText('', ' Treadmill'))),
            Center(
                child: Container(
                    margin: EdgeInsets.only(
                      top: SizeConfig.blockSizeVertical * 3,
                    ),child: centerText('', 'Air Bike / Stationary Bike'))),

          ],
        ),
      )
    ],
  );
}
