import 'package:attt/storage/storage.dart';
import 'package:attt/view/chewieVideo/widgets/globals.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:attt/view/chewieVideo/pages/chewieVideo.dart';
import 'package:flutter/services.dart';

///REST
class GetReady extends StatefulWidget {
  final DocumentSnapshot userDocument, userTrainerDocument;
  GetReady({this.userDocument, this.userTrainerDocument});

  @override
  _GetReadyState createState() => _GetReadyState();
}

class _GetReadyState extends State<GetReady> with TickerProviderStateMixin {
  AnimationController _controller1;
  Animation<Offset> _offsetAnimation1;

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.landscapeRight, DeviceOrientation.landscapeLeft]);
    _controller1 = AnimationController(
      duration: const Duration(milliseconds: 900),
      vsync: this,
    )..forward();

    _offsetAnimation1 = Tween<Offset>(
      begin: const Offset(0.0, 1.0),
      end: const Offset(0.0, 0.0),
    ).animate(CurvedAnimation(
      parent: _controller1,
      curve: Curves.easeInOut,
    ));

    startTimer();
  }

  // AudioCache _audioCache;
  Timer _timer;

  /// ovdje  uzimamo rest iz baze iz exercises
  int _start = 5;
  bool _isLessThan10 = false;
  int counter = 0;

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) => setState(
        () {
          setState(() {
            counter++;
          });
          if (counter > 5) {
            Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (_) => ChewieVideo(
                      userDocument: widget.userDocument,
                      userTrainerDocument: widget.userTrainerDocument,
                      storage: Storage(),
                    )));
          }
          if (_start < 1) {
            timer.cancel();
            setState(() {
              isFinished = false;
            });
          } else {
            _start = _start - 1;
            if (_start < 5) {
              setState(() {
                _isLessThan10 = true;
              });
              //  / if (_start == 5) _audioCache.play('zvuk.mp3');
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
      backgroundColor: Color.fromRGBO(0, 0, 0, 0.4),
      body: SlideTransition(
        position: _offsetAnimation1,
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Container(
                child: Text('GET READY',
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
      ),
    );
  }
}
