

import 'package:attt/utils/emptyContainer.dart';
import 'package:attt/utils/size_config.dart';
import 'package:flutter/material.dart';

Widget InfoIcon(BuildContext context) {
  return
    /// REFAKTORISATI DANISE
    MediaQuery.of(context).orientation ==
        Orientation.portrait
        ? Container(
      margin: EdgeInsets.only(
          top: MediaQuery.of(context).orientation ==
              Orientation.portrait
              ? SizeConfig.blockSizeVertical * 26.5
              : SizeConfig.blockSizeVertical * 26,
          left: MediaQuery.of(context)
              .orientation ==
              Orientation.portrait
              ? SizeConfig.blockSizeHorizontal * 12
              : SizeConfig.blockSizeHorizontal *
              26),
      child: IconButton(
        icon: Icon(Icons.info),
        onPressed: () {},
        color: Colors.white,
        iconSize:
        SizeConfig.blockSizeHorizontal * 8,
      ),
    )
        : EmptyContainer();
}