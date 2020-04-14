import 'package:attt/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:attt/view/chooseAthlete/widgets/nameHeadline.dart';
import 'package:attt/view/chooseAthlete/widgets/trainerList.dart';

String name = 'Danis';
String duration = '18';

class ChooseAthlete extends StatelessWidget {
  ChooseAthlete({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: ListView(
        children: <Widget>[
          nameHeadline(name, context),
          trainersList(context),
        ],
      ),
    );
  }
}








