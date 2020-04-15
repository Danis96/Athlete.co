import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';

abstract class SignInInterface {
  signInWithTwitter(BuildContext context);
  signInWithGoogle(BuildContext context);
  signOutGoogle(BuildContext context);
  Future<FirebaseUser> firebaseAuthWithFacebook({@required FacebookAccessToken token, BuildContext context});
  Future<Null> signInWithFacebook(BuildContext context);
  signOutFacebook(BuildContext context);
  void autoLogIn(BuildContext context);
  Future<Null> logout();
  Future<Null> loginUser();
  signOutTwitter(BuildContext context);
}