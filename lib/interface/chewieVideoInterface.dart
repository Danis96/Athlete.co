import 'package:flutter/cupertino.dart';
import 'package:video_player/video_player.dart';

abstract class ChewieVideoInterface {
  initControllers();
  Future<void> attachListenerAndInit(VideoPlayerController controller);
  void previousVideo();
  void nextVideo();
  showOverlay(BuildContext context);
  pauseVideo(VideoPlayerController controller);
}