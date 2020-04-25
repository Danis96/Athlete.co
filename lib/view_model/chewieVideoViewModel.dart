import 'package:attt/interface/chewieVideoInterface.dart';
import 'package:attt/utils/globals.dart';
import 'package:attt/view/chewieVideo/pages/chewieVideo.dart';
import 'package:attt/view/chewieVideo/widgets/globals.dart';
import 'package:attt/view/chewieVideo/widgets/rest.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class ChewieVideoViewModel {
  playVideo(BuildContext context, DocumentSnapshot userDocument,
      DocumentSnapshot userTrainerDocument) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (_) => ChewieVideo(
              userDocument: userDocument,
              userTrainerDocument: userTrainerDocument,
            )));
  }
}
