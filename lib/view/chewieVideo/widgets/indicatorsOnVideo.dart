import 'package:attt/view_model/chewieVideoViewModel.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class IndicatorsOnVideo extends StatelessWidget {
  final VideoPlayerController controller;
  IndicatorsOnVideo(this.controller);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        ChewieVideoViewModel().pauseVideo(controller);
      },
      child: Container(
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  child: Text('Gimnastic Push ups',
                      style: TextStyle(color: Colors.white)),
                ),
                Container(
                  margin: EdgeInsets.only(left: 650.0),
                  child: IconButton(
                    icon: Icon(Icons.comment),
                    onPressed: () {},
                    color: Colors.white,
                    iconSize: 40.0,
                  ),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(top: 250.0),
                      child: Text('x10',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 32.0,
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic)),
                    ),
                    Container(
                      child: Text('1/5 Sets',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic)),
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(left: 700.0, top: 250.0),
                  child: IconButton(
                    icon: Icon(Icons.fiber_manual_record),
                    onPressed: () {},
                    color: Colors.white,
                    iconSize: 40.0,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
