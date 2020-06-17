
import 'package:attt/utils/size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget previousButton(BuildContext context, Function resetTimer, playPrevious) {
   return Container(
     width: SizeConfig.blockSizeHorizontal * 15,
     child: Column(
       crossAxisAlignment: CrossAxisAlignment.center,
       children: [
         Container(
           child: IconButton(
             icon: Icon(Icons.skip_previous),
             iconSize: MediaQuery.of(context)
                 .orientation ==
                 Orientation.landscape
                 ? SizeConfig.blockSizeHorizontal * 6
                 : SizeConfig.blockSizeHorizontal * 10,
             color: MediaQuery.of(context)
                 .orientation ==
                 Orientation.landscape
                 ? Colors.white54 : Colors.white,
             onPressed: () {
               playPrevious();
               resetTimer();
             },
           ),
         ),
         Container(
           child: Text('PREV', style: TextStyle(color: MediaQuery.of(context)
               .orientation ==
               Orientation.landscape
               ?  Colors.white.withOpacity(0.7) : Colors.white, fontSize: MediaQuery.of(context)
               .orientation ==
               Orientation.landscape
               ? SizeConfig.safeBlockHorizontal * 2 : SizeConfig.safeBlockHorizontal * 3),),
         )
       ],
     ),
   );
}
