import 'package:attt/utils/colors.dart';
import 'package:flutter/material.dart';

 
Widget showDeclinedDialog(BuildContext context) {

  // set up the button
  Widget okButton = FlatButton(
    child: Text("OK", style: TextStyle(color: MyColors().error),),
    onPressed: () => Navigator.of(context).pop(),
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    backgroundColor: MyColors().lightBlack,
    title: Text("Not approved", style: TextStyle(color: MyColors().lightWhite),),
    content: Text("Please check or update your payments method.", style: TextStyle(color: MyColors().lightWhite),),
    actions: [
      okButton,
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