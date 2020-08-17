import 'package:attt/utils/colors.dart';
import 'package:attt/utils/size_config.dart';
import 'package:attt/view/subscription/page/widgets/resultCont.dart';
import 'package:attt/view/subscription/page/widgets/textReviews.dart';
import 'package:flutter/material.dart';

Widget pageThree(Card buildProductList, BuildContext context ,Function checkIsIosTablet) {
  return Stack(
    children: <Widget>[
      Container(
        width: SizeConfig.blockSizeHorizontal * 100,
        height: SizeConfig.blockSizeVertical * 100,
        color: MyColors().lightBlack.withOpacity(0.5),
      ),
      Container(
        margin: EdgeInsets.only(
            top: checkIsIosTablet(context) ?  SizeConfig.blockSizeVertical * 7 :  SizeConfig.blockSizeVertical * 11,
            left: SizeConfig.blockSizeHorizontal * 3,
        ),
        width: SizeConfig.blockSizeHorizontal * 100,
        child: RichText(
          text: TextSpan(
            text: 'Become a well balanced athlete who is ',
            style: TextStyle(
                color: MyColors().white,
                fontSize: SizeConfig.safeBlockHorizontal * 8,
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w400),
            children: <TextSpan>[
              TextSpan(
                  text: 'ready to compete and win',
                  style: TextStyle(
                      fontSize: SizeConfig.safeBlockHorizontal * 8,
                      fontWeight: FontWeight.bold, color: Colors.white)),
            ],
          ),
        ),
      ),
      Container(
          margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical * 30,
            left: SizeConfig.blockSizeHorizontal * 3,
          ),
          child: Column(
            children: <Widget>[
              Container(
                alignment: Alignment.centerLeft,
                child: Text(ReviewText().text5,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: SizeConfig.safeBlockHorizontal * 8.0,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w400)),
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
      Container(
          margin: EdgeInsets.only(bottom: SizeConfig.blockSizeVertical * 1),
          alignment: Alignment.bottomCenter,
          child: buildProductList),
    ],
  );
}
