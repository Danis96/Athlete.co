import 'package:attt/utils/emptyContainer.dart';
import 'package:attt/utils/size_config.dart';
import 'package:attt/view/home/widgets/buttonList.dart';
import 'package:attt/view/home/widgets/logo.dart';
import 'package:attt/view_model/signInViewModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Signin extends StatefulWidget {
  const Signin({Key key}) : super(key: key);

  @override
  _SigninState createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  String name = '';

  Future getTrainers() async {
    var firestore = Firestore.instance;
    QuerySnapshot qn = await firestore.collection('Trainers').getDocuments();
    return qn.documents;
  }

  Future getWeeks(String trainerID) async {
    var firestore = Firestore.instance;
    QuerySnapshot qn = await firestore
        .collection('Trainers')

        /// treba i trainerID
        .document(trainerID)
        .collection('weeks')
        .orderBy('name')
        .getDocuments();
    return qn.documents;
  }

  Future getWorkouts(String trainerID, String weekID) async {
    var firestore = Firestore.instance;
    QuerySnapshot qn = await firestore
        .collection('Trainers')

        /// treba mi trainerID
        .document(trainerID)
        .collection('weeks')

        /// treba mi weekID
        .document(weekID)
        .collection('workouts')
        .orderBy('order')
        .getDocuments();
    return qn.documents;
  }

  Future getSeries(String trainerID, String weekID, String workoutID) async {
    var firestore = Firestore.instance;
    QuerySnapshot qn = await firestore
        .collection('Trainers')

        /// treba mi trainerID
        .document(trainerID)
        .collection('weeks')

        /// treba mi weekID
        .document(weekID)
        .collection('workouts')

        /// treba mi workoutID
        .document(workoutID)
        .collection('series')
        .orderBy('order')
        .getDocuments();
    return qn.documents;
  }

  Future getExercises(String trainerID, String weekID, String workoutID,
      String seriesID) async {
    var firestore = Firestore.instance;
    QuerySnapshot qn = await firestore
        .collection('Trainers')

        /// treba mi trainerIDtra
        .document(trainerID)
        .collection('weeks')

        /// treba mi weekID
        .document(weekID)
        .collection('workouts')

        /// treba mi workoutID
        .document(workoutID)
        .collection('series')

        /// treba mi seriesID
        .document(seriesID)
        .collection('exercises')
        .orderBy('order')
        .getDocuments();
    return qn.documents;
  }

  @override
  void initState() {
    super.initState();
    // SignInViewModel().autoLogIn(context);
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Color.fromRGBO(28, 28, 28, 1.0),
      body: Center(
        child: Container(
          child: Column(
            children: <Widget>[
              Container(
                /// TRAINERS
                child: FutureBuilder(
                    future: getTrainers(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                            shrinkWrap: true,
                            itemCount: snapshot.data.length,
                            itemBuilder: (BuildContext context, int index) {
                              String trainerID =
                                  snapshot.data[index].data['trainerID'];
                              String trainerName =
                                  snapshot.data[index].data['trainer_name'];
                              print('Trainer ' + trainerName);
                              //  WEEKS
                              return FutureBuilder(
                                  future: getWeeks(trainerID),
                                  builder: (BuildContext context,
                                      AsyncSnapshot snapshot) {
                                    if (snapshot.hasData) {
                                      return ListView.builder(
                                          shrinkWrap: true,
                                          itemCount: snapshot.data.length,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            String weekID = snapshot
                                                .data[index].data['weekID'];
                                            String weekName = snapshot
                                                .data[index].data['name'];
                                            print('Weeks ' + weekName);

                                            /// WORKOUTS
                                            return FutureBuilder(
                                                future: getWorkouts(
                                                    trainerID, weekID),
                                                builder: (BuildContext context,
                                                    AsyncSnapshot snapshot) {
                                                  if (snapshot.hasData) {
                                                    return ListView.builder(
                                                        shrinkWrap: true,
                                                        itemCount: snapshot
                                                            .data.length,
                                                        itemBuilder:
                                                            (BuildContext
                                                                    context,
                                                                int index) {
                                                          String workoutID =
                                                              snapshot
                                                                      .data[index]
                                                                      .data[
                                                                  'workoutID'];
                                                          String workoutName =
                                                              snapshot
                                                                  .data[index]
                                                                  .data['name'];
                                                          print('Workouts ' +
                                                              workoutName);

                                                          /// SERIES
                                                          return FutureBuilder(
                                                              future: getSeries(
                                                                  trainerID,
                                                                  weekID,
                                                                  workoutID),
                                                              builder: (BuildContext
                                                                      context,
                                                                  AsyncSnapshot
                                                                      snapshot) {
                                                                if (snapshot
                                                                    .hasData) {
                                                                  return ListView
                                                                      .builder(
                                                                          shrinkWrap:
                                                                              true,
                                                                          itemCount: snapshot
                                                                              .data
                                                                              .length,
                                                                          itemBuilder:
                                                                              (BuildContext context, int index) {
                                                                            String
                                                                                seriesID =
                                                                                snapshot.data[index].data['seriesID'];
                                                                            String
                                                                                seriesName =
                                                                                snapshot.data[index].data['name'];
                                                                            print('Series ' +
                                                                                seriesName);

                                                                            /// EXERCISES

                                                                            return FutureBuilder(
                                                                                future: getExercises(trainerID, weekID, workoutID, seriesID),
                                                                                builder: (BuildContext context, AsyncSnapshot snapshot) {
                                                                                  if (snapshot.hasData) {
                                                                                    return ListView.builder(
                                                                                        shrinkWrap: true,
                                                                                        itemCount: snapshot.data.length,
                                                                                        itemBuilder: (BuildContext context, int index) {
                                                                                          String exerciseID = snapshot.data[index].data['exerciseID'];
                                                                                          String exerciseName = snapshot.data[index].data['name'];
                                                                                          String exercisevideo = snapshot.data[index].data['video'];
                                                                                          print('Exercises ' + exerciseName);
                                                                                          print('Exercise video link : ' + exercisevideo);
                                                                                          print('FILE NAME: ' + trainerName + weekName + workoutName + seriesName + exerciseName + '.mp4');

                                                                                          /// EXERCISES
                                                                                          return EmptyContainer();
                                                                                        });
                                                                                  }
                                                                                  return EmptyContainer();
                                                                                });
                                                                          });
                                                                }
                                                                return EmptyContainer();
                                                              });
                                                        });
                                                  }
                                                  return EmptyContainer();
                                                });
                                          });
                                    }
                                    return EmptyContainer();
                                  });
                            });
                      }
                      return EmptyContainer();
                    }),
              ),
              SizedBox(
                height: SizeConfig.blockSizeVertical * 19,
              ),
              logo(context),
              SizedBox(
                height: SizeConfig.blockSizeVertical * 40,
              ),
              buttonList(context)
            ],
          ),
        ),
      ),
    );
  }
}
