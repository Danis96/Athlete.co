import 'package:attt/utils/colors.dart';
import 'package:attt/utils/emptyContainer.dart';
import 'package:attt/utils/size_config.dart';
import 'package:flutter/material.dart';

Widget phasesCont(String text, number, desc, desc1) {
  return Container(
    child: Column(
      children: <Widget>[
        text == ''
            ? EmptyContainer()
            : Container(
                margin: EdgeInsets.only(left: SizeConfig.blockSizeVertical * 1),
                alignment: Alignment.centerLeft,
                width: SizeConfig.blockSizeHorizontal * 100,
                child: Text(
                  text,
                  style: TextStyle(
                    color: MyColors().white,
                    fontSize: SizeConfig.safeBlockHorizontal * 5.2,
                  ),
                ),
              ),
        Container(
          margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical * 0.5),
          child: Row(
            children: <Widget>[
              Container(
                margin:
                    EdgeInsets.only(left: SizeConfig.blockSizeHorizontal * 2),
                child: Text(
                  number,
                  style: TextStyle(
                    color: Colors.amber,
                    fontSize: SizeConfig.safeBlockHorizontal * 5,
                  ),
                ),
              ),
              Container(
                child: RichText(
                  text: TextSpan(
                    text: desc,
                    style: TextStyle(
                        color: MyColors().white,
                        fontSize: SizeConfig.safeBlockHorizontal * 5.0,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w400),
                    children: <TextSpan>[
                      TextSpan(
                          text: desc1,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.amber)),
                    ],
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
