import 'package:attt/utils/colors.dart';
import 'package:attt/utils/size_config.dart';
import 'package:flutter/material.dart';

Widget warmup(BuildContext context, String warmupDesc) {
  SizeConfig().init(context);
  return Container(
    color: MyColors().black,
    margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical * 3),
    child: ExpansionTile(
      trailing: IconButton(
          icon: Icon(
            Icons.keyboard_arrow_down,
            color: MyColors().white,
          ),
          onPressed: null),
      title: Text(
        'Warm Up',
        style: TextStyle(
            color: MyColors().white,
            fontSize: SizeConfig.blockSizeHorizontal * 5),
      ),
      backgroundColor: MyColors().black,
      initiallyExpanded: false,
      children: <Widget>[
        Container(
            padding: EdgeInsets.only(left: 13.0, right: 13.0, top: 10.0, bottom: 10.0),

            /// ono sto izvucem za warmup
            child: Text(
              warmupDesc,
                style: TextStyle(color: MyColors().lightWhite, fontSize: SizeConfig.blockSizeHorizontal * 3.5)))
      ],
    ),
  );
}