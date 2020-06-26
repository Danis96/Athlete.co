import 'package:attt/utils/text.dart';
import 'package:attt/view/chewieVideo/widgets/indicatorWidgets/notifiers/changeColorNotifier.dart';
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
      home: ListenableProvider<ChangeBtnColor>(
         create: (_) => ChangeBtnColor('red'),
        child: CustomSplashScreen(),
      ),
    );
  }
}
