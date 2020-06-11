import 'package:attt/utils/text.dart';
import 'package:attt/view/chewieVideo/widgets/notifiers.dart';
import 'package:attt/view/chewieVideo/widgets/stopwatch.dart';
import 'package:attt/view/home/pages/splashScreen.dart';
// import 'file:///C:/Users/danis.dev/Desktop/Athlete.co/lib/view/subscription/page/subscription.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

void main() {
  final timerService = TimerService();
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
//  // Platform messages are asynchronous, so we initialize in an async method.
//  Future<void> initPlatformState() async {
//    await Purchases.setDebugLogsEnabled(true);
//    await Purchases.setup("uMRtYohBNQwHzTNMGFzgVjLqLRcFMQvh");
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
//
//  @override
//  Widget build(BuildContext context) {
//    if (_purchaserInfo == null) {
//      return Scaffold(
//        appBar: AppBar(title: Text("RevenueCat Sample App")),
//        body: Center(
//          child: Text("Loading..."),
//        ),
//      );
//    } else {
//      var isPro = _purchaserInfo.entitlements.active.containsKey("default");
//      if (isPro) {
//        return CatsScreen();
//      } else {
//        return UpsellScreen(
//          offerings: _offerings,
//        );
//      }
//    }
//  }
//}
//
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
////        final lifetime = offering.lifetime;
//        if (monthly != null ) {
//          return Scaffold(
//              appBar: AppBar(title: Text("Upsell Screen")),
//              body: Center(
//                  child: Column(
//                    mainAxisSize: MainAxisSize.min,
//                    children: <Widget>[
//                      PurchaseButton(package: monthly),
////                      PurchaseButton(package: lifetime)
//                    ],
//                  )));
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
//class PurchaseButton extends StatelessWidget {
//  final Package package;
//
//  PurchaseButton({Key key, @required this.package}) : super(key: key);
//
//  @override
//  Widget build(BuildContext context) {
//    return RaisedButton(
//      onPressed: () async {
//        print('ON PRESSED');
//        try {
//          print('TRY');
//          PurchaserInfo purchaserInfo =
//          await Purchases.purchasePackage(package);
//          var isPro = purchaserInfo.entitlements.all["default"].isActive;
//          print('IS PRO : ' + isPro.toString());
//          if (isPro) {
//            print('IS PRO');
//            return CatsScreen();
//
//          }
//        } on PlatformException catch (e) {
//          print('CATCH');
//          var errorCode = PurchasesErrorHelper.getErrorCode(e);
//          if (errorCode == PurchasesErrorCode.purchaseCancelledError) {
//            print("User cancelled");
//          } else if (errorCode == PurchasesErrorCode.purchaseNotAllowedError) {
//            print("User not allowed to purchase");
//          } else if (errorCode == PurchasesErrorCode.unknownError) {
//            print('Unknown error');
//          } else if (errorCode == PurchasesErrorCode.unexpectedBackendResponseError) {
//            print('Bekend error');
//
//          }
//          print(errorCode.toString() + ' ERROR CODE');
//
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