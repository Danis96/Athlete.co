import 'package:attt/utils/colors.dart';
import 'package:attt/utils/globals.dart';
import 'package:attt/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_box/video_box.dart';

import '../../../utils/emptyContainer.dart';
import '../../../utils/size_config.dart';
import '../../../utils/size_config.dart';
import '../../../utils/size_config.dart';
import '../../../utils/size_config.dart';
import '../../../utils/size_config.dart';

class InfoExercise extends StatefulWidget {
  final List<dynamic> exerciseTips;
  final String exerciseNameForInfo;
  final String exerciseVideoForInfo;
  final VideoController vc;
  const InfoExercise({
    Key key,
    this.exerciseTips,
    this.exerciseNameForInfo,
    this.exerciseVideoForInfo,
    this.vc,
  }) : super(key: key);

  @override
  _InfoExerciseState createState() => _InfoExerciseState();
}

class _InfoExerciseState extends State<InfoExercise> {
  VideoController vc;

  @override
  void initState() {
    super.initState();
    vc = VideoController(
        controllerWidgets: true,
        looping: true,
        autoplay: false,
        source: VideoPlayerController.network(widget.exerciseVideoForInfo))
      ..initialize();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  }

  @override
  void dispose() {
    super.dispose();
    vc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: MyColors().black,
      body: WillPopScope(
        onWillPop: () => _onWillPop(),
        child: MediaQuery.of(context).orientation == Orientation.portrait ? ListView(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          children: <Widget>[
            Container(
              height: SizeConfig.blockSizeVertical * 30,
              width: SizeConfig.blockSizeHorizontal * 100,
              margin: EdgeInsets.only(bottom: SizeConfig.blockSizeVertical * 2),
              child: Stack(
                children: <Widget>[
                  Center(
                    child: VideoBox(controller: vc),
                  ),
                  Positioned(
                    child: InkWell(
                      onTap: () async {
                        await playAndPause();
                      },
                      child: Container(
                        height: SizeConfig.blockSizeVertical * 22,
                        width: SizeConfig.blockSizeHorizontal * 100,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              color: Colors.black,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Container(
                    width: SizeConfig.blockSizeHorizontal * 100,
                    child: Container(
                      height: SizeConfig.blockSizeVertical * 50,
                      color: MyColors().black,
                      child: Column(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.all(5),
                            child: Row(
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.only(
                                      left: SizeConfig.blockSizeHorizontal * 2),
                                  child: IconButton(
                                    color: MyColors().white,
                                    iconSize:
                                    SizeConfig.blockSizeHorizontal * 6,
                                    icon: Icon(Icons.clear),
                                    onPressed: () => onDone(),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    margin: EdgeInsets.only(
                                        left:
                                        SizeConfig.blockSizeHorizontal * 2),
                                    child: Text(
                                      widget.exerciseNameForInfo,
                                      overflow: TextOverflow.clip,
                                      style: TextStyle(
                                          color: MyColors().white,
                                          fontSize:
                                          SizeConfig.safeBlockHorizontal *
                                              5.2,
                                          fontWeight: FontWeight.bold,
                                          fontStyle: FontStyle.italic),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Container(
                            height: SizeConfig.blockSizeVertical * 33,
                            width: SizeConfig.blockSizeHorizontal * 90,
                            padding: EdgeInsets.only(
                                top: SizeConfig.blockSizeVertical * 2.5),
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: widget.exerciseTips.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Container(
                                  padding: EdgeInsets.all(5),
                                  margin: EdgeInsets.only(
                                      bottom: SizeConfig.blockSizeVertical * 1,
                                      left: SizeConfig.blockSizeHorizontal * 5),
                                  child: Text(
                                    widget.exerciseTips[index].toString().replaceAll('\\n', '\n'),
                                    style: TextStyle(
                                        color: MyColors().white,
                                        fontSize:
                                        SizeConfig.safeBlockHorizontal *
                                            4),
                                  ),
                                );
                              },
                            ),
                          ),

                        ],
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.bottomCenter,
                    width: SizeConfig.blockSizeHorizontal * 100,
                    margin: EdgeInsets.only(
                      top: SizeConfig.blockSizeVertical * 6,
                    ),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10))
                    ),
                    child: Container(
                      height: SizeConfig.blockSizeVertical * 5,
                      width: SizeConfig.blockSizeHorizontal * 90,
                      child: RaisedButton(
                        color: MyColors().white,
                        onPressed: () => onDone(),
                        child: Text(
                          'DONE',
                          style: TextStyle(
                            fontSize: SizeConfig.safeBlockHorizontal * 4,
                            color: MyColors().black,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ) : EmptyContainer(),
      ),
    );
  }

  /// [onDone] here we check doues ur android back button is going to video, or exercise screen
  /// if true  then set our portrait to landscapeRight
  /// same goes for tips
  onDone() {
    setState(
          () {
        goBackToChewie
            ? isFromPortrait
            ? SystemChrome.setPreferredOrientations(
            [DeviceOrientation.portraitUp])
            : SystemChrome.setPreferredOrientations(
            [DeviceOrientation.landscapeRight])
            : print('NIJE SA VIDEA');
      },
    );
    goBackToChewie ? isTips = true : isTips = false;
    setState(
          () {
        infoClicked = true;
      },
    );
    Navigator.of(context).pop();
    goBackToChewie = false;
  }

  playAndPause() {
    vc.value.isPlaying ? vc.pause() : vc.play();
  }

  Future<bool> _onWillPop() async {
    if (goBackToChewie) {
      isFromPortrait
          ? SystemChrome.setPreferredOrientations(
          [DeviceOrientation.portraitUp])
          : SystemChrome.setPreferredOrientations(
          [DeviceOrientation.landscapeRight]);
    }
    setState(
          () {
        infoClicked = true;
      },
    );
    Navigator.of(context).pop();
  }
}

checkForOrientationOnBack() {
  isFromPortrait
      ? SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      : SystemChrome.setPreferredOrientations(
      [DeviceOrientation.landscapeRight]);
}