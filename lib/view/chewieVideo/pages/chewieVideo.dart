import 'dart:async';
import 'package:attt/interface/chewieVideoInterface.dart';
import 'package:attt/utils/alertDialog.dart';
import 'package:attt/utils/emptyContainer.dart';
import 'package:attt/utils/globals.dart';
import 'package:attt/view/chewieVideo/widgets/getReady.dart';
import 'package:attt/view/chewieVideo/widgets/globals.dart';
import 'package:attt/view/chewieVideo/widgets/indicatorsOnVideo.dart';
import 'package:attt/view/chewieVideo/widgets/rest.dart';
import 'package:attt/view/trainingPlan/pages/trainingPlan.dart';
import 'package:chewie/chewie.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';



class ChewieVideo extends StatefulWidget {
  final DocumentSnapshot userDocument, userTrainerDocument;
  ChewieVideo({this.userDocument, this.userTrainerDocument});

  @override
  _ChewieVideoState createState() => _ChewieVideoState();
}

/// because we need setState to get video going
/// I implemented interface to ChewieVideoState
class _ChewieVideoState extends State<ChewieVideo>
    implements ChewieVideoInterface {

  
  Future<void> _initializeVideoPlayerFuture;
  int _playingIndex = -1;
  bool _disposed = false;
  var _isPlaying = false;
  var _isEndPlaying = false;

  /// this is list of urls (later we will get this data from db)
  List<String> _urls = [
    'assets/videos/C.mp4',
    'assets/videos/C.mp4',
    'assets/videos/C.mp4',
    'assets/videos/C.mp4',
    'assets/videos/C.mp4',
  ];

  @override
  void initState() { 
    super.initState();
     /// when widget inits make that screen rotation
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
     startPlay(_playingIndex + 1);
     alertQuit = false;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print('Widget Update');
    print('ALERTQUIT = ' + alertQuit.toString());
  
    if(alertQuit) clearPrevious();
  }

  @override
  void dispose() {
    _disposed = true;
    // By assigning Future is null,
    // prevent the video controller is using in widget before disposing that.
    _initializeVideoPlayerFuture = null;
    // In my case, sound is playing though controller was disposed.
    controller?.pause()?.then((_) {
      // dispose VideoPlayerController.
      controller?.dispose();
    });
    super.dispose();
  }

  @override
  Future<bool> clearPrevious() async {
    await controller?.pause();
    controller?.removeListener(controllerListener);
    return true;
  }

  @override
  Future<void> controllerListener() async {
    if (controller == null || _disposed) {
      return;
    }
    if (!controller.value.initialized) {
      return;
    }
    final position = await controller.position;
    final duration = controller.value.duration;
    final isPlaying = position.inMilliseconds < duration.inMilliseconds;
    final isEndPlaying =
        position.inMilliseconds > 0 && position.inSeconds == duration.inSeconds;

    // if (position.inMilliseconds == 0 && isReady == false) {
    //   showGetReady(context, controller);
    //   setState(() {
    //     isReady = true;
    //   });
    // }

    if (_isPlaying != isPlaying || _isEndPlaying != isEndPlaying) {
      _isPlaying = isPlaying;
      _isEndPlaying = isEndPlaying;
      print(
          "$_playingIndex -----> isPlaying= $isPlaying / isCompletePlaying=$isEndPlaying");
      if (isEndPlaying) {
        final isComplete = _playingIndex == _urls.length - 1;
        if (isComplete) {
          Navigator.of(context).push(MaterialPageRoute(
          builder: (_) => TrainingPlan(
                userTrainerDocument: widget.userTrainerDocument,
                userDocument: widget.userDocument,
              )));
          print("played all!!");
          // setState(() {
          //   isReady = false;
          // });
        } else {
              
              showOverlay(context);
        }
      }
    }
  }

  @override
  Future<void> initializePlay(int index) async {
    print(_urls[index]);
    final video = _urls[index];
    controller = VideoPlayerController.asset(video);
    controller.addListener(controllerListener);
    chewieController = ChewieController(
      videoPlayerController: controller,
      fullScreenByDefault: true,
      allowFullScreen: true,
      showControls: false,
      );
    _initializeVideoPlayerFuture = controller.initialize();
    setState(() {
      _playingIndex = index;
    });
  }

  @override
  pauseVideo(VideoPlayerController controller) {
   if (controller.value.isPlaying) {
      controller.pause();
      setState(() => isPaused = true);
      
    } else {
      controller.play();
      isPaused = false;
    }

  }

  @override
  showOverlay(BuildContext context) async {
    isFinished = true;
    chewieController.pause();
    /// create overlay
    OverlayState overlayState = Overlay.of(context);
    OverlayEntry overlayEntry = OverlayEntry(
        builder: (BuildContext context) =>
            Visibility(visible: isFinished, child: Rest()));

    /// add to overlay overlayEntry that is rest widget
    overlayState.insert(overlayEntry);

    /// wait for [rest] time and then remove the overlay widget
    await Future.delayed(Duration(seconds: 10));
    overlayEntry.remove();

    /// and play the next video
    startPlay(_playingIndex + 1);
  }

  @override
  showGetReady(BuildContext context, VideoPlayerController controller) async {
    //controller.pause();

    /// create overlay
    OverlayState overlayState = Overlay.of(context);
    OverlayEntry overlayEntry = OverlayEntry(
        opaque: true,
        builder: (BuildContext context) =>
            Visibility(visible: true, child: GetReady()));

    /// add to overlay overlayEntry that is rest widget
    overlayState.insert(overlayEntry);

    /// wait for [rest] time and then remove the overlay widget
    await Future.delayed(Duration(seconds: 5));
    overlayEntry.remove();

    /// and play the next video
    //controller.play();
  }

  @override
  Future<void> startPlay(int index) async {
    print("play ---------> $index");
    setState(() {
      _initializeVideoPlayerFuture = null;
    });
    Future.delayed(const Duration(milliseconds: 200), () {
      clearPrevious().then((_) {
        initializePlay(index);
      });
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: WillPopScope(
        onWillPop: () => _onWillPop(),
              child: Stack(
          children: <Widget>[
            InkWell(
              onTap: () {
                  pauseVideo(controller);
              },
              child: SizedBox(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: Center(child: _playView())),
            ),
            Positioned(
                child: IndicatorsOnVideo(
              userDocument: widget.userDocument,
              userTrainerDocument: widget.userTrainerDocument,
            )),
          ],
        ),
      ),
    );
  }

   Widget _playView() {
    // FutureBuilder to display a loading spinner until finishes initializing
    return FutureBuilder(
      future: _initializeVideoPlayerFuture,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          chewieController.play();
          return  Chewie(controller: chewieController);
          
        } 
        return EmptyContainer();
      },
    );
  }
 
  /// [_onWillPop]
  ///
  /// async funstion that creates an exit dialog for our screen
  /// YES / NO
  Future<bool> _onWillPop() async {
    chewieController.pause();
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


