import 'package:flutter/cupertino.dart';
import 'package:video_player/video_player.dart';

abstract class ChewieVideoInterface {
   goToNextVideo(int index, PageController pageController);
   playVideo(BuildContext context);
   showOverlay(BuildContext context);
   pauseVideo(VideoPlayerController controller);
}