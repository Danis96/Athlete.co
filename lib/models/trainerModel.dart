import 'package:cloud_firestore/cloud_firestore.dart';

class Trainer {
  final String trainerName, trainingPlanName, trainingPlanDuration, trainerID, description, performanceCoach, trainerImage;

  Trainer(
      {this.trainerName,
      this.trainingPlanDuration,
      this.trainingPlanName,
      this.trainerID,
      this.description, 
      this.performanceCoach, 
      this.trainerImage,
      });

  factory Trainer.fromDocument(DocumentSnapshot doc) {
    return Trainer(
      trainerID: doc['trainerID'],
      trainerName: doc['trainer_name'],
      trainingPlanName: doc['training_plan_name'],
      trainingPlanDuration: doc['training_plan_duration'],
      description: doc['description'],
      performanceCoach: doc['performance_coach'],
      trainerImage: doc['trainer_image']
    );
  }
}
