import 'package:attt/utils/colors.dart';
import 'package:attt/utils/emptyContainer.dart';
import 'package:attt/utils/globals.dart';
import 'package:attt/view_model/chewieVideoViewModel.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import 'package:attt/utils/size_config.dart';

class IndicatorsOnVideo extends StatefulWidget {
  final VideoPlayerController controller;
  IndicatorsOnVideo(this.controller);

  @override
  _IndicatorsOnVideoState createState() => _IndicatorsOnVideoState();
}

class _IndicatorsOnVideoState extends State<IndicatorsOnVideo> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return InkWell(
      onTap: () {
        setState(() {
          ChewieVideoViewModel().pauseVideo(widget.controller);
        });
      },
      child: Center(
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                /// number of reps
                Container(
                  padding: EdgeInsets.all(5),
                  child: Text('Gimnastic Push ups',
                      style: TextStyle(color: Colors.white)),
                ),
                Container(
                  margin: EdgeInsets.only(
                      left: SizeConfig.blockSizeHorizontal * 70),
                  child: IconButton(
                    icon: Icon(Icons.comment),
                    onPressed: () {},
                    color: Colors.white,
                    iconSize: 40.0,
                  ),
                ),
              ],
            ),
            isPaused
                ? Container(
                    decoration: BoxDecoration(
                        color: Color.fromRGBO(28, 28, 28, 0.7),
                        borderRadius: BorderRadius.all(Radius.circular(4.0))),
                    padding: EdgeInsets.all(20.0),
                    child: Text(
                      'PAUSED',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: SizeConfig.blockSizeVertical * 9,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic),
                    ),
                  )
                : EmptyContainer(),
            Row(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Container(
                      height: 0,
                      width: 0,
                      // margin: EdgeInsets.only(top: 250.0),
                      // child: Text('x10',
                      //     style: TextStyle(
                      //         color: Colors.white,
                      //         fontSize: 32.0,
                      //         fontWeight: FontWeight.bold,
                      //         fontStyle: FontStyle.italic)),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          top: isPaused ? SizeConfig.blockSizeVertical * 55 : SizeConfig.blockSizeVertical * 75),
                      child: Text(
                        '1/5 Sets',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: SizeConfig.safeBlockHorizontal * 2,
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic),
                      ),
                    ),
                  ],
                ),
                Container(
                  width: 0,
                  height: 0,
                  // // margin: EdgeInsets.only(left: 700.0, top: 250.0),
                  // child: IconButton(
                  //   icon: Icon(Icons.fiber_manual_record),
                  //   onPressed: () {},
                  //   color: Colors.white,
                  //   iconSize: 40.0,
                  // ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
