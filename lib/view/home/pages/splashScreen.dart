import 'dart:async';

import 'package:attt/utils/colors.dart';
import 'package:attt/utils/globals.dart';
import 'package:attt/utils/size_config.dart';
import 'package:attt/view/home/pages/signin.dart';
import 'package:attt/view_model/signInViewModel.dart';
import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';

class CustomSplashScreen extends StatefulWidget {
  const CustomSplashScreen({Key key}) : super(key: key);

  @override
  _CustomSplashScreenState createState() => _CustomSplashScreenState();
}

class _CustomSplashScreenState extends State<CustomSplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 2), navigation);
  }

  navigation() {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (_) => Signin(),
        ),
        (Route<dynamic> route) => false);
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
        backgroundColor: MyColors().lightBlack,
        body: Center(
            child: Column(children: <Widget>[
          SizedBox(height: SizeConfig.safeBlockVertical * 35),
          ClipRRect(
            borderRadius: BorderRadius.circular(6.0),
            child: Image.asset(
              'assets/images/athlete-logo.png',
              width: SizeConfig.blockSizeHorizontal * 44.444,
            ),
          ),
        ])));
  }
}
