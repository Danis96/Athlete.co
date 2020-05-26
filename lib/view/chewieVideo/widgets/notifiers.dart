

import 'package:attt/utils/globals.dart';
import 'package:flutter/material.dart';

class Notifiers extends ValueNotifier<bool> {
  Notifiers(bool value) : super(value);

  showStopwatch() {
    showTime = true;
  }

}