import 'package:cloud_firestore/cloud_firestore.dart';

class Warmup {
   final String warmupName, warmupDescription, warmupImage, warmupID;

   Warmup({this.warmupDescription, this.warmupID, this.warmupImage, this.warmupName});


   factory Warmup.fromDocument(DocumentSnapshot doc) {
      return Warmup(
        warmupName: doc['name'],
        warmupDescription: doc['warmup_desc'],
        warmupID: doc['warmupID'],
        warmupImage: doc['warmup_image']
      );
   }
}