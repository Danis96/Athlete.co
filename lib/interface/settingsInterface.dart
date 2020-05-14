import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

abstract class SettingsInterface {
    changeAthlete(BuildContext context,DocumentSnapshot userDocument, String userUID);
    /// whats app from trainingPlan
    goToTermsAndPrivacy(BuildContext context);
    logOut(BuildContext context,String platform);
    navigateToSignIn(BuildContext context);
}