
import 'package:flutter/material.dart';

class ChangeBtnColor extends ValueNotifier<String> {
  ChangeBtnColor(String value) : super(value);

  changeToBlack() {
    value = 'black';
  }

}