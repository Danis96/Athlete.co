import 'package:attt/utils/colors.dart';
import 'package:flutter/material.dart';

class IDialog {
  Future<void> internetDialog(BuildContext context) async {
    return showDialog<void>(
      context: context, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: MyColors().lightBlack,
          title: Text(
            'Not connected!',
            style: TextStyle(color: Colors.redAccent),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  'Internet connection is disabled.',
                  style: TextStyle(color: MyColors().lightWhite),
                ),
                Text(
                  'You can change your athlete only in online mode.',
                  style: TextStyle(color: MyColors().lightWhite),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
