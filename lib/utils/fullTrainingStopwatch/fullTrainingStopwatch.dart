import 'dart:async';
import 'package:attt/interface/fullTrainingInterface.dart';
import 'package:attt/utils/globals.dart';


class FullTrainingStopwatch implements FullTrainingInterface {
  
  // var swatch = Stopwatch();
  var duration = Duration(seconds: 1);

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

  @override
  void resetStopwtach() {
    swatch.reset();
    displayTime = '00:00:00';
    print('FULL TRAINING STOPWATCH HAS RESETED**************************************');
  }

  @override
  void startStopwtach() {
    swatch.start();
    startTimer();
    print('FULL TRAINING STOPWATCH HAS STARTED**************************************');
  }

  @override
  void startTimer() {
    Timer(duration, keepRunning);
  }

  @override
  void stopStopwtach() {
    swatch.stop();
    print('FULL TRAINING STOPWATCH HAS STOPPED***************************************');
  }
}
