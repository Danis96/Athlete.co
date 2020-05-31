import 'package:attt/interface/chooseAthleteInterface.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChooseAthleteViewModel implements ChooseAthleteInterface {
  @override
  Future getTrainers() async {
    var firestore = Firestore.instance;
    QuerySnapshot qn = await firestore
        .collection('Trainers')
        .getDocuments();
    return qn.documents;
  }
}