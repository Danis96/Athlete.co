import 'dart:async';
import 'package:attt/interface/fullTrainingInterface.dart';
import 'package:attt/utils/globals.dart';


class FullTrainingStopwatch implements FullTrainingInterface {
  
  var duration = Duration(seconds: 1);
   

  /// [keepRunning]
  /// 
  /// here we check if the swatch s running or not,
  /// and setting display time 
  @override
  void keepRunning() {
    if (swatch.isRunning) {
      startTimer();
      print(swatch.elapsed.inSeconds.toString() + ' SECONDS HAS PASSED');
    } else {
      print('STOPWATCH HAS STOPPED++++++++++++++');
    }
    displayTime = swatch.elapsed.inHours.toString().padLeft(2, '0') + ':' +
        (swatch.elapsed.inMinutes % 60).toString().padLeft(2, '0') + ':' +
        (swatch.elapsed.inSeconds % 60).toString().padLeft(2, '0');
  }


  /// [resetStopwatch]
  /// 
  /// here we just reset stopwatch,
  /// and setting displayTime to 00:00:00
  @override
  void resetStopwtach() {
    swatch.reset();
    displayTime = '00:00:00';
    print('FULL TRAINING STOPWATCH HAS RESETED**************************************');
  }
  
  /// [startStopwatch]
  /// 
  /// here we start the stopwatch and activating the timer method [startTimer]
  @override
  void startStopwtach() {
    swatch.start();
    startTimer();
    print('FULL TRAINING STOPWATCH HAS STARTED**************************************');
  }
  

  /// [startTimer]
  /// 
  /// activates tiemr that gets duration, and keepRunning method
  @override
  void startTimer() {
    Timer(duration, keepRunning);
  }

  /// [stopStopwatch]
  /// 
  /// here we stop the stopwatch
  @override
  void stopStopwtach() {
    swatch.stop();
    print('FULL TRAINING STOPWATCH HAS STOPPED***************************************');
  }
}
