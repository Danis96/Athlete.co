import 'package:attt/interface/signinInterface.dart';
import 'package:attt/utils/dialog.dart';
import 'package:attt/utils/globals.dart';
import 'package:attt/utils/text.dart';
import 'package:attt/view/chooseAthlete/pages/chooseAthlete.dart';
import 'package:attt/view/trainingPlan/pages/trainingPlan.dart';
import 'package:attt/view_model/trainingPlanViewModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_twitter_login/flutter_twitter_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

/// dialog key
final GlobalKey<State> _keyLoader = new GlobalKey<State>();

class SignInViewModel implements SignInInterface {
  FirebaseUser _currentUser;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  List<DocumentSnapshot> currentUserDocuments = [];
  List<DocumentSnapshot> currentUserTrainerDocuments = [];
  DocumentSnapshot currentUserDocument;
  DocumentSnapshot currentUserTrainerDocument;
  String currentUserTrainerName;
  String currentUserTrainingPlanDuration;
  String currentUserTrainingPlan;

  /// twitter sign in classes
  TwitterLoginResult _twitterLoginResult;
  TwitterLoginStatus _twitterLoginStatus;
  TwitterSession _currentUserTwitterSession;

  TwitterLogin twitterLogin;

  /// sign in with twitter
  ///
  /// we simply switch over [_twitterLoginStatus] and for every case
  /// we do something
  @override
  signInWithTwitter(BuildContext context) async {
    Dialogs.showLoadingDialog(context, _keyLoader);

    /// waiting for keys
    twitterLogin = new TwitterLogin(consumerKey: '', consumerSecret: '');

    _twitterLoginResult = await twitterLogin.authorize();
    _currentUserTwitterSession = _twitterLoginResult.session;
    _twitterLoginStatus = _twitterLoginResult.status;

    switch (_twitterLoginStatus) {

      /// if logging is success we navigate to [ChooseAthlete page]
      case TwitterLoginStatus.loggedIn:
        _currentUserTwitterSession = _twitterLoginResult.session;
        break;

      case TwitterLoginStatus.cancelledByUser:
        print('Sign in cancelled by user.');
        break;

      case TwitterLoginStatus.error:
        print('An error occurred signing with Twitter.');
        break;
    }

    ///  we get credentials and define them to [authToken & authTokenSecret]
    AuthCredential _authCredential = TwitterAuthProvider.getCredential(
        authToken: _currentUserTwitterSession?.token ?? '',
        authTokenSecret: _currentUserTwitterSession?.secret ?? '');
    AuthResult result =
        await _firebaseAuth.signInWithCredential(_authCredential);
    _currentUser = result.user;

    ///Checking if user already exists in database
    ///
    ///If user exists, users info is collected
    ///If user does not exist, user is created
    bool userExist = await doesUserAlreadyExist(userEmail);
    if (!userExist) {
      createUser(userName, userEmail, userPhoto, 'Twitter');
      currentUserDocuments = await getCurrentUserDocument(userEmail);
      currentUserDocument = currentUserDocuments[0];
      List<dynamic> listOfWeeksFinished =
          currentUserDocument.data['weeks_finished'];
      currentWeek = listOfWeeksFinished.length + 1;
    } else {
      currentUserDocuments = await getCurrentUserDocument(userEmail);
      currentUserDocument = currentUserDocuments[0];
      List<dynamic> listOfWeeksFinished =
          currentUserDocument.data['weeks_finished'];
      currentWeek = listOfWeeksFinished.length + 1;
      if (currentUserDocument.data['trainer'] != null &&
          currentUserDocument.data['trainer'] != '') {
        currentUserTrainerDocuments =
            await getCurrentUserTrainer(currentUserDocument.data['trainer']);
        currentUserTrainerDocument = currentUserTrainerDocuments[0];
        totalWeeks = await getCurrentUserTrainerWeeks(
            currentUserTrainerDocument.data['trainerID']);
        currentUserTrainerName =
            currentUserTrainerDocument.data['trainer_name'];
        currentUserTrainingPlanDuration =
            currentUserTrainerDocument.data['training_plan_duration'];
        currentUserTrainingPlan =
            currentUserTrainerDocument.data['training_plan_name'];
      }
    }

    /// close modal dialog
    Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();

    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (_) => userExist
              ? currentUserDocument.data['trainer'] != null &&
                      currentUserDocument.data['trainer'] != ''
                  ? TrainingPlan(
                      userTrainerDocument: currentUserTrainerDocument,
                      userDocument: currentUserDocument,
                      trainerName: currentUserTrainerName,
                      trainingPlanDuration: currentUserTrainingPlanDuration,
                      trainingPlanName: currentUserTrainingPlan,
                      name: userName,
                      photo: userPhoto,
                      email: userEmail,
                    )
                  : ChooseAthlete(
                      userDocument: currentUserDocument,
                      name: userName,
                      email: userEmail,
                      photo: userPhoto,
                    )
              : ChooseAthlete(
                  userDocument: currentUserDocument,
                  name: userName,
                  email: userEmail,
                  photo: userPhoto,
                ),
        ),
        (Route<dynamic> route) => false);
  }

  /// sign in with google
  ///
  /// instance [googleSignIn]
  final GoogleSignIn googleSignIn = GoogleSignIn();

  @override
  signInWithGoogle(BuildContext context) async {
    /// open dialog
    Dialogs.showLoadingDialog(context, _keyLoader);

    final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;

    /// we get credentials over [GoogleAuthProvider] and get [accessToken & idToken]
    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );

    /// we collect that result and we collect activeUsers info
    final AuthResult authResult =
        await _firebaseAuth.signInWithCredential(credential);
    final FirebaseUser user = authResult.user;

    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);

    final FirebaseUser currentUser = await _firebaseAuth.currentUser();
    assert(user.uid == currentUser.uid);

    loginUser();
    userEmail = currentUser.email;
    userName = currentUser.displayName;
    userPhoto = currentUser.photoUrl;

    ///Checking if user already exists in database
    ///
    ///If user exists, users info is collected
    ///If user does not exist, user is created
    bool userExist = await doesUserAlreadyExist(userEmail);
    if (!userExist) {
      createUser(userName, userEmail, userPhoto, 'Google');
      currentUserDocuments = await getCurrentUserDocument(userEmail);
      currentUserDocument = currentUserDocuments[0];
      List<dynamic> listOfWeeksFinished =
          currentUserDocument.data['weeks_finished'];
      currentWeek = listOfWeeksFinished.length + 1;
    } else {
      currentUserDocuments = await getCurrentUserDocument(userEmail);
      currentUserDocument = currentUserDocuments[0];
      List<dynamic> listOfWeeksFinished =
          currentUserDocument.data['weeks_finished'];
      currentWeek = listOfWeeksFinished.length + 1;
      if (currentUserDocument.data['trainer'] != null &&
          currentUserDocument.data['trainer'] != '') {
        currentUserTrainerDocuments =
            await getCurrentUserTrainer(currentUserDocument.data['trainer']);
        currentUserTrainerDocument = currentUserTrainerDocuments[0];
        totalWeeks = await getCurrentUserTrainerWeeks(
            currentUserTrainerDocument.data['trainerID']);
        currentUserTrainerName =
            currentUserTrainerDocument.data['trainer_name'];
        currentUserTrainingPlanDuration =
            currentUserTrainerDocument.data['training_plan_duration'];
        currentUserTrainingPlan =
            currentUserTrainerDocument.data['training_plan_name'];
      }
    }

    /// close dialog
    Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();

    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (_) => userExist
              ? currentUserDocument.data['trainer'] != null &&
                      currentUserDocument.data['trainer'] != ''
                  ? TrainingPlan(
                      userTrainerDocument: currentUserTrainerDocument,
                      userDocument: currentUserDocument,
                      trainerName: currentUserTrainerName,
                      trainingPlanDuration: currentUserTrainingPlanDuration,
                      trainingPlanName: currentUserTrainingPlan,
                      name: userName,
                      photo: userPhoto,
                      email: userEmail,
                    )
                  : ChooseAthlete(
                      userDocument: currentUserDocument,
                      name: userName,
                      email: userEmail,
                      photo: userPhoto,
                    )
              : ChooseAthlete(
                  userDocument: currentUserDocument,
                  name: userName,
                  email: userEmail,
                  photo: userPhoto,
                ),
        ),
        (Route<dynamic> route) => false);
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

    loginUser();

    ///Populating variables used later in application
    userEmail = currentUser.email;
    userName = currentUser.displayName;
    userPhoto = currentUser.photoUrl;

    ///Checking if user already exists in database
    ///
    ///If user exists, users info is collected
    ///If user does not exist, user is created
    bool userExist = await doesUserAlreadyExist(userEmail);
    if (!userExist) {
      createUser(userName, userEmail, userPhoto, 'Facebook');
      currentUserDocuments = await getCurrentUserDocument(userEmail);
      currentUserDocument = currentUserDocuments[0];
      List<dynamic> listOfWeeksFinished =
          currentUserDocument.data['weeks_finished'];
      currentWeek = listOfWeeksFinished.length + 1;
    } else {
      currentUserDocuments = await getCurrentUserDocument(userEmail);
      currentUserDocument = currentUserDocuments[0];
      List<dynamic> listOfWeeksFinished =
          currentUserDocument.data['weeks_finished'];
      currentWeek = listOfWeeksFinished.length + 1;
      if (currentUserDocument.data['trainer'] != null &&
          currentUserDocument.data['trainer'] != '') {
        currentUserTrainerDocuments =
            await getCurrentUserTrainer(currentUserDocument.data['trainer']);
        currentUserTrainerDocument = currentUserTrainerDocuments[0];
        totalWeeks = await getCurrentUserTrainerWeeks(
            currentUserTrainerDocument.data['trainerID']);
        currentUserTrainerName =
            currentUserTrainerDocument.data['trainer_name'];
        currentUserTrainingPlanDuration =
            currentUserTrainerDocument.data['training_plan_duration'];
        currentUserTrainingPlan =
            currentUserTrainerDocument.data['training_plan_name'];
      }
    }

    ///Navigating logged user into application
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (_) => userExist
              ? currentUserDocument.data['trainer'] != null &&
                      currentUserDocument.data['trainer'] != ''
                  ? TrainingPlan(
                      userTrainerDocument: currentUserTrainerDocument,
                      userDocument: currentUserDocument,
                      trainerName: currentUserTrainerName,
                      trainingPlanDuration: currentUserTrainingPlanDuration,
                      trainingPlanName: currentUserTrainingPlan,
                      name: userName,
                      photo: userPhoto,
                      email: userEmail,
                    )
                  : ChooseAthlete(
                      userDocument: currentUserDocument,
                      name: userName,
                      email: userEmail,
                      photo: userPhoto,
                    )
              : ChooseAthlete(
                  userDocument: currentUserDocument,
                  name: userName,
                  email: userEmail,
                  photo: userPhoto,
                ),
        ),
        (Route<dynamic> route) => false);

    ///Logging user to shared preference with aim to
    ///
    ///have the user later for autologging
    return currentUser;
  }

  ///Method which initializes the Facebook Login
  @override
  signInWithFacebook(BuildContext context) async {
    /// open dialog
    Dialogs.showLoadingDialog(context, _keyLoader);

    ///Logging user using Facebook Account
    FacebookLoginResult result = await facebookSignIn.logIn(['email']);

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

        /// close dialog
        //Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
        break;

      ///Case when user canceles the loggin process
      case FacebookLoginStatus.cancelledByUser:
        result = null;

        /// close dialog
        Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
        break;

      ///Case of any error occured during loggin process
      case FacebookLoginStatus.error:
        result = null;

        /// close dialog
        Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
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

    currentUserDocuments = await getCurrentUserDocument(userEmail);
    currentUserDocument = currentUserDocuments[0];
    List<dynamic> listOfWeeksFinished =
        currentUserDocument.data['weeks_finished'];
    currentWeek = listOfWeeksFinished.length + 1;

    if (currentUserDocument.data['trainer'] != null &&
        currentUserDocument.data['trainer'] != '') {
      currentUserTrainerDocuments =
          await getCurrentUserTrainer(currentUserDocument.data['trainer']);
      currentUserTrainerDocument = currentUserTrainerDocuments[0];
      totalWeeks = await getCurrentUserTrainerWeeks(
          currentUserTrainerDocument.data['trainerID']);
      currentUserTrainerName = currentUserTrainerDocument.data['trainer_name'];
      currentUserTrainingPlanDuration =
          currentUserTrainerDocument.data['training_plan_duration'];
      currentUserTrainingPlan =
          currentUserTrainerDocument.data['training_plan_name'];
    }

    ///Checking if there is a user logged in, only if there are
    ///
    ///records in shared preference, user is directly redirected
    ///to ChooseAthelete Screen
    if (userEmail != null && userName != null && userPhoto != null) {
      isLoggedIn = true;
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (_) => currentUserDocument.data['trainer'] != null &&
                    currentUserDocument.data['trainer'] != ''
                ? TrainingPlan(
                    userTrainerDocument: currentUserTrainerDocument,
                    userDocument: currentUserDocument,
                    trainerName: currentUserTrainerName,
                    trainingPlanDuration: currentUserTrainingPlanDuration,
                    trainingPlanName: currentUserTrainingPlan,
                    name: userName,
                    photo: userPhoto,
                    email: userEmail,
                  )
                : ChooseAthlete(
                    userDocument: currentUserDocument,
                    name: userName,
                    email: userEmail,
                    photo: userPhoto,
                  ),
          ),
          (Route<dynamic> route) => false);
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

  ///Method which redirects user to Privacy Policy and Terms of Services
  @override
  redirectToPrivacyAndTerms() async {
    const url = 'http://athlete.blogger.ba/arhiva/2020/04/15/4207556';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  ///Method for creating user in databse and it is called when user is
  ///
  ///signing in and when the user does not already exists
  @override
  createUser(String name, String email, String image, String platform) async {
    final databaseReference = Firestore.instance;
    await databaseReference.collection("Users").document(email).setData({
      'display_name': name,
      'image': image,
      'email': email,
      'trainer': '',
      'trainers_finished': [],
      'weeks_finished': [],
      'workouts_finished': [],
      'platform': platform
    });
  }

  ///Method for checking if user already exists in database or not
  ///
  ///and it is called on every sign in actions
  @override
  Future<bool> doesUserAlreadyExist(String email) async {
    final QuerySnapshot result = await Firestore.instance
        .collection('Users')
        .where('email', isEqualTo: email)
        .limit(1)
        .getDocuments();
    final List<DocumentSnapshot> documents = result.documents;
    return documents.length == 1;
  }

  ///Method for getting from database document of current user
  @override
  Future<List<DocumentSnapshot>> getCurrentUserDocument(String email) async {
    var firestore = Firestore.instance;
    QuerySnapshot qn = await firestore
        .collection('Users')
        .where('email', isEqualTo: email)
        .getDocuments();
    return qn.documents;
  }

  ///Method for getting from database document of trainer
  ///
  ///of current user
  @override
  Future<List<DocumentSnapshot>> getCurrentUserTrainer(String trainer) async {
    final QuerySnapshot result = await Firestore.instance
        .collection('Trainers')
        .where('trainer_name', isEqualTo: trainer)
        .limit(1)
        .getDocuments();
    return result.documents;
  }

  @override
  Future<int> getCurrentUserTrainerWeeks(String trainerID) async {
    final QuerySnapshot result = await Firestore.instance
        .collection('Trainers')
        .document(trainerID)
        .collection('weeks')
        .getDocuments();
    return result.documents.length;
  }

  ///Method for updating and writing the trainer that user chooses from
  ///
  ///the list
  @override
  updateUserWithTrainer(
      DocumentSnapshot userDocument, String email, String trainer) async {
    final db = Firestore.instance;
    await db.collection('Users').document(email).updateData({
      'trainer': trainer,
    });
  }
}