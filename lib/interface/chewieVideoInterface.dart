import 'package:flutter/cupertino.dart';

abstract class ChewieVideoInterface {
   goToNextVideo(int index, PageController pageController);
   playVideo(BuildContext context);
   showOverlay(BuildContext context);
}