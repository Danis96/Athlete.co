import 'package:attt/view/home/pages/splashScreen.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Athlete.co',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: CustomSplashScreen(),
    );
  }
}