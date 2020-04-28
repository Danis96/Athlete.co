import 'dart:async';
import 'package:attt/interface/chewieVideoInterface.dart';
import 'package:attt/storage/storage.dart';
import 'package:attt/utils/alertDialog.dart';
import 'package:attt/utils/emptyContainer.dart';
import 'package:attt/utils/globals.dart';
import 'package:attt/utils/size_config.dart';
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
import 'package:audioplayers/audioplayers.dart';
import 'package:audioplayers/audio_cache.dart';

class ChewieVideo extends StatefulWidget {
  final DocumentSnapshot userDocument, userTrainerDocument;
  final Storage storage;
  ChewieVideo({this.userDocument, this.userTrainerDocument, this.storage});

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
  String videoFromStorage;
  bool isReady = false;
  bool isEnd = false;
  AudioCache audioCache;

  /// this is list of urls (later we will get this data from db)
  List<String> _urls = [
    'https://firebasestorage.googleapis.com/v0/b/athlete-254ed.appspot.com/o/C.mp4?alt=media&token=1b9452ce-58c1-4e76-9b21-fbfc9c454f97',
  ];

  @override
  void initState() {
    super.initState();

    audioCache = AudioCache(
        prefix: "audio/",
        fixedPlayer: AudioPlayer()..setReleaseMode(ReleaseMode.STOP));

    /// when widget inits make that screen rotation
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
    startPlay(_playingIndex + 1);
    alertQuit = false;

    /// read from file system
    widget.storage.readData().then((String value) {
      setState(() {
        _urls.add(value);
        print('Value from file system: ' + value);
        print('URLS FOR VIDEO : ' + _urls.toString());
      });
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print('Widget Update');
    print('ALERTQUIT = ' + alertQuit.toString());

    if (alertQuit) clearPrevious();
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

    if (position.inMilliseconds == 0 && isReady == false) {
      showGetReady(context);
    }

    if (position.inSeconds == duration.inSeconds - 6 && isEnd == false) {
      audioCache.play('zvuk.mp3');
      isEnd = true;
    }

    if (_isPlaying != isPlaying || _isEndPlaying != isEndPlaying) {
      _isPlaying = isPlaying;
      _isEndPlaying = isEndPlaying;
      print(
          "$_playingIndex -----> isPlaying= $isPlaying / isCompletePlaying=$isEndPlaying");
      if (isEndPlaying) {
        final isComplete = _playingIndex == _urls.length - 1;
        if (isComplete) {
          isReady = false;
          audioCache.clear('zvuk.mp3');
          Navigator.of(context).push(MaterialPageRoute(
              builder: (_) => TrainingPlan(
                    userTrainerDocument: widget.userTrainerDocument,
                    userDocument: widget.userDocument,
                  )));
          print("played all!!");
        } else {
          await showOverlay(context);
        }
      }
    }
  }

  @override
  Future<void> initializePlay(int index) async {
    print(_urls[index]);
    final video = _urls[index];
    controller = VideoPlayerController.network(video);
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
  pauseVideo() {
    if (controller.value.isPlaying) {
      chewieController.pause();
    } else {
      chewieController.play();
    }
  }

  @override
  makeReady() {
    setState(() {
      isReady = false;
    });
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

    isEnd = false;

    /// and play the next video
    await startPlay(_playingIndex + 1);
  }

  @override
  showGetReady(BuildContext context) async {
    /// create overlay
    OverlayState overlayState = Overlay.of(context);
    OverlayEntry overlayEntry = OverlayEntry(
        builder: (BuildContext context) =>
            Visibility(visible: true, child: GetReady()));

    /// add to overlay overlayEntry that is rest widget
    overlayState.insert(overlayEntry);

    chewieController.pause();

    /// wait for [rest] time and then remove the overlay widget
    await Future.delayed(Duration(seconds: 5));
    overlayEntry.remove();

    /// and play the next video
    chewieController.play();
    setState(() {
      isReady = true;
    });
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
                pauseVideo();
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
            if (isReady == false) {
              Timer(Duration(milliseconds: 140), () {
                chewieController.pause();
              });
            }
            return Chewie(controller: chewieController);
          }
          return EmptyContainer();
        });
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
            onExit: makeReady,
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
