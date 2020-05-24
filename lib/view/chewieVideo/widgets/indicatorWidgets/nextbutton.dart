

import 'package:attt/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:video_box/video.controller.dart';

Widget nextButton(BuildContext context, Function resetTimer, playNext, VideoController vc) {
   return Container(
     child: IconButton(
       icon: Icon(Icons.skip_next),
       iconSize: MediaQuery.of(context)
           .orientation ==
           Orientation.landscape
           ? SizeConfig.blockSizeHorizontal * 6
           : SizeConfig.blockSizeHorizontal * 10,
       color: Colors.white54,
       onPressed: () {
         playNext();
         resetTimer();

       },
     ),
   );
}