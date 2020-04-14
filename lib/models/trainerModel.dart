import 'package:cloud_firestore/cloud_firestore.dart';

class Trainer {
  final String trainerName;
  final String trainingPlanName;
  final String trainingPlanDuration;

  Trainer({this.trainerName, this.trainingPlanDuration, this.trainingPlanName});


  factory Trainer.fromDocument(DocumentSnapshot doc) {
    return Trainer(
      trainerName: doc['trainer_name'],
      trainingPlanName: doc['training_plan_name'],
      trainingPlanDuration: doc['training_plan_duration'],
    );
  }
}
