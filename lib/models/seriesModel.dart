import 'package:cloud_firestore/cloud_firestore.dart';

class Series {
  final String name;

  Series({this.name});

  factory Series.fromDocument(DocumentSnapshot doc) {
     return Series(
        name: doc['name']
     );
  }
}