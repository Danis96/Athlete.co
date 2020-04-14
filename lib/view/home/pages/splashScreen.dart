import 'package:attt/view/home/pages/signin.dart';
import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';

class CustomSplashScreen extends StatelessWidget {
  const CustomSplashScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      seconds: 2,
      navigateAfterSeconds: new Signin(),
      image: Image.asset('assets/images/logo.png'),
      photoSize: 100,
      loaderColor: Theme.of(context).primaryColor,
    );
  }
}
