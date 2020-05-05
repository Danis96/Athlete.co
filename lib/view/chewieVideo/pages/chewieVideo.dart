import 'dart:async';
import 'package:attt/interface/chewieVideoInterface.dart';
import 'package:attt/storage/storage.dart';
import 'package:attt/utils/alertDialog.dart';
import 'package:attt/utils/emptyContainer.dart';
import 'package:attt/utils/globals.dart';
import 'package:attt/view/chewieVideo/widgets/getReady.dart';
import 'package:attt/view/chewieVideo/widgets/globals.dart';
import 'package:attt/view/chewieVideo/widgets/indicatorsOnVideo.dart';
import 'package:attt/view/chewieVideo/widgets/paused.dart';
import 'package:attt/view/chewieVideo/widgets/rest.dart';
import 'package:attt/view/trainingPlan/pages/trainingPlan.dart';
import 'package:attt/view/workout/widgets/info.dart';
import 'package:chewie/chewie.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
  int _playingIndex;
  var _isPlaying = false;
  var _isEndPlaying = false;
  String videoFromStorage;
  bool isReady = false;
  bool isEnd = false;
  AudioCache audioCache;
  UniqueKey uniqueKey;
  int videoDuration;
  int videoPosition;

  VideoPlayerController controller;

  /// this is list of urls (later we will get this data from file system and db)
  List<dynamic> _urls = [
    'assets/video/C.mp4',
    'assets/video/C.mp4',
    'assets/video/F.mp4',
    'assets/video/C.mp4',
    'assets/video/F.mp4',
    // 'assets/video/C.mp4',
    // 'assets/video/C.mp4',
    // 'assets/video/F.mp4',
    // 'assets/video/C.mp4',
    // 'assets/video/C.mp4',
    // 'assets/video/C.mp4',
    // 'assets/video/F.mp4',
    // 'assets/video/C.mp4',
    // 'assets/video/C.mp4',
    // 'assets/video/C.mp4',
    // 'assets/video/F.mp4',
    // 'assets/video/C.mp4',
    // 'https://firebasestorage.googleapis.com/v0/b/athlete-254ed.appspot.com/o/C.mp4?alt=media&token=1b9452ce-58c1-4e76-9b21-fbfc9c454f97',
    // 'https://firebasestorage.googleapis.com/v0/b/athlete-254ed.appspot.com/o/C.mp4?alt=media&token=1b9452ce-58c1-4e76-9b21-fbfc9c454f97',
    // 'https://firebasestorage.googleapis.com/v0/b/athlete-254ed.appspot.com/o/asddasasd.mp4?alt=media&token=2687d82b-7cc0-4dc8-81e1-1e26b1ea9963',
    // 'https://firebasestorage.googleapis.com/v0/b/athlete-254ed.appspot.com/o/C.mp4?alt=media&token=1b9452ce-58c1-4e76-9b21-fbfc9c454f97',
  ];

  @override
  void initState() {
    super.initState();
    //  

    /// initialize audio sound
    audioCache = AudioCache(
        prefix: "audio/",
        fixedPlayer: AudioPlayer()..setReleaseMode(ReleaseMode.STOP));

    /// when widget inits make that screen rotation
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);

    /// set [_playingIndex] always on -1 on initialize of widget for the firs time
    _playingIndex = -1;

    /// checking for controllers, for theirs listeners
    /// if contrtollers are in any case assigned or not disposed to dispose them
    if (controller != null) {
      disposed = true;
      // By assigning Future is null,
      // prevent the video controller is using in widget before disposing that.
      initializeVideoPlayerFuture = null;
      // In my case, sound is playing though controller was disposed.
      controller?.pause()?.then((_) {
        // dispose VideoPlayerController.
        controller?.dispose();
      });
      print('DISPOSED');
    }

    /// 1. Lifecycle begins
    startPlay(_playingIndex + 1);

    /// [alertQuit] must be false on initialize of the widget
    /// for alert dialog on back button
    alertQuit = false;

    /// read from file system
    widget.storage.readData().then((String value) {
      setState(() {
        // _urls.add(value);
        print('Value from file system: ' + value);
        print('URLS FOR VIDEO : ' + _urls.toString());
      });
    });
  }

  /// [didChangeDependecies] activates every time some changes happen
  /// in child or this widget
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print('Widget Update');
    print('ALERTQUIT = ' + alertQuit.toString());
    print('RRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRr' +
        _urls.length.toString());

    /// clearPrevious items if alertQuit is true
    if (alertQuit) clearPrevious();
  }

  @override
  void dispose() {
    super.dispose();
    disposed = true;
    // By assigning Future is null,
    // prevent the video controller is using in widget before disposing that.
    initializeVideoPlayerFuture = null;
    // In my case, sound is playing though controller was disposed.
    controller?.pause()?.then((_) {
      // dispose VideoPlayerController.
      controller?.dispose();
    });
  }

  /// we just pause the controller and then remove listeners
  @override
  Future<bool> clearPrevious() async {
    await controller?.pause();
    controller?.removeListener(controllerListener);
    return true;
  }

  /// [startPlay]
  ///
  /// as parameter it gets the index for video playing
  /// it is [_playingIndex] + 1
  /// then we activate [initializePlat] function that takes the same parameter
  @override
  Future<void> startPlay(int index) async {
    print("Play ---------> $index");
    print(
        'AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA');
    print(_urls.length);
    setState(() {
      initializeVideoPlayerFuture = null;
    });
    Future.delayed(const Duration(milliseconds: 200), () {
      // clearPrevious().then((_) {
      initializePlay(index);
      // });
    });
  }

  /// 2. of Lifecycle method [initializePlay]
  ///
  /// it takes index from startPlay function
  /// here we take videos from the list,
  /// assign them to controller,
  /// add listener to controller , then create [chewieController]
  /// then we need to initialize the controller
  /// and set _playingIndex to increase for 1
  initializePlay(int index) async {
    final video = _urls[index];
    controller = VideoPlayerController.network(video);
    controller.addListener(controllerListener);
    chewieController = ChewieController(
        videoPlayerController: controller,
        fullScreenByDefault: true,
        allowFullScreen: true,
        showControls: false,
        autoInitialize: false,
        autoPlay: true);
    initializeVideoPlayerFuture = controller.initialize();
    setState(() {
      _playingIndex++;
      isEnd = false;
    });
    chewieController.play();
  }

  /// 3. Lifecycle [controllerListener]
  ///
  /// here we check for everything
  /// we check video length, duration, and base on that
  /// we show [getReady] screen,
  /// we show [showOverlay] (rest screen)
  /// and if videos are done, playy all, we navigate to [trainigPlan]
  @override
  Future<void> controllerListener() async {
    if (controller == null || disposed) {
      return;
    }
    if (!controller.value.initialized) {
      return;
    }
    var position = await controller.position;

    /// [controller.value.duraton] - duration is null when [initialized] is null
    var duration = controller.value.duration;
    var isPlaying = position.inMilliseconds < duration.inMilliseconds;
    var isEndPlaying =
        position.inMilliseconds > 0 && position.inSeconds == duration.inSeconds;

    videoDuration = duration.inSeconds;
    videoPosition = position.inSeconds;

    if (position.inSeconds == 0 && isReady == false) {
      showGetReady(context);
      isReady = true;
    }
    if (position.inSeconds == duration.inSeconds - 6 && isEnd == false) {
      audioCache.play('zvuk.mp3');
      isEnd = true;
    }
    if (_isPlaying != isPlaying || _isEndPlaying != isEndPlaying) {
      _isPlaying = isPlaying;
      _isEndPlaying = isEndPlaying;
      print(
          "$_playingIndex -----> isPlaying = $isPlaying / isCompletePlaying = $isEndPlaying");
      print(
          'AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA');
      print(_urls.length);
      if (isEndPlaying) {
        final isComplete = _playingIndex == _urls.length - 1;
        if (isComplete) {
          isReady = false;
          audioCache.clear('zvuk.mp3');
          initializeVideoPlayerFuture = null;
           chewieController.dispose();
           await controller.dispose();
          Navigator.of(context).push(MaterialPageRoute(
              maintainState: false,
              builder: (_) => TrainingPlan(
                    userTrainerDocument: widget.userTrainerDocument,
                    userDocument: widget.userDocument,
                  )));
          print("Played ALL!!");
        } else {
          if (_playingIndex == _urls.length - 1) {
            print('ENDEEEEEEEEEEEEE');
          } else {
            if (exerciseSnapshots[_playingIndex].data['isReps'] != 0) {
              await showOverlay(context, _playingIndex);
            }
          }
        }
      }
    }
  }

  /// 4. Lifecycle [nextPlay]
  ///
  /// here we create for every next video, his own controller,
  /// dispose the previous controller that was active
  nextPlay(int index) async {
    print(index + 1);

    setState(() {
      initializeVideoPlayerFuture = null;
    });
    Future.delayed(const Duration(milliseconds: 200), () async {
      clearPrevious().then((_) {
        initializeNew(index);
      });
    });
  }

  initializeNew(int index) async {
    final videos = _urls[index + 1];
    controller = VideoPlayerController.network(videos);
    controller.addListener(controllerListener);

    chewieController.dispose();
    controller.pause();
    print('KREIRAM NOVI CONTROLLER');
    chewieController = ChewieController(
      videoPlayerController: controller,
      fullScreenByDefault: true,
      allowFullScreen: true,
      showControls: false,
      autoPlay: true,
      looping: exerciseSnapshots[_playingIndex].data['isReps'] != 0 ? true : false
    );
    initializeVideoPlayerFuture = controller.initialize();

    print(controller.toString() + ' CONTROLLER');
    print('KREIRAO SAM NOVI CONTROLLER');
    setState(() {
      _playingIndex++;
      isEnd = false;
    });
    print('CHEWIE PLAY');
    chewieController.play();
  }

  /// pause video function for video
  /// pause the controller ,
  /// show Overlay PAUSED container
  @override
  pauseVideo() {
    chewieController.pause();
    showPaused(context, true);
    overlayStatePaused.insert(overlayEntryPaused);
  }

  @override
  showPaused(BuildContext context, bool visible) async {
    overlayStatePaused = Overlay.of(context);
    overlayEntryPaused = OverlayEntry(
        builder: (BuildContext context) =>
            Visibility(visible: true, child: Paused()));
  }

  @override
  makeReady() {
    setState(() {
      isReady = false;
    });
  }

  /// [showOverlay]
  ///
  /// here we show the rest screen for how many seconds we need it to be on the screen
  showOverlay(BuildContext context, int index) async {
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
    repsDone = false;

    /// and play the next video
    await nextPlay(index);
  }

  @override
  showGetReady(BuildContext context) async {
    /// create overlay
    OverlayState overlayState = Overlay.of(context);
    OverlayEntry overlayEntry = OverlayEntry(
        builder: (BuildContext context) =>
            Visibility(visible: true, child: GetReady()));

    /// add to overlay overlayEntry that is getReady widget
    overlayState.insert(overlayEntry);

    chewieController.pause();

    /// wait for [getReady] time and then remove the overlay widget
    await Future.delayed(Duration(seconds: 5));
    overlayEntry.remove();

    // /// and play the next video
    chewieController.play();
    setState(() {
      isReady = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: uniqueKey,
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
                  index: _playingIndex,
                  duration: videoDuration,
                  position: videoPosition,
                  showRest: showOverlay),
            ),
          ],
        ),
      ),
    );
  }

  Widget _playView() {
    // FutureBuilder to display a loading spinner until finishes initializing
    return FutureBuilder(
        future: initializeVideoPlayerFuture,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Chewie(controller: chewieController);
          }
          return EmptyContainer();
        });
  }

  /// [_onWillPop]
  ///
  /// async funstion that creates an exit dialog for our screen
  /// CONTINUE / CANCEL
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
