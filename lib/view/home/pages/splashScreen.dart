import 'package:attt/utils/size_config.dart';
import 'package:attt/view/home/pages/signin.dart';
import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';

class CustomSplashScreen extends StatelessWidget {
  const CustomSplashScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SplashScreen(
      backgroundColor: ThemeData.dark().backgroundColor,
      seconds: 2,
      navigateAfterSeconds: new Signin(),
      image: Image.asset('assets/images/logo.png'),
      photoSize: SizeConfig.safeBlockHorizontal * 50,
      loaderColor: ThemeData.dark().backgroundColor,
    );
  }
}
