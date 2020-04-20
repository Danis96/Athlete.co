import 'package:attt/utils/size_config.dart';
import 'package:attt/utils/text.dart';
import 'package:attt/view/home/widgets/buttonList.dart';
import 'package:attt/view/home/widgets/logo.dart';
import 'package:attt/view_model/signInViewModel.dart';
import 'package:flutter/material.dart';

class Signin extends StatefulWidget {
  const Signin({Key key}) : super(key: key);

  @override
  _SigninState createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  bool isLoggedIn = false;
  String name = '';

  @override
  void initState() {
    super.initState();
    SignInViewModel().autoLogIn(context);
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Color.fromRGBO(28, 28, 28, 1.0),
      body: Center(
        child: Container(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: SizeConfig.blockSizeVertical * 19,
              ),
              logo(context),
              SizedBox(
                height: SizeConfig.blockSizeVertical * 40,
              ),
              buttonList(context)
            ],
          ),
        ),
      ),
    );
  }
}
