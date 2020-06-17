import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';

abstract class SignInInterface {
  signInWithTwitter(
    BuildContext context,
  );
  signInWithGoogle(BuildContext context);
  signOutGoogle(BuildContext context);
//  Future<FirebaseUser> firebaseAuthWithFacebook(
//      {@required FacebookAccessToken token, BuildContext context});
  signInWithFacebook(BuildContext context);
  signOutFacebook(BuildContext context);
  autoLogIn(BuildContext context);
  logout();
  loginUser();
  signOutTwitter(BuildContext context);
  redirectToPrivacyAndTerms();
  createUser(
      String name, String email, String image, String userUID, String platform);
  Future<List<DocumentSnapshot>> getCurrentUserDocument(String email);
  Future<bool> doesUserAlreadyExist(String email);
  Future<List<DocumentSnapshot>> getCurrentUserTrainer(String trainer);
  updateUserWithTrainer(
      DocumentSnapshot userDocument, String email, String trainer);
  Future<int> getCurrentUserTrainerWeeks(String trainer);
  updateUserProgress(DocumentSnapshot userDocument, List<dynamic> listToKeep);
}
