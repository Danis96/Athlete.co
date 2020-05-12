import 'package:attt/utils/colors.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:attt/utils/globals.dart';

///REST
class Rest extends StatefulWidget {
  final int rest;
  final Function playNext;
  final OverlayEntry overlayEntry;
  Rest({this.rest, this.playNext, this.overlayEntry});
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<Rest> with TickerProviderStateMixin {
  AnimationController _controller1;
  Animation<Offset> _offsetAnimation1;
  AudioCache _audioCache;
  AudioPlayer audioPlayer;

  @override
  void initState() {
    super.initState();
    isRestSkipped = false;
    _controller1 = AnimationController(
      duration: const Duration(milliseconds: 900),
      vsync: this,
    )..forward();

    _offsetAnimation1 = Tween<Offset>(
      begin: const Offset(1.0, 0.0),
      end: const Offset(0.0, 0.0),
    ).animate(CurvedAnimation(
      parent: _controller1,
      curve: Curves.easeInOut,
    ));

    startTimer();
    _audioCache = AudioCache(
        prefix: "audio/",
        fixedPlayer: AudioPlayer()..setReleaseMode(ReleaseMode.STOP));
  }

  // AudioCache _audioCache;
  Timer _timer;

  /// ovdje  uzimamo rest iz baze iz exercises
  int _start;
  bool _isLessThan10 = false;

  initializeAudioPlayer() async {
    audioPlayer = await _audioCache.play('zvuk.mp3');
  }

  void startTimer() async {
    _start = widget.rest;
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) => setState(
        () {
          if (_start < 1) {
            isRestSkipped = true;
            _timer.cancel();
            widget.overlayEntry.remove();
            restGoing = false;
            widget.playNext();
            setState(() {
              restShowed = false;
            });
          } else {
            _start = _start - 1;
            if (_start < 10) {
              setState(() {
                _isLessThan10 = true;
              });
              if (_start == 5) {
                initializeAudioPlayer();
              }
            }
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    _controller1.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(0, 0, 0, 0.6),
      body: SlideTransition(
        position: _offsetAnimation1,
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Container(
                child: Text('REST',
                    style: TextStyle(
                        color: Colors.white,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold,
                        fontSize: 48.0)),
              ),
              Text(
                _isLessThan10 ? '00:0' + '$_start' : '00:' + "$_start",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 48.0),
              ),
              Container(
                child: FlatButton(
                    onPressed: () {
                      isRestSkipped = true;
                      _timer.cancel();
                      if (_start <= 5) {
                        audioPlayer.stop();
                      }
                      widget.overlayEntry.remove();
                      restGoing = false;
                      widget.playNext();
                      print('REST SKIPPED: ' + isRestSkipped.toString());
                    },
                    child: Text('Skip',
                        style:
                            TextStyle(color: MyColors().white, fontSize: 25))),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
