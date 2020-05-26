import 'package:attt/utils/text.dart';
import 'package:attt/view/chewieVideo/widgets/notifiers.dart';
import 'package:attt/view/chewieVideo/widgets/stopwatch.dart';
import 'package:attt/view/home/pages/splashScreen.dart';
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
//  // Platform messages are asynchronous, so we initialize in an async method.
//  Future<void> initPlatformState() async {
//    /// this we use to see debug prints in the console to know better what is going on
//    await Purchases.setDebugLogsEnabled(true);
//
//    /// here we add the public sdk that we get from RevenueCat
//    await Purchases.setup("IgFKVxutzsfoWiqOzeMxjVXWLntzmLCz");
//
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
//        appBar: AppBar(title: Text("Demo Subscription Tech387T2")),
//        body: Center(
//          child: Text("Loading..."),
//        ),
//      );
//    } else {
//      var isPro = _purchaserInfo.entitlements.active.containsKey('unlimited');
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
////      if (offering != null) {
////        final monthly = offering.monthly;
//////        final lifetime = offering.lifetime;
////        if (monthly != null ) {
//////            && lifetime != null) {
////          print(offering.monthly.toString() + 'OFFERING MONTHLY');
////          return Scaffold(
////              appBar: AppBar(title: Text("Purchase sell")),
////              body: Center(
////                  child: Column(
////                mainAxisSize: MainAxisSize.min,
////                children: <Widget>[
////                  PurchaseButton(package: monthly),
//////                  PurchaseButton(package: lifetime)
////                ],
////              )));
////        }
////        else {
////          print('Else3');
////        }
////      } else {
////        print('Else2');
////      }
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
//        /// when the button is pressed we are trying to
//        ///
//        /// Makes a purchase. Returns a PurchaserInfo object
//        /// then check if all entitlements are active [give them entitlement id]
//        /// if user is pro, then show him the CatsScreen, else print
//        ///
//        try {
//          PurchaserInfo purchaserInfo =
//              await Purchases.purchasePackage(package);
//          var isPro = purchaserInfo.entitlements.all["unlimited"].isActive;
//          if (isPro) {
//            return ProScreen();
//          } else
//            print('You are not a pro, you are a looser.');
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
//import 'dart:math' as math;
//
//import 'package:flutter/material.dart';
//
//void main() => runApp(MyApp());
//
//class MyApp extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    return MaterialApp(
//      home: CountDownTimer(),
//      debugShowCheckedModeBanner: false,
//      theme: ThemeData(
//        iconTheme: IconThemeData(
//          color: Colors.white,
//        ),
//        accentColor: Colors.red,
//      ),
//    );
//  }
//}
//
//class CountDownTimer extends StatefulWidget {
//  @override
//  _CountDownTimerState createState() => _CountDownTimerState();
//}
//
//class _CountDownTimerState extends State<CountDownTimer>
//    with TickerProviderStateMixin {
//  AnimationController controller;
//
//  String get timerString {
//    Duration duration = controller.duration * controller.value;
//    return '${duration.inMinutes}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
//  }
//
//  @override
//  void initState() {
//    super.initState();
//    controller = AnimationController(
//      vsync: this,
//      duration: Duration(seconds: 10),
//    );
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    ThemeData themeData = Theme.of(context);
//    return Scaffold(
//      backgroundColor: Colors.white10,
//      body: AnimatedBuilder(
//          animation: controller,
//          builder: (context, child) {
//            return Stack(
//              children: <Widget>[
//                Align(
//                  alignment: Alignment.bottomCenter,
//                  child:
//                  Container(
//                    color: Colors.amber,
//                    height:
//                    controller.value * MediaQuery.of(context).size.height,
//                  ),
//                ),
//                Padding(
//                  padding: EdgeInsets.all(8.0),
//                  child: Column(
//                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                    children: <Widget>[
//                      Expanded(
//                        child: Align(
//                          alignment: FractionalOffset.center,
//                          child: AspectRatio(
//                            aspectRatio: 1.0,
//                            child: Stack(
//                              children: <Widget>[
//                                Positioned.fill(
//                                  child: CustomPaint(
//                                      painter: CustomTimerPainter(
//                                        animation: controller,
//                                        backgroundColor: Colors.blue,
//                                        color: themeData.indicatorColor,
//                                      )),
//                                ),
//                                Align(
//                                  alignment: FractionalOffset.center,
//                                  child: Column(
//                                    mainAxisAlignment:
//                                    MainAxisAlignment.spaceEvenly,
//                                    crossAxisAlignment:
//                                    CrossAxisAlignment.center,
//                                    children: <Widget>[
//                                      Text(
//                                        "Count Down Timer",
//                                        style: TextStyle(
//                                            fontSize: 20.0,
//                                            color: Colors.white),
//                                      ),
//                                      Text(
//                                        timerString,
//                                        style: TextStyle(
//                                            fontSize: 112.0,
//                                            color: Colors.white),
//                                      ),
//                                    ],
//                                  ),
//                                ),
//                              ],
//                            ),
//                          ),
//                        ),
//                      ),
//                      AnimatedBuilder(
//                          animation: controller,
//                          builder: (context, child) {
//                            return FloatingActionButton.extended(
//                                onPressed: () {
//                                  if (controller.isAnimating)
//                                    controller.stop();
//                                  else {
//                                    controller.reverse(
//                                        from: controller.value == 0.0
//                                            ? 1.0
//                                            : controller.value);
//                                  }
//                                },
//                                icon: Icon(controller.isAnimating
//                                    ? Icons.pause
//                                    : Icons.play_arrow),
//                                label: Text(
//                                    controller.isAnimating ? "Pause" : "Play"));
//                          }),
//                    ],
//                  ),
//                ),
//              ],
//            );
//          }),
//    );
//  }
//}

