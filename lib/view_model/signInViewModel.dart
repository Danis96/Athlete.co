import 'package:attt/interface/signinInterface.dart';
import 'package:attt/view/chooseAthlete/pages/chooseAthlete.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_twitter_login/flutter_twitter_login.dart';

class SignInViewModel implements SignInInterface {
  FirebaseUser _currentUser;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  TwitterLoginResult _twitterLoginResult;
  TwitterLoginStatus _twitterLoginStatus;
  TwitterSession _currentUserTwitterSession;

 /// sign in with twitter
  @override
  signInWithTwitter(BuildContext context) async {
    /// waiting for keys
    final TwitterLogin twitterLogin =
        new TwitterLogin(consumerKey: '', consumerSecret: '');

    _twitterLoginResult = await twitterLogin.authorize();
    _currentUserTwitterSession = _twitterLoginResult.session;
    _twitterLoginStatus = _twitterLoginResult.status;

    switch (_twitterLoginStatus) {
      case TwitterLoginStatus.loggedIn:
        _currentUserTwitterSession = _twitterLoginResult.session;
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (_) => ChooseAthlete()));
        break;

      case TwitterLoginStatus.cancelledByUser:
        print('Sign in cancelled by user.');
        break;

      case TwitterLoginStatus.error:
        print('An error occurred signing with Twitter.');
        break;
    }

    AuthCredential _authCredential = TwitterAuthProvider.getCredential(
        authToken: _currentUserTwitterSession?.token ?? '',
        authTokenSecret: _currentUserTwitterSession?.secret ?? '');
    AuthResult result =
        await _firebaseAuth.signInWithCredential(_authCredential);
    _currentUser = result.user;
  }
}
