import 'package:attt/view/home/pages/signin.dart';
import 'package:attt/view_model/signInViewModel.dart';
import 'package:flutter/material.dart';

showAlertDialog(BuildContext context) {
  // set up the buttons
  Widget cancelButton = FlatButton(
    child: Text("Cancel"),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );
  Widget continueButton = FlatButton(
    child: Text("Continue"),
    onPressed: () {
      /// google sign out
      SignInViewModel().signOutGoogle(context);

      /// facebook sign out
      SignInViewModel().signOutFacebook(context);

      /// twitter sign out
      SignInViewModel().signOutTwitter(context);

      Navigator.of(context).push(MaterialPageRoute(builder: (_) => Signin()));
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Are you sure?"),
    content: Text("If you Sign Out all your progress will be lost."),
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
