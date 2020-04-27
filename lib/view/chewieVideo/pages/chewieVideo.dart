import 'dart:async';
import 'package:attt/interface/chewieVideoInterface.dart';
import 'package:attt/utils/globals.dart';
import 'package:attt/view/chewieVideo/widgets/globals.dart';
import 'package:attt/view/chewieVideo/widgets/indicatorsOnVideo.dart';
import 'package:attt/view/chewieVideo/widgets/rest.dart';
import 'package:attt/view/trainingPlan/pages/trainingPlan.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
  GlobalKey scaffold = new GlobalKey();

  bool _changeLock = false;

  /// this is list of urls (later we will get this data from db)
  List<String> _urls = [
    // 'https://firebasestorage.googleapis.com/v0/b/athlete-254ed.appspot.com/o/C.mp4?alt=media&token=1b9452ce-58c1-4e76-9b21-fbfc9c454f97',
    // 'https://firebasestorage.googleapis.com/v0/b/athlete-254ed.appspot.com/o/C.mp4?alt=media&token=1b9452ce-58c1-4e76-9b21-fbfc9c454f97',
    // 'https://firebasestorage.googleapis.com/v0/b/athlete-254ed.appspot.com/o/C.mp4?alt=media&token=1b9452ce-58c1-4e76-9b21-fbfc9c454f97',
    'assets/videos/C.mp4',
    'assets/videos/C.mp4',
    'assets/videos/C.mp4',
    // 'assets/videos/C.mp4',
    // 'assets/videos/C.mp4'
  ];

  @override
  void initState() {
    super.initState();

    /// when widget inits make that screen rotation
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);

    initControllers();
  }

  /// This gets called after didInitState().
  /// And anytime the widget's dependencies change, as usual.
  /// I left prints so that we can follow how our videos are going
  /// index is very important here
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print('IsExerciseDone : ' + isExerciseDone.toString());

    /// if exercise is done and double check that index is 0
    /// we reinitialize our controllers so that we can play the whole
    /// loop of videos again
    if (isExerciseDone == true && index == 0) {
      if (index != _urls.length - 2) {
        /// we dispose last controller and remove it
        controllers.last?.dispose();
        controllers.removeLast();
      }
      if (index != 0) {
        /// while index is different then zero we need to
        /// fullfill our controllers with videos from the ist
        controllers.insert(0, VideoPlayerController.asset(_urls[index - 1]));
        attachListenerAndInit(controllers.first);
      } else {
        /// if index is zero set on the first item null
        controllers.insert(0, null);
      }
      print('INITO SAM CONTROLLERE zato sto se workout zavrsio');
    } else {
      print('NISAM INITO NE TREBAM workout se jos nije zavrsio');
    }
    print('Index iz didChange: ' + index.toString());

    /// setState is here so that we reinitialize our changes in the element three
    setState(() {});

    /// this is important, no matter how many times we press start controllers length
    /// always needs to be the legth of the urls
    controllers.length = 3;

    /// and after all that we set [isExerciseDone] on false so that process can continue
    isExerciseDone = false;
  }

  /// in case that our widget lose his status in widget three
  /// we need to check if it is mounted, if it is we will use his setState function
  /// so that we can reach on that contex
  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  /// this is where magic happens
  /// we loop over urls and for every item we add controller and
  /// get him one of the urls
  @override
  initControllers() {
    print('INIT INITSTATE');
    controllers.add(null);
    for (int i = 0; i < _urls.length; i++) {
      if (i == _urls.length - 1) {
        break;
      }
      controllers.add(VideoPlayerController.asset(_urls[i]));
    }

    /// then we need to atach listeners and INITIALIZE the controller
    /// after play we need to setState that changes occure
    attachListenerAndInit(controllers[1]).then((_) {
      controllers[1].play().then((_) {
        setState(() {});
      });
    });

    if (controllers.length > 2) {
      attachListenerAndInit(controllers[2]);
    }
  }

  /// this method has VideoPlayerController as parameter and here is where
  /// we check for the duration of video and show rest screen if the video is finishe
  @override
  Future<void> attachListenerAndInit(VideoPlayerController controller) async {
    if (!controller.hasListeners) {
      controller.addListener(() {
        int dur = controller.value.duration.inMilliseconds;
        int pos = controller.value.position.inMilliseconds;

        if (dur - pos < 1) {
          controller.seekTo(Duration(milliseconds: 0));

          /// showing rest screen
          showOverlay(context);
        }
      });
    }
    await controller.initialize().then((_) {});
    return;
  }

  /// this function we do not use but we might in the future
  /// so I left it
  @override
  void previousVideo() {
    if (_changeLock) {
      return;
    }
    _changeLock = true;

    if (index == 0) {
      _changeLock = false;
      return;
    }
    controllers[1]?.pause();
    index--;

    if (index != _urls.length - 2) {
      controllers.last?.dispose();
      controllers.removeLast();
    }
    if (index != 0) {
      controllers.insert(0, VideoPlayerController.asset(_urls[index - 1]));
      attachListenerAndInit(controllers.first);
    } else {
      controllers.insert(0, null);
    }

    controllers[1].play().then((_) {
      setState(() {
        _changeLock = false;
      });
    });
  }

  /// this is function for playing the next video
  @override
  void nextVideo() {
    if (_changeLock) {
      return;
    }
    _changeLock = true;

    /// here we check if the index is equal to the urls length
    ///  and we pause the video, set [isExerciseDone] to true
    /// index to 0, and navigate to the TrainingPlan screen
    if (index == _urls.length - 1) {
      _changeLock = false;
      controllers[1].pause();
      isExerciseDone = true;
      index = 0;
      Navigator.of(context).push(MaterialPageRoute(
          builder: (_) => TrainingPlan(
                userTrainerDocument: widget.userTrainerDocument,
                userDocument: widget.userDocument,
              )));

      return;
    }
    controllers[1]?.pause();
    index++;
    controllers.first?.dispose();
    controllers.removeAt(0);
    if (index != _urls.length - 1) {
      controllers.add(VideoPlayerController.asset(_urls[index + 1]));
      attachListenerAndInit(controllers.last);
    }
    controllers[1].play().then((_) {
      setState(() {
        _changeLock = false;
      });
    });
  }

  /// this is how we show the rest screen
  /// [isFinished] is for visibility of Rest screen
  @override
  showOverlay(BuildContext context) async {
    isFinished = true;

    /// create overlay
    OverlayState overlayState = Overlay.of(context);
    OverlayEntry overlayEntry = OverlayEntry(
        opaque: true,
        builder: (BuildContext context) =>
            Visibility(visible: isFinished, child: Rest()));

    /// add to overlay overlayEntry that is rest widget
    overlayState.insert(overlayEntry);

    /// wait for [rest] time and then remove the overlay widget
    await Future.delayed(Duration(seconds: 10));
    overlayEntry.remove();

    /// and play the next video
    nextVideo();
  }

  @override
  pauseVideo(VideoPlayerController controller) {
    if (controller.value.isPlaying) {
      controller.pause();
      isPaused = true;
    } else {
      controller.play();
      isPaused = false;
    }
  }

  /// disposing player controller
  /// and the whole widget
  @override
  void dispose() {
    controllers[1].dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffold,
      body: Stack(
        children: <Widget>[
          InkWell(
            onTap: () {
              setState(() {
                pauseVideo(controllers[1]);
              });
            },
            child: SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Center(child: VideoPlayer(controllers[1]))),
          ),
          Positioned(
              child: IndicatorsOnVideo(
            userDocument: widget.userDocument,
            userTrainerDocument: widget.userTrainerDocument,
          )),
        ],
      ),
    );
  }
}
