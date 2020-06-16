import 'package:attt/utils/text.dart';
import 'package:attt/view/chewieVideo/widgets/notifiers.dart';
import 'package:attt/view/chewieVideo/widgets/stopwatch.dart';
import 'package:attt/view/home/pages/splashScreen.dart';
// import 'file:///C:/Users/danis.dev/Desktop/Athlete.co/lib/view/subscription/page/subscription.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:provider/provider.dart';

void main() {
  final timerService = TimerService();
  InAppPurchaseConnection.enablePendingPurchases();
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    runApp(
      TimerServiceProvider(
          // provide timer service to all widgets of your app
          service: timerService,
          child: Athlete()),
    );
}

class Athlete extends StatelessWidget  {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: MyText().mainTitle,
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      home: ListenableProvider<Notifiers>(
         create: (_) => Notifiers(false),
        child: CustomSplashScreen(),
      ),
    );
  }
}
//
//
//import 'package:flutter/material.dart';
//import 'dart:async';
//
//import 'package:flutter/services.dart';
//import 'package:purchases_flutter/purchases_flutter.dart';
//
//void main() {
//  runApp(MaterialApp(
//    title: 'RevenueCat Sample',
//    home: InitialScreen(),
//  ));
//}
//
//class InitialScreen extends StatefulWidget {
//  @override
//  State<StatefulWidget> createState() => _MyAppState();
//}
//
//class _MyAppState extends State<InitialScreen> {
//  PurchaserInfo _purchaserInfo;
//  Offerings _offerings;
//
//  @override
//  void initState() {
//    super.initState();
//    initPlatformState();
//  }
//
//  Future<void> initPlatformState() async {
//    await Purchases.setDebugLogsEnabled(true);
//    await Purchases.setup("tracruyrpuYrnZONKnHsDuYBerGnpBRn");
//    PurchaserInfo purchaserInfo = await Purchases.getPurchaserInfo();
//    Offerings offerings = await Purchases.getOfferings();
//    if (!mounted) return;
//
//    setState(() {
//      _purchaserInfo = purchaserInfo;
//      _offerings = offerings;
//    });
//  }

// Platform messages are asynchronous, so we initialize in an async method.
//  Future<void> initPlatformState() async {
//    await Purchases.setDebugLogsEnabled(true);
//    await Purchases.setup("tracruyrpuYrnZONKnHsDuYBerGnpBRn");
//    Purchases.addAttributionData({}, PurchasesAttributionNetwork.facebook);
//    PurchaserInfo purchaserInfo = await Purchases.getPurchaserInfo();
//    Offerings offerings = await Purchases.getOfferings();
//    // If the widget was removed from the tree while the asynchronous platform
//    // message was in flight, we want to discard the reply rather than calling
//    // setState to update our non-existent appearance.
//    if (!mounted) return;
//
//    setState(() {
//      _purchaserInfo = purchaserInfo;
//      _offerings = offerings;
//    });
//  }

//  getOff() async {
//    try {
//      Offerings offerings = await Purchases.getOfferings();
//      if (offerings.current != null) {
//        UpsellScreen(offerings: offerings,);
//      }
//    } on PlatformException catch (e) {
//      // optional error handling
//    }
//  }
//  @override
//  Widget build(BuildContext context) {
//   getOff();
//    if (_purchaserInfo == null) {
//      return Scaffold(
//        appBar: AppBar(title: Text("RevenueCat Sample App")),
//        body: Center(
//          child: Text("Loading..."),
//        ),
//      );
//    } else {
//      var isPro =
//          _purchaserInfo.entitlements.active.containsKey("monthly");
//      if (isPro) {
//        print('USER JE PRO');
////        return CatsScreen();
//      } else {
//        return UpsellScreen(
//          offerings: _offerings,
//        );
//      }
//    }
//  }
//}
////
//class UpsellScreen extends StatelessWidget {
//  final Offerings offerings;
//
//  UpsellScreen({Key key, @required this.offerings}) : super(key: key);
//
//  @override
//  Widget build(BuildContext context) {
//    if (offerings != null) {
//      final offering = offerings.current;
//      if (offering != null) {
//        final monthly = offering.monthly;
//        final lifetime = offering.lifetime;
//        if (monthly != null && lifetime != null) {
//          return Scaffold(
//              appBar: AppBar(title: Text("Upsell Screen")),
//              body: Center(
//                  child: Column(
//                mainAxisSize: MainAxisSize.min,
//                children: <Widget>[
//                 Btn(package:monthly),
//                  Btn(package:lifetime),
////                  PurchaseButton(package: monthly),
////                  PurchaseButton(package: lifetime)
//                ],
//              )));
//        }
//      }
//    }
//    return Scaffold(
//        appBar: AppBar(title: Text("Upsell Screen")),
//        body: Center(
//          child: Text("Loading..."),
//        ));
//  }
//}
//
//
//class Btn extends StatefulWidget {
//
//  final Package package;
//
//  Btn({this.package});
//
//  @override
//  _BtnState createState() => _BtnState();
//}
//
//class _BtnState extends State<Btn> {
//
//  var isPro;
//
//  @override
//  Widget build(BuildContext context) {
//    return RaisedButton(onPressed: () async {
//
//
//        PurchaserInfo purchaserInfo = await Purchases.purchasePackage(widget.package);
//        print(purchaserInfo.toString() + ' PURCHASER INFO');
//
//
//        isPro = purchaserInfo.entitlements.all["monthly"].isActive;
//        if (isPro) {
//          print('user IS PRO');
//        }
//        print('USER IS + $isPro');
//
//
//    });
//  }
//}
//
//class PurchaseButton extends StatelessWidget {
//  final Package package;
//
//  PurchaseButton({Key key, @required this.package}) : super(key: key);
//
//  @override
//  Widget build(BuildContext context) {
//    return RaisedButton(
//      onPressed: () async {
//        try {
//          PurchaserInfo purchaserInfo =
//              await Purchases.purchasePackage(package);
//          print(purchaserInfo);
//          var isPro =
//              purchaserInfo.entitlements.all["default-monthly"].isActive;
//          if (isPro) {
//            return Navigator.of(context)
//                .push(MaterialPageRoute(builder: (_) => CatsScreen()));
//          }
//        } on PlatformException catch (e) {
//          var errorCode = PurchasesErrorHelper.getErrorCode(e);
//          if (errorCode == PurchasesErrorCode.purchaseCancelledError) {
//            print("User cancelled");
//          } else if (errorCode == PurchasesErrorCode.purchaseNotAllowedError) {
//            print("User not allowed to purchase");
//          }
//        }
//        return InitialScreen();
//      },
//      child: Text("Buy - (${package.product.priceString})"),
//    );
//  }
//}
//
//class CatsScreen extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//        appBar: AppBar(title: Text("Cats Screen")),
//        body: Center(
//          child: Text("User is pro"),
//        ));
//  }
//}
