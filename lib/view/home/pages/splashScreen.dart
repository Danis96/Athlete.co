import 'package:attt/utils/colors.dart';
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
      backgroundColor: MyColors().lightBlack,
      seconds: 2,
      title: Text(''),
      navigateAfterSeconds: new Signin(),
      photoSize: SizeConfig.safeBlockHorizontal * 50,
      loaderColor: MyColors().lightBlack,
    );
  }
}
