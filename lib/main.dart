import 'package:attt/utils/text.dart';
import 'package:attt/view/chewieVideo/widgets/notifiers.dart';
import 'package:attt/view/chewieVideo/widgets/stopwatch.dart';
import 'package:attt/view/home/pages/splashScreen.dart';
//import 'file:///C:/Users/danis.dev/Desktop/Athlete.co/lib/view/subscription/page/subscription.dart';
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
//import 'package:attt/view/home/pages/signin.dart';
//import 'package:flutter/material.dart';
//import 'dart:async';
//
//import 'package:flutter/services.dart';
//import 'package:purchases_flutter/purchases_flutter.dart';
//
//void main() {
//  runApp(MaterialApp(
//    title: 'DemoSub Sample',
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
//
//
//  @override
//  Widget build(BuildContext context) {
//    if (_purchaserInfo == null) {
//      return Scaffold(
//        appBar: AppBar(title: Text("Demo Subscription Tech387T2")),
//        body: Center(
//          child: Text("Loading..."),
//        ),
//      );
//    } else {
//      var isPro = _purchaserInfo.entitlements.active.containsKey('default-monthly');
//      if (isPro) {
//        return ProScreen();
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
//      if(offerings.current != null && offerings.current.availablePackages.isNotEmpty) {
//          print(offerings.current);
//      } else print(offerings);
//      if (offering != null) {
//        final monthly = offering.monthly;
//        final lifetime = offering.lifetime;
//        if (monthly != null
//            && lifetime != null) {
//          print(offering.monthly.toString() + 'OFFERING MONTHLY');
//          return Scaffold(
//              appBar: AppBar(title: Text("Purchase sell")),
//              body: Center(
//                  child: Column(
//                mainAxisSize: MainAxisSize.min,
//                children: <Widget>[
//                  PurchaseButton(package: monthly),
//                  PurchaseButton(package: lifetime)
//                ],
//              )));
//        }
//        else {
//          print('Else3');
//        }
//      } else {
//        print('Else2');
//      }
//    } else {
//      print('Else1');
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
//
//      },
//      child: Text("Buy - (${package.product.priceString})"),
//    );
//  }
//}
//
//class ProScreen extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//        appBar: AppBar(title: Text("Pro Screen")),
//        body: Center(
//          child: Text("User is pro"),
//        ));
//  }
//}