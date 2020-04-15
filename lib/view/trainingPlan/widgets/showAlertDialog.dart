import 'package:attt/view/home/pages/signin.dart';
import 'package:attt/view_model/signInViewModel.dart';
import 'package:flutter/material.dart';

showAlertDialog(BuildContext context) {
  // set up the buttons
  Widget cancelButton = FlatButton(
    child: Text(
      "Cancel",
      style: TextStyle(color: Colors.white),
    ),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );
  Widget continueButton = FlatButton(
    child: Text(
      "Continue",
      style: TextStyle(color: Colors.white),
    ),
    onPressed: () {
      /// google sign out
      SignInViewModel().signOutGoogle(context);

      /// facebook sign out
      SignInViewModel().signOutFacebook(context);

      /// twitter sign out
      SignInViewModel().signOutTwitter(context);

      /// sign out from Shared Preference
      SignInViewModel().logout();

      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (_) => Signin()));
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    backgroundColor: Color.fromRGBO(28, 28, 28, 1.0),
    title: Text(
      "Are you sure?",
      style: TextStyle(color: Colors.white),
    ),
    content: Text(
      "If you Sign Out all your progress will be lost.",
      style: TextStyle(color: Colors.white),
    ),
    actions: [
      cancelButton,
      continueButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
