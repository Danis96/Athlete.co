import 'package:attt/utils/colors.dart';
import 'package:attt/utils/text.dart';
import 'package:attt/view/home/pages/signin.dart';
import 'package:attt/view_model/signInViewModel.dart';
import 'package:flutter/material.dart';

showAlertDialog(BuildContext context) {
  // set up the buttons
  Widget cancelButton = FlatButton(
    child: Text(
      MyText().btnCancel,
      style: TextStyle(color: MyColors().white),
    ),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );
  Widget continueButton = FlatButton(
    child: Text(
      MyText().btnContinue,
      style: TextStyle(color: MyColors().white),
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

      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (_) => Signin()),
          (Route<dynamic> route) => false);
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    backgroundColor: MyColors().lightBlack,
    title: Text(
      MyText().alertTitle,
      style: TextStyle(color: MyColors().white),
    ),
    content: Text(
      MyText().alertContent,
      style: TextStyle(color: MyColors().white),
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
