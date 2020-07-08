import 'package:attt/utils/colors.dart';
import 'package:attt/utils/emptyContainer.dart';
import 'package:attt/utils/size_config.dart';
import 'package:flutter/material.dart';

Widget resultCont(String text, number, desc) {
  return Container(

    child: Column(
      children: <Widget>[
        text == ''
            ? EmptyContainer()
            : Container(
          child: Text(
            text,
            style: TextStyle(
              color: MyColors().white,
              fontSize: SizeConfig.safeBlockHorizontal * 5.5,
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical * 1.0),
          child: Row(
            children: <Widget>[
              Container(
                  margin:
                  EdgeInsets.only(left: SizeConfig.blockSizeHorizontal * 2),
                  child: number == ''
                      ? EmptyContainer()
                      : Icon(
                    Icons.check,
                    color: Colors.amber,
                    size: SizeConfig.safeBlockHorizontal * 7,
                  )),
              Container(
                child: Text(
                  desc,
                  style: TextStyle(
                    color: MyColors().white,
                    fontSize: SizeConfig.safeBlockHorizontal * 4,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}