import 'package:attt/utils/colors.dart';
import 'package:attt/utils/size_config.dart';
import 'package:attt/view/subscription/page/widgets/headlineCont.dart';
import 'package:attt/view/subscription/page/widgets/price.dart';
import 'package:attt/view/subscription/page/widgets/reviews.dart';
import 'package:attt/view/subscription/page/widgets/starRow.dart';
import 'package:attt/view/subscription/page/widgets/textCont.dart';
import 'package:attt/view/subscription/page/widgets/textReviews.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'dart:async';
import 'package:purchases_flutter/purchases_flutter.dart';

class SubscriptionClass extends StatefulWidget {
  @override
  _SubscriptionClassState createState() => _SubscriptionClassState();
}

class _SubscriptionClassState extends State<SubscriptionClass> {
  PurchaserInfo _purchaserInfo;
  Offerings _offerings;

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  String priceMonthly = '\$19.99';
  String priceLifetime = '\$99.99';

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    /// this we use to see debug prints in the console to know better what is going on
    await Purchases.setDebugLogsEnabled(true);

    /// here we add the public sdk that we get from RevenueCat
    await Purchases.setup("tracruyrpuYrnZONKnHsDuYBerGnpBRn");

//    Purchases.addAttributionData({}, PurchasesAttributionNetwork.facebook);
    PurchaserInfo purchaserInfo = await Purchases.getPurchaserInfo();
    Offerings offerings = await Purchases.getOfferings();
    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _purchaserInfo = purchaserInfo;
      _offerings = offerings;
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    if (_offerings != null) {
      final offering = _offerings.current;
      if (_offerings.current != null &&
          _offerings.current.availablePackages.isNotEmpty)
        print(_offerings.current);
      else
        print(_offerings);

      if (offering != null) {
        final monthly = offering.monthly;
        final lifetime = offering.lifetime;
        if (monthly != null
            && lifetime != null)
    {
          print(offering.monthly.toString() + 'OFFERING MONTHLY');
          return Scaffold(
            backgroundColor: MyColors().lightBlack,
            body: Padding(
              padding: const EdgeInsets.all(10.0),
              child: ListView(
                shrinkWrap: true,
                children: [
                  headlineStart(),
                  priceContainer(
                      '1 month for $priceMonthly',
                      ' Subscription will be renewed \n after 1 month',
                      '7 DAYS',
                      'FREE TRIAL',
                      monthly,
                      context),
                  priceContainer(
                      'Lifetime for $priceLifetime',
                      'Subscription will not be renewed',
                      '7 DAYS',
                      'FREE TRIAL',
                      lifetime,
                      context),
                  textCont(),
                  starsRow(),
                  reviews(ReviewText().name1, ReviewText().rev1),
                  reviews(ReviewText().name2, ReviewText().rev2),
                  reviews(ReviewText().name3, ReviewText().rev3),
                  reviews(ReviewText().name4, ReviewText().rev4),
                ],
              ),
            ),
          );
        } else {
          print('Else3');
        }
      } else {
        print('Else2');
      }
    } else {
      print('Else 1');
    }
    return Scaffold(
        backgroundColor: MyColors().lightBlack,
        body: Center(
          child: CircularProgressIndicator(),
        ));
  }
}
