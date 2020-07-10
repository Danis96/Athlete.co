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
          color: Color.fromRGBO(255, 198, 7, 1.0),
          borderRadius: BorderRadius.all(Radius.circular(4)),
        ),
        margin: EdgeInsets.only(
          top: SizeConfig.blockSizeVertical * 1,
        ),
        height: SizeConfig.blockSizeVertical * 15,
        child: Padding(
          padding: EdgeInsets.all(
              MediaQuery.of(context).size.width < 400 ? 4.0 : 10.0),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(
                    left: 10.0,
                    top: checkForTablet(context) ? 5.0 : 10.0),
                alignment: Alignment.centerLeft,
                width: SizeConfig.blockSizeHorizontal * 100,
                child: Text(
                  type,
                  style: TextStyle(
                      color: Colors.black.withOpacity(0.6),
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.normal,
                      fontSize: SizeConfig.safeBlockHorizontal * 5),
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 10.0, top: checkForTablet(context) ? 3 : 5),
                alignment: Alignment.centerLeft,
                width: SizeConfig.blockSizeHorizontal * 100,
                child: Text(
                  names[0] == 'Monthly' ? 'MONTHLY' : 'ANNUAL',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                      fontSize: SizeConfig.safeBlockHorizontal * 6.5),
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 10.0, top: 0),
                alignment: Alignment.centerLeft,
                width: SizeConfig.blockSizeHorizontal * 100,
                child: Text(
                  'then only '.toUpperCase() + '£' + price,
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: SizeConfig.safeBlockHorizontal * 4),
                ),
              ),
            ],
          ),
        ),
      ),
    ]),
  );
}

bool checkForTablet(BuildContext context) {
  if (MediaQuery.of(context).size.width > 600) {
    return true;
  } else {
    return false;
  }
}
