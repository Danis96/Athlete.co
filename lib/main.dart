
import 'package:attt/view/home/pages/splashScreen.dart';
import 'package:flutter/material.dart';

void main() => runApp(Athlete());

class Athlete extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Athlete.co',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      home: CustomSplashScreen(),
    );
  }
}
