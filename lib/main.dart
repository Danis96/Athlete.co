import 'package:attt/utils/text.dart';
import 'package:attt/view/chewieVideo/widgets/stopwatch.dart';
import 'package:attt/view/home/pages/splashScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  final timerService = TimerService();
  WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
  //     .then((_) {
    runApp(
      TimerServiceProvider(
          // provide timer service to all widgets of your app
          service: timerService,
          child: Athlete()),
    );
  // });
}

class Athlete extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: MyText().mainTitle,
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      home: CustomSplashScreen(),
    );
  }
}
