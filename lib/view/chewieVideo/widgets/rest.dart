import 'package:flutter/material.dart';
import 'dart:async';
import 'package:attt/utils/globals.dart';

///REST
class Rest extends StatefulWidget {
  final int rest;
  Rest({this.rest});
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<Rest> with TickerProviderStateMixin {
  AnimationController _controller1;
  Animation<Offset> _offsetAnimation1;

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
  }

  Timer _timer;

  int _start;
  bool _isLessThan10 = false;



  void startTimer() async {
    _start = widget.rest;
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) => setState(
        () {
          if (_start < 1) {
            _timer.cancel();
          } else {
            _start = _start - 1;
            if (_start < 10) {
                _isLessThan10 = true;
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
              Text(
                _isLessThan10 ? '00:0' + '$_start' : '00:' + "$_start",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 48.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
