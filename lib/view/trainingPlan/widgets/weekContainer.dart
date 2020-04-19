import 'package:attt/utils/size_config.dart';
import 'package:flutter/material.dart';

Widget weekContainer(AsyncSnapshot snapshot, int index) {
  return Container(
    margin: EdgeInsets.only(bottom: SizeConfig.blockSizeVertical * 1.25),
    width: double.infinity,
    height: SizeConfig.blockSizeVertical * 8.75,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.all(
        Radius.circular(4),
      ),
      border: Border.all(
        width: 1,
        color: Color.fromRGBO(255, 255, 255, 0.2),
      ),
    ),
    child: Padding(
      padding: EdgeInsets.only(
        top: SizeConfig.blockSizeVertical * 3,
        bottom: SizeConfig.blockSizeVertical * 3,
        left: SizeConfig.blockSizeHorizontal * 5.2,
        right: SizeConfig.blockSizeHorizontal * 5.2,
      ),
      child: Text(
        snapshot.data[index]['name'].toString().toUpperCase(),
        style: TextStyle(
            color: Colors.white,
            fontFamily: 'Roboto',
            fontSize: SizeConfig.blockSizeVertical * 2.5,
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.w500),
      ),
    ),
  );
}
