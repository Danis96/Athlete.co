
import 'package:attt/utils/colors.dart';
import 'package:attt/utils/size_config.dart';
import 'package:attt/view/home/pages/signin.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

Widget priceContainer(String type, price, Package package, BuildContext context) {
  return GestureDetector(
    onTap: ()  => subscribe(package, context),
    child: Container(
      margin: EdgeInsets.only(
          top: SizeConfig.blockSizeVertical * 2,
          left: SizeConfig.blockSizeHorizontal * 3,
          right: SizeConfig.blockSizeHorizontal * 3),
      height: SizeConfig.blockSizeVertical * 12,
      color: MyColors().black,
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
                  fontSize: SizeConfig.safeBlockHorizontal * 6),
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 10.0, top: 10.0),
            alignment: Alignment.centerLeft,
            width: SizeConfig.blockSizeHorizontal * 100,
            child: Text(
              price,
              style: TextStyle(
                  color: MyColors().lightWhite,
                  fontWeight: FontWeight.w500,
                  fontSize: SizeConfig.safeBlockHorizontal * 5),
            ),
          ),
        ],
      ),
    ),
  );
}


subscribe(Package package, BuildContext context) async {
  // when the button is pressed we are trying to
  ///
  /// Makes a purchase. Returns a PurchaserInfo object
  /// then check if all entitlements are active [give them entitlement id]
  /// if user is pro, then show him the Signin, else print
 
  try {
    print(' u try sam usao  ++++++++++++++++++');
    PurchaserInfo purchaserInfo = await Purchases.purchasePackage(package);
     var isPro = purchaserInfo.entitlements.all["default-monthly"].isActive;
     print('IS PRO ==== ' + isPro.toString());
    if (isPro) {
      print(' u IS PRO sam usao  ++++++++++++++++++');
       Navigator.of(context).push(MaterialPageRoute(builder: (_) => Signin()));
    } else {
       print('Not a pro +++++++++++++');
    }
  } on PlatformException catch (e) {
     print(' u CATCH sam usao  ++++++++++++++++++');
    var errorCode = PurchasesErrorHelper.getErrorCode(e);
    if (errorCode == PurchasesErrorCode.purchaseCancelledError) {
      print("User cancelled ++++++++++++++");
    } else if (errorCode == PurchasesErrorCode.purchaseNotAllowedError) {
      print("User not allowed to purchase ++++++++++++++");
    }
  }
   
   print('KLASAAAAAAAAAA');
  
}
