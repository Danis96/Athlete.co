import 'package:flutter/cupertino.dart';
import 'package:video_player/video_player.dart';

abstract class ChewieVideoInterface {
  Future<bool> clearPrevious();
  Future<void> startPlay(int index);
  Future<void> initializePlay(int index);
  Future<void> controllerListener();
  showOverlay(BuildContext context);
  pauseVideo(VideoPlayerController controller);
  showGetReady(BuildContext context);
}