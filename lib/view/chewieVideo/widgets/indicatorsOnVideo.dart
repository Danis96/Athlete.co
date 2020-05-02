import 'package:attt/view/chewieVideo/widgets/globals.dart';
import 'package:attt/view/workout/widgets/info.dart';
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
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return 
    SlideTransition(
        position: _offsetAnimation,
        child: Center(
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  /// number of reps
                  GestureDetector(
                    // onTap: () => showTips(context),
                                      child: Container(
                      padding: EdgeInsets.all(5),
                      child: Text('Gimnastic Push ups',
                          style: TextStyle(
                            color: Colors.white,
                          )),
                    ),
                  ),
                  /// icon note
                  Container(
                    margin: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal * 68),
                    child: IconButton(
                        color: Colors.white,
                        iconSize: SizeConfig.blockSizeHorizontal * 5 ,
                        icon: Icon(Icons.comment), onPressed: () {}),
                  )
                ],
              ),
              Row(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      /// reps
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
                            top:
                            // / showText
                                // ? 
                                SizeConfig.blockSizeVertical * 70
                                // : 0
                                ),
                        child: Text(
                          '1/5 Sets',
                          style: TextStyle(
                              color: Colors.white ,
                              fontSize: SizeConfig.safeBlockHorizontal * 2,
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic),
                        ),
                      ),
                    ],
                  ),
                  /// done icon
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
        ));
  }

  /// [showTips]
  ///
  /// here we show the tips for the exact exercise
  showTips(BuildContext context) async {
    chewieController.pause();

    /// create overlay
    OverlayState overlayState = Overlay.of(context);
    OverlayEntry overlayEntry =
        OverlayEntry(builder: (BuildContext context) => InfoExercise());

    /// add to overlay overlayEntry that is rest widget
    overlayState.insert(overlayEntry);

    overlayEntry.remove();
 
 }
}
