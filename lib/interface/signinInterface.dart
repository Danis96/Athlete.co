

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';

abstract class SignInInterface {
  signInWithTwitter(BuildContext context);
  signInWithGoogle(BuildContext context);
  signOutGoogle(BuildContext context);
}