import 'package:flutter/cupertino.dart';

abstract class ChewieVideoInterface {
  Future<bool> clearPrevious();
  Future<void> startPlay(int index);
  Future<void> initializePlay(int index);
  Future<void> controllerListener();
  showOverlay(BuildContext context, int index);
  showGetReady(BuildContext context);
  makeReady();
}