import 'dart:async';
import 'package:attt/interface/chewieVideoInterface.dart';
import 'package:attt/utils/globals.dart';
import 'package:attt/view/chewieVideo/widgets/globals.dart';
import 'package:attt/view/chewieVideo/widgets/indicatorsOnVideo.dart';
import 'package:attt/view/chewieVideo/widgets/rest.dart';
import 'package:attt/view/trainingPlan/pages/trainingPlan.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';
import 'package:after_init/after_init.dart';

class ChewieVideo extends StatefulWidget {
  final DocumentSnapshot userDocument, userTrainerDocument;
  ChewieVideo({this.userDocument, this.userTrainerDocument});

  @override
  _ChewieVideoState createState() => _ChewieVideoState();
}



/// because we need setState to get video going I implemented interface to ChewieVideoState
class _ChewieVideoState extends State<ChewieVideo>
    implements ChewieVideoInterface {

  GlobalKey scaffold = new GlobalKey();

  int index = 0;
  double _progress = 0;
  bool _changeLock = false;

  /// this is lits of urls (later we will get this data from db)
  List<String> _urls = [
    'https://firebasestorage.googleapis.com/v0/b/athlete-254ed.appspot.com/o/C.mp4?alt=media&token=1b9452ce-58c1-4e76-9b21-fbfc9c454f97',
    'https://firebasestorage.googleapis.com/v0/b/athlete-254ed.appspot.com/o/C.mp4?alt=media&token=1b9452ce-58c1-4e76-9b21-fbfc9c454f97',
    'https://firebasestorage.googleapis.com/v0/b/athlete-254ed.appspot.com/o/C.mp4?alt=media&token=1b9452ce-58c1-4e76-9b21-fbfc9c454f97',
  ];

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
    index = 0;
   
    /// function that inits every controller
   /// after widget is done building call this method
     SchedulerBinding.instance.addPostFrameCallback((_) {
        initControllers();
    }); 
  }

  /// This gets called after didInitState().
  /// And anytime the widget's dependencies change, as usual.
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print('CHANGED DEP');
    // Your code here
  }

  @override
   void setState(fn) {
    if(mounted){
      super.setState(fn);
    }
  }

  @override
  initControllers() {
    controllers.add(null);
    for (int i = 0; i < _urls.length; i++) {
      if (i == 2) {
        break;
      }
      controllers.add(VideoPlayerController.network(_urls[i]));
    }
    attachListenerAndInit(controllers[1]).then((_) {
      controllers[1].play().then((_) {
        setState(() {});
      });
    });

    if (controllers.length > 2) {
      attachListenerAndInit(controllers[2]);
    }
  }

  @override
  Future<void> attachListenerAndInit(VideoPlayerController controller) async {
    if (!controller.hasListeners) {
      controller.addListener(() {
        int dur = controller.value.duration.inMilliseconds;
        int pos = controller.value.position.inMilliseconds;
        setState(() {
          if (dur <= pos) {
            _progress = 0;
          } else {
            _progress = (dur - (dur - pos)) / dur;
          }
        });
        if (dur - pos < 1) {
          controller.seekTo(Duration(milliseconds: 0));
          //// OVDJE SE BUG DESAVA kada drugi put pustimo exercise 
          ///
          /// koliko sam ja shvatio, ovaj context nestane, 
          /// i kada se drugi put video poziva on pozove ovu metodu ona trazi context a njega nema, 
          /// i javlja eror The method 'findAncestorStateOfType' was called on null.
          /// 
          /// 
          showOverlay(context);
        }
      });
    }
    await controller.initialize().then((_) {});
    return;
  }

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
      controllers.insert(0, VideoPlayerController.network(_urls[index - 1]));
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

  @override
  void nextVideo() {
    if (_changeLock) {
      return;
    }
    _changeLock = true;
    if (index == _urls.length - 1) {
      _changeLock = false;
      controllers[1].pause();
      Navigator.of(context).push(MaterialPageRoute(
          builder: (_) => TrainingPlan(
                userTrainerDocument: widget.userTrainerDocument,
                userDocument: widget.userDocument,
              )));
      return;
    }
    controllers[1]?.pause();
    index++;
    // controllers.first?.dispose();
    controllers.removeAt(0);
    if (index != _urls.length - 1) {
      controllers.add(VideoPlayerController.network(_urls[index + 1]));
      attachListenerAndInit(controllers.last);
    }
    controllers[1].play().then((_) {
      setState(() {
        _changeLock = false;
      });
    });
  }

  @override
  showOverlay(BuildContext context) async {
    
    isFinished = true;
    OverlayState overlayState = Overlay.of(context);
    OverlayEntry overlayEntry = OverlayEntry(
        opaque: true,
        builder: (BuildContext context) =>
            Visibility(visible: isFinished, child:  Rest()));
    overlayState.insert(overlayEntry);
    await Future.delayed(Duration(seconds: 10));
    overlayEntry.remove();
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

  @override
  void dispose() {
    // _controllers[1].dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
     
    return Scaffold(
      key: scaffold,

      body: Stack(
        children: <Widget>[
          GestureDetector(
            onTap: () => pauseVideo(controllers[1]),
            child: SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Center(child: VideoPlayer(controllers[1]))),
          ),
          Positioned(
            child: Container(
              height: 10,
              width: MediaQuery.of(context).size.width * _progress,
              color: Colors.white,
            ),
          ),
          Positioned(
              child: IndicatorsOnVideo(
            userDocument: widget.userDocument,
            userTrainerDocument: widget.userTrainerDocument,
          ))
        ],
      ),
    );
  }
}
