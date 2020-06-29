import 'dart:async';

import 'package:attt/utils/colors.dart';
import 'package:attt/utils/size_config.dart';
import 'package:flutter/material.dart';

int _counter = 0;
String pause = 'PAUSE TIMER', done = 'DONE', start = 'START TIMER', green = 'green', red = 'red';

class BtnTimer extends StatefulWidget {
  final Timer timer;
  final String colorStatePaused;
  final int index, listLenght;
  final Function pauseTimer, playTimer, playNext, resetTimer;

  BtnTimer({
    this.colorStatePaused,
    this.playTimer,
    this.pauseTimer,
    this.timer,
    this.index,
    this.listLenght,
    this.playNext,
    this.resetTimer,
  });

  @override
  _BtnTimerState createState() => _BtnTimerState();
}

class _BtnTimerState extends State<BtnTimer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: SizeConfig.blockSizeHorizontal * 60,
      height: SizeConfig.blockSizeVertical * 5,
      child: RaisedButton(
        color: widget.timer != null
            ? !widget.timer.isActive
                ? widget.colorStatePaused == green
                    ? Colors.green
                    : MyColors().lightBlack
                : widget.colorStatePaused == red
                    ? MyColors().error
                    : MyColors().lightBlack
            : MyColors().lightBlack,
        child: Text(
          widget.timer != null
              ? !widget.timer.isActive
                  ? widget.colorStatePaused == green ? done : start
                  : widget.colorStatePaused == red ? pause : start
              : start,
          style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: SizeConfig.safeBlockHorizontal * 4),
        ),
        onPressed: () {
          setState(() {});
          widget.colorStatePaused == green ? doneAfterTime() : playBtn();
        },
      ),
    );
  }

  doneAfterTime() {
    widget.playNext();
    widget.resetTimer();
  }

  playBtn() {
    if (_counter == 0) {
      widget.timer != null
          ? widget.timer.isActive ? widget.pauseTimer() : widget.playTimer()
          : widget.playTimer();
      _counter = 1;
      Timer(Duration(seconds: 1), () {
        _counter = 0;
      });
    }
  }
}
