

import 'package:attt/utils/size_config.dart';
import 'package:flutter/material.dart';

Widget previousButton(BuildContext context, Function resetTimer, playPrevious) {
   return Container(
     child: IconButton(
       icon: Icon(Icons.skip_previous),
       iconSize: MediaQuery.of(context)
           .orientation ==
           Orientation.landscape
           ? SizeConfig.blockSizeHorizontal * 6
           : SizeConfig.blockSizeHorizontal * 10,
       color: Colors.white54,
       onPressed: () {
         playPrevious();
         resetTimer();
       },
     ),
   );
}
