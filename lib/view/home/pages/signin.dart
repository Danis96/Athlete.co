import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

class Signin extends StatelessWidget {
  const Signin({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 120.0, //SizeConfig.blockSizeVertical * 10,
              ),
              Container(
                child: Image.asset('assets/images/logo.png'),
              ),
              SizedBox(
                height: 310.0, //SizeConfig.blockSizeVertical * 10,,
              ),
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      width: 257,
                      child: SignInButton(
                        Buttons.Google,
                        padding: EdgeInsets.symmetric(horizontal: 7),
                        text: 'CONTINUE WITH GOOGLE',
                        onPressed: () {},
                      ),
                    ),
                    Container(
                      width: 276,
                      child: SignInButton(
                        Buttons.Facebook,
                        padding: EdgeInsets.symmetric(horizontal: 7),
                        text: 'CONTINUE WITH FACEBOOK',
                        onPressed: () {},
                      ),
                    ),
                    Container(
                      width: 262,
                      child: SignInButton(
                        Buttons.Twitter,
                        padding: EdgeInsets.symmetric(horizontal: 7),
                        text: 'CONTINUE WITH TWITTER',
                        onPressed: () {},
                      ),
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                    Container(
                      width: 344,
                      child: Text(
                        'By continuing, you agree to the\nTerms of Service & Privacy Policy.',
                        style: TextStyle(
                          color: Color.fromRGBO(255, 255, 255, 0.8),
                          fontSize: 12,
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
