import 'package:attt/view/chewieVideo/widgets/globals.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'dart:async';

///REST
class Rest extends StatefulWidget {
  final Function refresh;
  Rest({this.refresh});

  @override
  _RestState createState() => _RestState();
}

class _RestState extends State<Rest> {
  @override
  void initState() {
    super.initState();
    
    startTimer();
    chewieController.pause();
    _audioCache = AudioCache(
        prefix: "audio/",
        fixedPlayer: AudioPlayer()..setReleaseMode(ReleaseMode.STOP));
  }

  AudioCache _audioCache;
  Timer _timer;

  /// ovdje  uzimamo rest iz baze iz exercises
  int _start = 30;
  bool _isLessThan10 = false;

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) => setState(
        () {
          if (_start < 1) {
            timer.cancel();
            chewieController.play();
          } else {
            _start = _start - 1;
            if (_start < 10) {
              setState(() {
                _isLessThan10 = true;
              });
              if (_start == 5) _audioCache.play('zvuk.mp3');
            }
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(0, 0, 0, 0.8),
      body: Center(
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
            )
          ],
        ),
      ),
    );
  }
}
