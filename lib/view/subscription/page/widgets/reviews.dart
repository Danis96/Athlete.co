import 'package:attt/utils/colors.dart';
import 'package:attt/utils/size_config.dart';
import 'package:flutter/material.dart';

Widget reviews(String name, review, BuildContext context) {
  return Container(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: EdgeInsets.all(4),
          alignment: Alignment.centerLeft,
          child: Text(
            name,
            style: TextStyle(
              color: Colors.amber,
              fontSize: MediaQuery.of(context).size.width > 600
                  ? SizeConfig.safeBlockHorizontal * 5.0
                  : SizeConfig.safeBlockHorizontal * 6.0,
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.all(4),
          child: Text(review,
              style: TextStyle(
                color: Colors.white,
                fontSize: MediaQuery.of(context).size.width > 600
                    ? SizeConfig.safeBlockHorizontal * 3.5
                    : MediaQuery.of(context).size.width < 400 ? SizeConfig.safeBlockHorizontal * 3.5 : SizeConfig.safeBlockHorizontal * 4.0,
              )),
        ),
      ],
    ),
  );
}
