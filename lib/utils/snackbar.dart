import 'package:attt/utils/size_config.dart';
import 'package:flutter/material.dart';

class MySnackbar {
  void showSnackbar(
      String snackText, BuildContext context, String snackAction) {
    Scaffold.of(context).showSnackBar(SnackBar(
      duration: Duration(seconds: 2),
      behavior: MediaQuery.of(context).orientation == Orientation.portrait
          ? SnackBarBehavior.fixed
          : SnackBarBehavior.floating,
      backgroundColor: Colors.white,
      elevation: 2,
      content: Text(
        snackText,
        style: TextStyle(
            color: Colors.black, fontSize: MediaQuery.of(context).orientation == Orientation.portrait
            ? SizeConfig.safeBlockHorizontal * 4 : SizeConfig.safeBlockHorizontal * 3),
      ),
      action: SnackBarAction(
        label: snackAction,
        textColor: Colors.black,
        onPressed: () {},
      ),
    ));
  }
}
