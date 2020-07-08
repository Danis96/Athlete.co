import 'package:attt/utils/colors.dart';
import 'package:attt/utils/size_config.dart';
import 'package:attt/view/home/pages/signin.dart';
import 'package:attt/view_model/signInViewModel.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomSplashScreen extends StatefulWidget {
  const CustomSplashScreen({Key key}) : super(key: key);

  @override
  _CustomSplashScreenState createState() => _CustomSplashScreenState();
}

class _CustomSplashScreenState extends State<CustomSplashScreen> {
  @override
  void initState() {
    super.initState();
    checkForPrefs();
  }

  checkForPrefs() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String email = prefs.getString('email');
    print('Check for prefs: ' + email.toString());
    if(email != null) SignInViewModel().autoLogIn(context);
    else navigation();
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
        child: Column(
          children: <Widget>[
            SizedBox(height: SizeConfig.safeBlockVertical * 35),
            ClipRRect(
              borderRadius: BorderRadius.circular(6.0),
              child: Image.asset(
                'assets/images/splash.png',
                width: SizeConfig.blockSizeHorizontal * 44.444,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
