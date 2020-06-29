import 'package:attt/utils/colors.dart';
import 'package:attt/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:in_app_purchase/in_app_purchase.dart';

Widget priceContainer(String type, var names, price, BuildContext context,
    Function onSubscribe, ProductDetails productDetails) {
  return GestureDetector(
    onTap: () => onSubscribe(productDetails),
    child: Stack(children: [
      Container(
        decoration: BoxDecoration(
          color: Colors.blueAccent.withOpacity(0.4),
          borderRadius: BorderRadius.all(Radius.circular(4)),
        ),
        margin: EdgeInsets.only(
          top: SizeConfig.blockSizeVertical * 1,
        ),
        height: SizeConfig.blockSizeVertical * 10,
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
                    fontSize: SizeConfig.safeBlockHorizontal * 5),
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 10.0, top: 10.0),
              alignment: Alignment.centerLeft,
              width: SizeConfig.blockSizeHorizontal * 100,
              child: Text(
                'then only '.toUpperCase() +
                    price +
                    ' for ' +
                    names[0] +
                    ' ' +
                    names[1],
                style: TextStyle(
                    color: MyColors().lightWhite,
                    fontWeight: FontWeight.w500,
                    fontSize: SizeConfig.safeBlockHorizontal * 4),
              ),
            ),
          ],
        ),
      ),
    ]),
  );
}
