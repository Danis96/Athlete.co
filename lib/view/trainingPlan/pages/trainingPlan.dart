import 'package:attt/utils/size_config.dart';
import 'package:attt/view_model/chooseAthleteViewModel.dart';
import 'package:attt/view/workout/pages/workout.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TrainingPlan extends StatelessWidget {
  final DocumentSnapshot userDocument;
  final DocumentSnapshot userTrainerDocument;
  final String trainerName;
  final String trainingPlanName;
  final String trainingPlanDuration;
  final String name, photo, email;
  TrainingPlan(
      {this.trainerName,
      this.userTrainerDocument,
      this.userDocument,
      this.trainingPlanDuration,
      this.trainingPlanName,
      this.photo,
      this.name,
      this.email});

  @override
  Widget build(BuildContext context) {
    Future getWeeks(String trainerName) async {
      var firestore = Firestore.instance;
      QuerySnapshot qn = await firestore
          .collection('Trainers')
          .document(trainerName)
          .collection('weeks')
          .getDocuments();
      return qn.documents;
    }

    Future getWorkouts(String trainerName, String weekName) async {
      var firestore = Firestore.instance;
      QuerySnapshot qn = await firestore
          .collection('Trainers')

          /// treba mi
          .document(trainerName)
          .collection('weeks')

          /// treba mi
          .document(weekName)
          .collection('workouts')
          .getDocuments();
      return qn.documents;
    }

    String trainerName = userTrainerDocument.data['trainer_name'];

    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Color.fromRGBO(28, 28, 28, 1.0),
      body: Padding(
        padding: EdgeInsets.only(
            top: SizeConfig.blockSizeVertical * 8,
            left: SizeConfig.blockSizeHorizontal * 4.5,
            right: SizeConfig.blockSizeHorizontal * 4.5),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    height: 75.0,
                    width: 75,
                    padding: EdgeInsets.all(10),
                    child: CircleAvatar(
                      radius: 28.0,
                      backgroundImage:
                          NetworkImage(photo),
                    ),
                  ),
                  SizedBox(
                    width: SizeConfig.blockSizeHorizontal * 4.5,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Week 2 of 18',
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Roboto',
                            fontSize: SizeConfig.blockSizeVertical * 3.2,
                            fontWeight: FontWeight.w500),
                        textAlign: TextAlign.left,
                      ),
                      SizedBox(
                        height: SizeConfig.blockSizeVertical * 0.3,
                      ),
                      Text(
                        'Your training plan',
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Roboto',
                            fontSize: SizeConfig.blockSizeVertical * 2.5,
                            fontWeight: FontWeight.w400),
                        textAlign: TextAlign.left,
                      ),
                    ],
                  )
                ],
              ),
              SizedBox(
                height: SizeConfig.blockSizeVertical * 2.5,
              ),
              Container(
                width: double.infinity,
                child: Text(
                  "Welcome to week 2\n\nFocus on technique, use the video and coaching tips to help you.",
                  style: TextStyle(
                      color: Color.fromRGBO(255, 255, 255, 0.8),
                      fontFamily: 'Roboto',
                      fontSize: SizeConfig.blockSizeVertical * 2.2,
                      fontWeight: FontWeight.w400),
                ),
              ),
              SizedBox(
                height: SizeConfig.blockSizeVertical * 2.5,
              ),
              Container(
                height: SizeConfig.blockSizeVertical * 4.7,
                width: SizeConfig.blockSizeHorizontal * 49,
                padding: EdgeInsets.all(7.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                    color: Color.fromRGBO(37, 211, 102, 1.0)),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      FontAwesomeIcons.whatsapp,
                      color: Colors.white,
                      size: SizeConfig.blockSizeVertical * 2.8,
                    ),
                    SizedBox(
                      width: SizeConfig.blockSizeHorizontal * 3,
                    ),
                    Text(
                      "ANY QUESTION",
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Roboto',
                          fontSize: SizeConfig.blockSizeVertical * 2.2,
                          fontWeight: FontWeight.w500),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              FutureBuilder(
                  future: getWeeks(userTrainerDocument.data['trainer_name']),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: snapshot.data.length,
                          itemBuilder: (BuildContext context, int index) {
                            if (index == 0) {
                              return FutureBuilder(
                                future: getWorkouts(
                                    userTrainerDocument.data['trainer_name'],
                                    snapshot.data[index]['name']),
                                builder: (BuildContext context,
                                    AsyncSnapshot snapshot2) {
                                  if (snapshot2.hasData) {
                                    return Column(
                                      children: <Widget>[
                                        ListView.builder(
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          itemCount: snapshot2.data.length,
                                          itemBuilder: (BuildContext context,
                                              int index2) {
                                            return GestureDetector(
                                              onTap: () {
                                                print(trainerName +
                                                    ' ' +
                                                    snapshot2.data[index2]
                                                        ['name']);
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (BuildContext
                                                                context) =>
                                                            Workout(
                                                              trainerName:
                                                                  trainerName,
                                                              workoutName:
                                                                  snapshot2.data[
                                                                          index2]
                                                                      ['name'],
                                                            )));
                                              },
                                              child: Container(
                                                margin: EdgeInsets.only(
                                                    bottom: SizeConfig
                                                            .blockSizeVertical *
                                                        1.25),
                                                width: double.infinity,
                                                height: SizeConfig
                                                        .blockSizeVertical *
                                                    12.5,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                      Radius.circular(4),
                                                    ),
                                                    color: Colors.black),
                                                child: Padding(
                                                  padding: EdgeInsets.only(
                                                    top: SizeConfig
                                                            .blockSizeVertical *
                                                        3,
                                                    bottom: SizeConfig
                                                            .blockSizeVertical *
                                                        3,
                                                    left: SizeConfig
                                                            .blockSizeHorizontal *
                                                        5.2,
                                                    right: SizeConfig
                                                            .blockSizeHorizontal *
                                                        5.2,
                                                  ),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: <Widget>[
                                                      Text(
                                                        snapshot2.data[index2]
                                                                ['name']
                                                            .toString()
                                                            .toUpperCase(),
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontFamily:
                                                                'Roboto',
                                                            fontSize: SizeConfig
                                                                    .blockSizeVertical *
                                                                2.5,
                                                            fontStyle: FontStyle
                                                                .italic,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      ),
                                                      SizedBox(
                                                        height: SizeConfig
                                                                .blockSizeVertical *
                                                            0.4,
                                                      ),
                                                      Text(
                                                        snapshot2.data[index2]
                                                                ['tag']
                                                            .toString()
                                                            .toUpperCase(),
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontFamily:
                                                                'Roboto',
                                                            fontSize: SizeConfig
                                                                    .blockSizeVertical *
                                                                2.1,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                        SizedBox(
                                          height: SizeConfig.blockSizeVertical *
                                              1.25,
                                        ),
                                        Divider(
                                          height: SizeConfig.blockSizeVertical *
                                              0.16,
                                          thickness:
                                              SizeConfig.blockSizeVertical *
                                                  0.16,
                                          color: Color.fromRGBO(
                                              255, 255, 255, 0.2),
                                        ),
                                        SizedBox(
                                          height:
                                              SizeConfig.blockSizeVertical * 3,
                                        ),
                                      ],
                                    );
                                  } else {
                                    return SizedBox(
                                      height: 0,
                                      width: 0,
                                    );
                                  }
                                },
                              );
                            } else {
                              return Container(
                                margin: EdgeInsets.only(
                                    bottom:
                                        SizeConfig.blockSizeVertical * 1.25),
                                width: double.infinity,
                                height: SizeConfig.blockSizeVertical * 8.75,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(4),
                                  ),
                                  border: Border.all(
                                    width: 1,
                                    color: Color.fromRGBO(255, 255, 255, 0.2),
                                  ),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.only(
                                    top: SizeConfig.blockSizeVertical * 3,
                                    bottom: SizeConfig.blockSizeVertical * 3,
                                    left: SizeConfig.blockSizeHorizontal * 5.2,
                                    right: SizeConfig.blockSizeHorizontal * 5.2,
                                  ),
                                  child: Text(
                                    snapshot.data[index]['name']
                                        .toString()
                                        .toUpperCase(),
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'Roboto',
                                        fontSize:
                                            SizeConfig.blockSizeVertical * 2.5,
                                        fontStyle: FontStyle.italic,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              );
                            }
                          });
                    } else {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
