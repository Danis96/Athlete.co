import 'package:attt/utils/size_config.dart';
import 'package:flutter/material.dart';

class IconAppBar extends StatelessWidget {
  final Function onWillPop;
  const IconAppBar({Key key, this.onWillPop}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return IconButton(
      icon: Icon(
        Icons.clear,
        size: SizeConfig.blockSizeHorizontal * 5,
      ),
      onPressed: () {
        FocusScope.of(context).requestFocus(new FocusNode());
        onWillPop();
      },
    );
  }
}
