import 'package:attt/utils/size_config.dart';
import 'package:flutter/material.dart';

class AppBarIcon extends StatelessWidget {
  final Function onWillPop;
  const AppBarIcon({Key key, this.onWillPop}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new IconButton(
      icon: new Icon(
        Icons.clear,
        size: MediaQuery.of(context).orientation == Orientation.portrait
            ? SizeConfig.blockSizeHorizontal * 5.5
            : SizeConfig.blockSizeHorizontal * 3,
      ),
      onPressed: () => onWillPop(),
    );
  }
}
