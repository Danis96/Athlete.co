import 'package:attt/utils/size_config.dart';
import 'package:attt/view/subscription/page/widgets/centerText.dart';
import 'package:attt/view/subscription/page/widgets/resultCont.dart';
import 'package:attt/view/subscription/page/widgets/starRow.dart';
import 'package:attt/view/subscription/page/widgets/textCont.dart';
import 'package:attt/view/subscription/page/widgets/textReviews.dart';
import 'package:flutter/material.dart';

Widget pageThree(Card buildProductList) {
  return Stack(
    children: <Widget>[
      Container(
        width: SizeConfig.blockSizeHorizontal * 100,
        height: SizeConfig.blockSizeVertical * 100,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/rakic2.jpg"),
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
          margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical * 15),
          child: Column(
            children: <Widget>[
              Container(
                child: Text(ReviewText().text5,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: SizeConfig.safeBlockHorizontal * 6.0,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w400)),
              ),
              Container(
                alignment: Alignment.centerLeft,
                width: SizeConfig.blockSizeHorizontal * 80,
                child: Divider(
                  thickness: 3.0,
                  color: Colors.amber.withOpacity(0.7),
                ),
              ),
              Container(
                child: resultCont('', '-', ' Be Stronger, fitter, faster'),
              ),
              resultCont('', '-', ' Improve power & conditioning'),
              resultCont('', '-', ' Reduce body fat'),
              resultCont('', '-', ' Increase muscle mass'),
              resultCont('', '-', ' Improve mobility'),
            ],
          )),
      Column(
        children: <Widget>[
          Container(
              padding: EdgeInsets.all(5),
              margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical * 45),
              child: centerText(ReviewText().text7, '')),
          centerText('ready to ', 'compete and win'),
          textCont(ReviewText().text8),
        ],
      ),
      Container(
          margin: EdgeInsets.only(bottom: SizeConfig.blockSizeVertical * 1),
          alignment: Alignment.bottomCenter,
          child: buildProductList),
      Container(
        margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical * 60),
        child: Column(
          children: <Widget>[
            centerText(ReviewText().text9, ''),
            starsRow(),
            Container(
                margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical * 1),
                child: centerText('Average Rating 4.7 / 5', '')),
          ],
        ),
      ),
    ],
  );
}
