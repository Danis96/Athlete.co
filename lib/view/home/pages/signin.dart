import 'package:attt/utils/size_config.dart';
import 'package:attt/view_model/signInViewModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

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
      body: Center(
        child: Container(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: SizeConfig.blockSizeVertical * 19,
              ),
              Container(
                child: Image.asset('assets/images/logo.png'),
              ),
              SizedBox(
                height: SizeConfig.blockSizeVertical * 42,
              ),
              Container(
                child: Column(
                  children: <Widget>[
                    Container(
                      width: SizeConfig.blockSizeHorizontal * 72,
                      child: SignInButton(
                        Buttons.Google,
                        text: 'CONTINUE WITH GOOGLE',
                        onPressed: () =>
                            SignInViewModel().signInWithGoogle(context),
                      ),
                    ),
                    Container(
                      width: SizeConfig.blockSizeHorizontal * 79,
                      child: SignInButton(
                        Buttons.Facebook,
                        text: 'CONTINUE WITH FACEBOOK',
                        onPressed: () => SignInViewModel().signInWithFacebook(context),
                      ),
                    ),
                    Container(
                      width: SizeConfig.blockSizeHorizontal * 73,
                      child: SignInButton(
                        Buttons.Twitter,
                        text: 'CONTINUE WITH TWITTER',
                        /// za ovo cekam jos keys
                        onPressed: () =>
                            SignInViewModel().signInWithTwitter(context),
                      ),
                    ),
                    SizedBox(
                      height: SizeConfig.blockSizeVertical * 1.25,
                    ),
                    Container(
                      width: SizeConfig.blockSizeHorizontal * 96,
                      child: Text(
                        'By continuing, you agree to the\nTerms of Service & Privacy Policy.',
                        style: TextStyle(
                          color: Color.fromRGBO(255, 255, 255, 0.8),
                          fontSize: SizeConfig.safeBlockHorizontal * 3.5,
                          fontFamily: 'Roboto',
                        ),
                        textAlign: TextAlign.center,
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
