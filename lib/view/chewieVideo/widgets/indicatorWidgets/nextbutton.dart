

import 'package:attt/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:video_box/video.controller.dart';

Widget nextButton(BuildContext context, Function resetTimer, playNext, VideoController vc) {
   return Column(
     children: [
       Container(
         child: IconButton(
           icon: Icon(Icons.skip_next),
           iconSize: MediaQuery.of(context)
               .orientation ==
               Orientation.landscape
               ? SizeConfig.blockSizeHorizontal * 6
               : SizeConfig.blockSizeHorizontal * 10,
           color:  MediaQuery.of(context)
               .orientation ==
               Orientation.landscape
               ? Colors.white54 : Colors.white,
           onPressed: () {
             playNext();
             resetTimer();
           },
         ),
       ),
       Container(
         margin: EdgeInsets.only(right: SizeConfig.blockSizeHorizontal * 2),
         child: Text('NEXT', style: TextStyle(color:MediaQuery.of(context)
             .orientation ==
             Orientation.landscape
             ?  Colors.white.withOpacity(0.7) : Colors.white, fontSize: MediaQuery.of(context)
             .orientation ==
             Orientation.landscape
             ? SizeConfig.safeBlockHorizontal * 2 : SizeConfig.safeBlockHorizontal * 3),),
       )
     ],
   );
}