import 'package:attt/view/chewieVideo/widgets/chewieListItem.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class ChewieVideo extends StatelessWidget {
  
  PageController pageController = PageController(
    initialPage: 0,
  );

  //// private function of parent
   goToNextVideo(int index) {
      pageController.jumpToPage(index + 1);
      print('Idemo na video ' + (index + 1).toString());
    }
  

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: PageView(
          controller: pageController,
          children: <Widget>[
            ChewieListItem(
      videoPlayerController: VideoPlayerController.network(
        'https://firebasestorage.googleapis.com/v0/b/athlete-254ed.appspot.com/o/C.mp4?alt=media&token=1b9452ce-58c1-4e76-9b21-fbfc9c454f97',
      ),
      looping: true,
      goToNextVideo: goToNextVideo,
      index: 0,
            ),
            ChewieListItem(
      videoPlayerController: VideoPlayerController.network(
        'https://firebasestorage.googleapis.com/v0/b/athlete-254ed.appspot.com/o/C.mp4?alt=media&token=1b9452ce-58c1-4e76-9b21-fbfc9c454f97',
      ),
      goToNextVideo: goToNextVideo,
      index: 1,
            ),
            ChewieListItem(
      videoPlayerController: VideoPlayerController.network(
        'https://firebasestorage.googleapis.com/v0/b/athlete-254ed.appspot.com/o/C.mp4?alt=media&token=1b9452ce-58c1-4e76-9b21-fbfc9c454f97',
      ),
      goToNextVideo: goToNextVideo,
      index: 2,
            ),
          ],
        ),
    );
  }
}