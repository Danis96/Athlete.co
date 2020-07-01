import 'package:attt/utils/colors.dart';
import 'package:attt/utils/size_config.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';


class CheckForHistoryState extends StatefulWidget {

//  final DocumentSnapshot userDocument;
//  final DocumentSnapshot userTrainerDocument;
//  final String userUID;
//
//  CheckForHistoryState

  @override
  _CheckForHistoryStateState createState() => _CheckForHistoryStateState();
}

class _CheckForHistoryStateState extends State<CheckForHistoryState> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
       body: Center(
         child: Container(
             child: SpinKitFadingCircle(
               size: SizeConfig.safeBlockHorizontal * 15,
               color: MyColors().lightWhite,
             ),
         ),
       ),
    );
  }
}
