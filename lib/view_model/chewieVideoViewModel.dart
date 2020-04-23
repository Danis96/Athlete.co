import 'package:attt/interface/chewieVideoInterface.dart';
import 'package:attt/utils/globals.dart';
import 'package:attt/view/chewieVideo/pages/chewieVideo.dart';
import 'package:attt/view/chewieVideo/widgets/globals.dart';
import 'package:attt/view/chewieVideo/widgets/rest.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class ChewieVideoViewModel implements ChewieVideoInterface {
  @override
  goToNextVideo(int index, PageController pageController) {
    pageController.jumpToPage(index + 1);
    print('Idemo na video ' + (index + 1).toString());
  }

  @override
  playVideo(
      DocumentSnapshot userDocument,
      DocumentSnapshot userTrainerDocument,
      BuildContext context,
      String trainerID,
      String workoutName,
      String workoutID,
      String weekID,
      String warmupDesc) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => ChewieVideo(
            userDocument,
            userTrainerDocument,
            warmupDesc,
            weekID,
            workoutName,
            trainerID,
            workoutID),
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
    overlayEntry.maintainState = false;
    await Future.delayed(Duration(seconds: 32));
    overlayEntry.remove();
    isFinished = false;
  }

  @override
  pauseVideo(VideoPlayerController controller) {
    if (controller.value.isPlaying) {
      controller.pause();
      isPaused = true;
    } else {
      controller.play();
      isPaused = false;
    }
  }
}
