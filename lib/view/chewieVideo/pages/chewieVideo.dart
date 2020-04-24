import 'dart:io';

import 'package:attt/utils/size_config.dart';
import 'package:attt/view/chewieVideo/widgets/chewieListItem.dart';
import 'package:attt/view/chewieVideo/widgets/globals.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class ChewieVideo extends StatelessWidget {
  final DocumentSnapshot userDocument, userTrainerDocument;
  ChewieVideo(this.userDocument, this.userTrainerDocument);

  PageController pageController = PageController(
    initialPage: 0,
  );

  //// private function of parent
  goToNextVideo(int index) {
    pageController.jumpToPage(index + 1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        width: isFinished ? 0 : SizeConfig.blockSizeHorizontal * 90,
        child: PageView(
          physics: NeverScrollableScrollPhysics(),
          controller: pageController,
          children: <Widget>[
            ChewieListItem(
              userTrainerDocument: userTrainerDocument,
              userDocument: userDocument,
              videoPlayerController: VideoPlayerController.network(
                'https://firebasestorage.googleapis.com/v0/b/athlete-254ed.appspot.com/o/C.mp4?alt=media&token=1b9452ce-58c1-4e76-9b21-fbfc9c454f97',
              ),
              goToNextVideo: goToNextVideo,
              index: 0,
            ),
            ChewieListItem(
              userTrainerDocument: userTrainerDocument,
              userDocument: userDocument,
              videoPlayerController: VideoPlayerController.network(
                'https://firebasestorage.googleapis.com/v0/b/athlete-254ed.appspot.com/o/C.mp4?alt=media&token=1b9452ce-58c1-4e76-9b21-fbfc9c454f97',
              ),
              goToNextVideo: goToNextVideo,
              index: 1,
            ),
            ChewieListItem(
              userTrainerDocument: userTrainerDocument,
              userDocument: userDocument,
              videoPlayerController: VideoPlayerController.network(
                'https://firebasestorage.googleapis.com/v0/b/athlete-254ed.appspot.com/o/C.mp4?alt=media&token=1b9452ce-58c1-4e76-9b21-fbfc9c454f97',
              ),
              goToNextVideo: goToNextVideo,
              index: 2,
            ),
          ],
        ),
      ),
    );
  }
}
