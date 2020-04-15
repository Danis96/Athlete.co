import 'package:attt/interface/signinInterface.dart';
import 'package:attt/utils/globals.dart';
import 'package:attt/view/chooseAthlete/pages/chooseAthlete.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_twitter_login/flutter_twitter_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignInViewModel implements SignInInterface {
  FirebaseUser _currentUser;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  /// twitter sign in classes
  TwitterLoginResult _twitterLoginResult;
  TwitterLoginStatus _twitterLoginStatus;
  TwitterSession _currentUserTwitterSession;

  TwitterLogin twitterLogin;

  /// sign in with twitter
  @override
  signInWithTwitter(BuildContext context) async {
    /// waiting for keys
    twitterLogin = new TwitterLogin(consumerKey: '', consumerSecret: '');

    _twitterLoginResult = await twitterLogin.authorize();
    _currentUserTwitterSession = _twitterLoginResult.session;
    _twitterLoginStatus = _twitterLoginResult.status;

    switch (_twitterLoginStatus) {
      case TwitterLoginStatus.loggedIn:
        _currentUserTwitterSession = _twitterLoginResult.session;
        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (_) => ChooseAthlete(
                  name: userName,
                  email: userEmail,
                  photo: userPhoto,
                )));
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

  /// sign in with google
  final GoogleSignIn googleSignIn = GoogleSignIn();

  @override
  signInWithGoogle(BuildContext context) async {
    final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );

    final AuthResult authResult =
        await _firebaseAuth.signInWithCredential(credential);
    final FirebaseUser user = authResult.user;

    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);

    final FirebaseUser currentUser = await _firebaseAuth.currentUser();
    assert(user.uid == currentUser.uid);

    userEmail = currentUser.email;
    userName = currentUser.displayName;
    userPhoto = currentUser.photoUrl;
    platform = 'Google';
    loginUser();

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (_) => ChooseAthlete(
          name: userName,
          email: userEmail,
          photo: userPhoto,
        ),
      ),
    );
  }

  /// sign in with google
  static final FacebookLogin facebookSignIn = new FacebookLogin();

  @override
  Future<FirebaseUser> firebaseAuthWithFacebook(
      {@required FacebookAccessToken token, BuildContext context}) async {
    AuthCredential credential =
        FacebookAuthProvider.getCredential(accessToken: token.token);
    AuthResult facebookAuthResult =
        await _firebaseAuth.signInWithCredential(credential);
    final FirebaseUser user = facebookAuthResult.user;
    final FirebaseUser currentUser = await _firebaseAuth.currentUser();
    assert(user.uid == currentUser.uid);
    userEmail = currentUser.email;
    userName = currentUser.displayName;
    userPhoto = currentUser.photoUrl;
    platform = 'Facebook';
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (_) => ChooseAthlete(
          name: userName,
          email: userEmail,
          photo: userPhoto,
        ),
      ),
    );
    loginUser();
    return currentUser;
  }

  @override
  signInWithFacebook(BuildContext context) async {
    final FacebookLoginResult result = await facebookSignIn.logIn(['email']);
    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
        var firebaseUser = await firebaseAuthWithFacebook(
            token: result.accessToken, context: context);
        _currentUser = firebaseUser;
        print('Logovani user je: ' +
            firebaseUser.displayName +
            ' sa E-mailom: ' +
            firebaseUser.email);
        break;
      case FacebookLoginStatus.cancelledByUser:
        print('Canceled by user!');
        break;
      case FacebookLoginStatus.error:
        print('ERROR: ' + result.errorMessage.toString());
        break;
    }
  }

  @override
  signOutGoogle(BuildContext context) async {
    await googleSignIn.signOut();
    _currentUser = null;
    logout();
    print("User Sign Out");
  }

  @override
  signOutFacebook(BuildContext context) async {
    await facebookSignIn.logOut();
    _currentUser = null;
    logout();
    print("User Sign Out Faceboook");
  }

  @override
  autoLogIn(BuildContext context) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    userEmail = prefs.getString('email');
    userName = prefs.getString('displayName');
    userPhoto = prefs.getString('photoURL');
    if (userEmail != null) {
      isLoggedIn = true;
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (_) => ChooseAthlete(
            name: userName,
            email: userEmail,
            photo: userPhoto,
          ),
        ),
      );
    }
  }

  @override
  logout() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('email', null);
    prefs.setString('displayName', null);
    prefs.setString('photoURL', null);
    isLoggedIn = false;
  }

  @override
  loginUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('email', userEmail);
    prefs.setString('displayName', userName);
    prefs.setString('photoURL', userPhoto);
    isLoggedIn = true;
  }

  @override
  signOutTwitter(BuildContext context) async {
    await twitterLogin.logOut();
  }
}
