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

  ///Facebook Login instance used for Facebook Login process
  static final FacebookLogin facebookSignIn = new FacebookLogin();

  ///Method that is being executed if Loggin Status is leggedIn
  @override
  Future<FirebaseUser> firebaseAuthWithFacebook(
      {@required FacebookAccessToken token, BuildContext context}) async {
    ///Gathering credentials from Facebook Access Token passed from
    ///
    ///signInWithFacebook() method after Facebook Login process succesfully completed.
    AuthCredential credential =
        FacebookAuthProvider.getCredential(accessToken: token.token);
    ///Signing in user to Firebase using FirebaseAuth and credentials from previous step
    AuthResult facebookAuthResult =
        await _firebaseAuth.signInWithCredential(credential);
    ///Creating a user from Firebase Authentication process's result
    final FirebaseUser user = facebookAuthResult.user;
    final FirebaseUser currentUser = await _firebaseAuth.currentUser();
    assert(user.uid == currentUser.uid);

    ///Populating variables used later in application
    userEmail = currentUser.email;
    userName = currentUser.displayName;
    userPhoto = currentUser.photoUrl;
    platform = 'Facebook';
    
    ///Navigating logged user into application
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (_) => ChooseAthlete(
          name: userName,
          email: userEmail,
          photo: userPhoto,
        ),
      ),
    );
    
    ///Logging user to shared preference with aim to
    ///
    ///have the user later for autologging
    loginUser();
    return currentUser;
  }

  ///Method which initializes the Facebook Login
  @override
  signInWithFacebook(BuildContext context) async {
    ///Logging user using Facebook Account
    final FacebookLoginResult result = await facebookSignIn.logIn(['email']);
    ///Checking login status of a user after his commjnication 
    ///with application and Facebook login
    switch (result.status) {
      ///Case when user is successfully logged in
      case FacebookLoginStatus.loggedIn:
        ///Creating a user according to logged Facebook account
        ///This user is later used for gathering information from database
        var firebaseUser = await firebaseAuthWithFacebook(
            token: result.accessToken, context: context);
        _currentUser = firebaseUser;
        break;
      ///Case when user canceles the loggin process
      case FacebookLoginStatus.cancelledByUser:
        print('Canceled by user!');
        break;
      ///Case of any error occured during loggin process
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

  ///Method that auotlogins a user if data and cach are not cleared
  ///
  ///and it is called on Sign in Screen in the initState() function
  @override
  autoLogIn(BuildContext context) async {
    ///Creating instance of Shared Preference
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    ///Getting users info from shared preference
    userEmail = prefs.getString('email');
    userName = prefs.getString('displayName');
    userPhoto = prefs.getString('photoURL');

    ///Checking if there is a user logged in, only if there are
    ///
    ///records in shared preference, user is directly redirected
    ///to ChooseAthelete Screen
    if (userEmail != null && userName != null && userPhoto != null) {
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

  ///Method that deletes a user from cach and sets records to null
  ///
  ///in Shared Preference. This method is called when user clicks
  ///on Sign out button
  @override
  logout() async {
    ///Creating instance of Shared Preference
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    ///Setting records and user's info in Shared Preference to null
    prefs.setString('email', null);
    prefs.setString('displayName', null);
    prefs.setString('photoURL', null);
    isLoggedIn = false;
  }

  ///Method that logins a user and writes user's info 
  ///
  ///into Shared Preference. This method is called whenever user clicks
  ///on any of Sign in buttons
  @override
  loginUser() async {
    ///Creating instance of Shared Preference
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    ///Setting records and user's info in Shared Preference to current 
    ///
    ///user's info
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
