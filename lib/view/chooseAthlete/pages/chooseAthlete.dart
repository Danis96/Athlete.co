import 'package:attt/utils/size_config.dart';
import 'package:flutter/material.dart';

class ChooseAthlete extends StatelessWidget {
   ChooseAthlete({Key key}) : super(key: key);

  String name = 'Danis';

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: ListView(
        children: <Widget>[
          nameHeadline(name, context),
          Container(),
        ],
      ),
    );
  }
}

Widget nameHeadline(String name, BuildContext context) {
  SizeConfig().init(context);
  return Container(
    margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical * 5,
                            left: SizeConfig.blockSizeHorizontal * 5 ),
    child: Row(
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(10),
          child: CircleAvatar(
            radius: 28.0,
            backgroundImage: NetworkImage(
                'https://store.playstation.com/store/api/chihiro/00_09_000/container/US/en/999/UP0151-CUSA09971_00-AV00000000000002/1580206501000/image?w=240&h=240&bg_color=000000&opacity=100&_version=00_09_000'),
          ),
        ),
        Container(
          child: Text('Hi $name, \nselect your athlete.'),
        ),
      ],
    ),
  );
}
