import 'package:attt/utils/colors.dart';
import 'package:attt/utils/size_config.dart';
import 'package:attt/view/subscription/page/widgets/freeTrial.dart';
import 'package:flutter/material.dart';
import 'package:in_app_purchase/in_app_purchase.dart';

Widget priceContainer(
    String type, price, t1, t2, BuildContext context, Function onSubscribe, ProductDetails productDetails) {
  return GestureDetector(
    onTap: () => onSubscribe(productDetails),
    child: Stack(children: [
      Container(
        decoration: BoxDecoration(
          color: MyColors().black,
          border: Border.all(
            color: Colors.yellow.withOpacity(0.7),
            style: BorderStyle.solid,
          ),
        ),
        margin: EdgeInsets.only(
            top: SizeConfig.blockSizeVertical * 2,
            left: SizeConfig.blockSizeHorizontal * 3,
            right: SizeConfig.blockSizeHorizontal * 3),
        height: SizeConfig.blockSizeVertical * 12,
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(left: 10.0, top: 10.0),
              alignment: Alignment.centerLeft,
              width: SizeConfig.blockSizeHorizontal * 100,
              child: Text(
                type,
                style: TextStyle(
                    color: MyColors().lightWhite,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                    fontSize: SizeConfig.safeBlockHorizontal * 8),
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 10.0, top: 10.0),
              alignment: Alignment.centerLeft,
              width: SizeConfig.blockSizeHorizontal * 100,
              child: Text(
                  'for only ' + price,
                style: TextStyle(
                    color: MyColors().lightWhite,
                    fontWeight: FontWeight.w500,
                    fontSize: SizeConfig.safeBlockHorizontal * 4),
              ),
            ),
          ],
        ),
      ),
      freeTrial(t1, t2)
    ]),
  );
}

