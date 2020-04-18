import 'package:cloud_firestore/cloud_firestore.dart';

class Series {
  final String name, seriesID;

  Series({this.name, this.seriesID});

  factory Series.fromDocument(DocumentSnapshot doc) {
     return Series(
        name: doc['name'],
        seriesID: doc['seriesID']
     );
  }
}