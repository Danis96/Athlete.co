import 'package:attt/interface/settingsInterface.dart';
import 'package:attt/utils/customScreenAnimation.dart';
import 'package:attt/view/chooseAthlete/pages/chooseAthlete.dart';
import 'package:attt/view/home/pages/signin.dart';
import 'package:attt/view/settings/widgets/privacyAndTerms.dart';
import 'package:attt/view_model/signInViewModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SettingsViewModel implements SettingsInterface {
  @override
  changeAthlete(
      BuildContext context, DocumentSnapshot userDocument, String userUID) {
    Navigator.of(context).pushAndRemoveUntil(
        CardAnimationTween(
          widget: ChooseAthlete(
            userDocument: userDocument,
            name: userDocument['display_name'],
            email: userDocument['email'],
            photo: userDocument['image'],
            userUID: userUID,
          ),
        ),
        (Route<dynamic> route) => false);
  }

  @override
  goToTermsAndPrivacy(BuildContext context) {
    Navigator.of(context).push(CardAnimationTween(widget: PrivacyAndTerms()));
  }

  @override
  navigateToSignIn(BuildContext context) {
    Navigator.of(context).pushReplacement(CardAnimationTween(widget: Signin()));
  }

  /// check users platform the do login for specific platform
  @override
  logOut(BuildContext context, String platform) {
    if (platform == 'Google') {
      SignInViewModel().signOutGoogle(context);
      SignInViewModel().logout();
      navigateToSignIn(context);
    } else if (platform == 'Facebook') {
      SignInViewModel().signOutFacebook(context);
      SignInViewModel().logout();
      navigateToSignIn(context);
    } else if (platform == 'Twitter') {
      SignInViewModel().signOutTwitter(context);
      SignInViewModel().logout();
      navigateToSignIn(context);
    }
  }
}
