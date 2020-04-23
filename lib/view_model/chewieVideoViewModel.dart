import 'package:attt/interface/chewieVideoInterface.dart';
import 'package:attt/view/chewieVideo/pages/chewieVideo.dart';
import 'package:attt/view/chewieVideo/widgets/globals.dart';
import 'package:attt/view/chewieVideo/widgets/rest.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class ChewieVideoViewModel implements ChewieVideoInterface {
  @override
  goToNextVideo(int index, PageController pageController) {
    pageController.jumpToPage(index + 1);
    print('Idemo na video ' + (index + 1).toString());
  }

  @override
  playVideo(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => ChewieVideo(),
      ),
    );
  }

  @override
  showOverlay(BuildContext context) async {
    isFinished = true;
    OverlayState overlayState = Overlay.of(context);
    OverlayEntry overlayEntry = OverlayEntry(
        builder: (context) => Visibility(visible: isFinished, child: Rest()));
    overlayState.insert(overlayEntry);
    await Future.delayed(Duration(seconds: 32));
    overlayEntry.remove();
    isFinished = false;
  }

  @override
  pauseVideo(VideoPlayerController controller) {
    if (controller.value.isPlaying) {
      controller.pause();
    } else {
      controller.play();
    }
  }
}
