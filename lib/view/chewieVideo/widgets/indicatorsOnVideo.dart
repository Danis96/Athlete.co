import 'dart:io';

import 'package:attt/utils/alertDialog.dart';
import 'package:attt/utils/colors.dart';
import 'package:attt/utils/emptyContainer.dart';
import 'package:attt/utils/globals.dart';
import 'package:attt/view/chewieVideo/widgets/globals.dart';
import 'package:attt/view_model/chewieVideoViewModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import 'package:attt/utils/size_config.dart';

class IndicatorsOnVideo extends StatefulWidget {
  final VideoPlayerController controller;
  final DocumentSnapshot userDocument, userTrainerDocument;
  IndicatorsOnVideo(
      {this.controller, this.userTrainerDocument, this.userDocument});

  @override
  _IndicatorsOnVideoState createState() => _IndicatorsOnVideoState();
}

class _IndicatorsOnVideoState extends State<IndicatorsOnVideo>
    with TickerProviderStateMixin {
  AnimationController _controller;
  Animation<Offset> _offsetAnimation;

  @override
  void initState() {
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    )..forward();

    _offsetAnimation = Tween<Offset>(
      begin: const Offset(0.8, 0.0),
      end: const Offset(0.0, 0.0),
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return InkWell(
      onTap: () {
        setState(() {
          ChewieVideoViewModel().pauseVideo(widget.controller);
        });
      },
      child: WillPopScope(
        onWillPop: () => _onWillPop(),
        child: SlideTransition(
          position: _offsetAnimation,
          child: Container(
            margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical * 4) ,
            child: Center(
              child: Column(children: <Widget>[
                Row(
                  children: <Widget>[
                    /// number of reps
                    Container(
                      padding: EdgeInsets.all(5),
                      child: Text('Gimnastic Push ups',
                          style: TextStyle(
                            color: showText ? Colors.white : Colors.black,
                          )),
                    ),
                  ],
                ),
                isPaused
                    ? Container(
                        height: SizeConfig.blockSizeVertical * 20,
                        width: SizeConfig.blockSizeHorizontal * 22,
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
                          textAlign: TextAlign.center,
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
                                padding: EdgeInsets.all(8.0),
                                margin: EdgeInsets.only(
                                    top: showText
                                        ? isPaused
                                            ? SizeConfig.blockSizeVertical * 55
                                            : SizeConfig.blockSizeVertical * 75
                                        : 0),
                                child: Text(
                                  '1/5 Sets',
                                  style: TextStyle(
                                      color:
                                          showText ? Colors.white : Colors.black,
                                      fontSize:
                                          SizeConfig.safeBlockHorizontal * 2,
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
              )
            ),
          ),
        ),
    );
  }

  /// [_onWillPop]
  ///
  /// async funstion that creates an exit dialog for our screen
  /// YES / NO
  Future<bool> _onWillPop() async {
    return showDialog(
          context: context,
          builder: (context) => MyAlertDialog(
            no: 'Cancel',
            yes: 'Continue',
            title: 'Back to Training plan?',
            content: 'If you go back all your progress will be lost',
            userDocument: widget.userDocument,
            userTrainerDocument: widget.userTrainerDocument,
          ),
        ) ??
        true;
  }
}
