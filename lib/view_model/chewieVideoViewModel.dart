import 'package:attt/storage/storage.dart';
import 'package:attt/view/chewieVideo/pages/chewieVideo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChewieVideoViewModel {
  playVideo(BuildContext context, DocumentSnapshot userDocument,
      DocumentSnapshot userTrainerDocument) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (_) => ChewieVideo(
              userDocument: userDocument,
              userTrainerDocument: userTrainerDocument,
              storage: Storage(),
            )));
  }
}
