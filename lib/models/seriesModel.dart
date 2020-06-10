import 'package:cloud_firestore/cloud_firestore.dart';

class Series {
  final String name, seriesID, circuit;

  Series({this.name, this.seriesID, this.circuit});

  factory Series.fromDocument(DocumentSnapshot doc) {
     return Series(
        name: doc['name'],
        seriesID: doc['seriesID'],
        circuit: doc['circuit'],
     );
  }
}