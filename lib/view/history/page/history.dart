import 'dart:async';

import 'package:attt/utils/colors.dart';
import 'package:attt/utils/customScreenAnimation.dart';
import 'package:attt/utils/emptyContainer.dart';
import 'package:attt/utils/globals.dart';
import 'package:attt/utils/size_config.dart';
import 'package:attt/view/chooseAthlete/pages/chooseAthlete.dart';
import 'package:attt/view/history/widgets/historyCustomBottomNavigationBar.dart';
import 'package:attt/view/settings/pages/settingsPage.dart';
import 'package:attt/view_model/workoutViewModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class History extends StatefulWidget {
  final DocumentSnapshot userDocument;
  final DocumentSnapshot userTrainerDocument;
  final String userUID;
  const History(
      {Key key, this.userTrainerDocument, this.userDocument, this.userUID})
      : super(key: key);

  @override
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    List<dynamic> finishedWorkouts =
        widget.userDocument.data['workouts_finished'];
    List<dynamic> finishedWeeksWithAthlete = [];
    for (var i = finishedWorkouts.length - 1; i >= 0; i--) {
      if (!finishedWeeksWithAthlete.contains(
          finishedWorkouts[i].toString().split('_')[0] +
              '_' +
              finishedWorkouts[i].toString().split('_')[1])) {
        finishedWeeksWithAthlete.add(
            finishedWorkouts[i].toString().split('_')[0] +
                '_' +
                finishedWorkouts[i].toString().split('_')[1]);
      }
    }

    Future<List<DocumentSnapshot>> getTainerName(String trainerID) async {
      var firestore = Firestore.instance;
      QuerySnapshot qn = await firestore
          .collection('Trainers')
          .where('trainerID', isEqualTo: trainerID)
          .getDocuments();
      return qn.documents;
    }

    Future getWeekName(String trainerID, String weekID) async {
      var firestore = Firestore.instance;
      QuerySnapshot qn = await firestore
          .collection('Trainers')

          /// treba i trainerID
          .document(trainerID)
          .collection('weeks')
          .where('weekID', isEqualTo: weekID)
          .getDocuments();
      return qn.documents;
    }

    Future getWorkoutName(
        String trainerID, String weekID, String workoutID) async {
      var firestore = Firestore.instance;
      QuerySnapshot qn = await firestore
          .collection('Trainers')

          /// treba mi trainerID
          .document(trainerID)
          .collection('weeks')

          /// treba mi weekID
          .document(weekID)
          .collection('workouts')
          .where('workoutID', isEqualTo: workoutID)
          .getDocuments();
      return qn.documents;
    }

    return Scaffold(
      backgroundColor: MyColors().lightBlack,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
            top: SizeConfig.blockSizeVertical * 5,
            left: SizeConfig.blockSizeHorizontal * 4.5,
            right: SizeConfig.blockSizeHorizontal * 4.5,
          ),
          child: ListView.builder(
            shrinkWrap: true,
            physics: ScrollPhysics(),
            itemCount: finishedWeeksWithAthlete.length,
            itemBuilder: (BuildContext context, int index) {
              String trainerName = '';
              String weekName = '';
              List<dynamic> workoutsList = [];
              for (var i = 0; i < finishedWorkouts.length; i++) {
                if (finishedWorkouts[i].toString().split('_')[1] ==
                    finishedWeeksWithAthlete[index].toString().split('_')[1]) {
                  workoutsList.add(
                      finishedWorkouts[i].toString().split('_')[2] +
                          ' ' +
                          finishedWorkouts[i].toString().split('_')[3]);
                }
              }
              return FutureBuilder(
                future: getTainerName(
                    finishedWeeksWithAthlete[index].toString().split('_')[0]),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot != null) {
                      trainerName = snapshot.data[0].data['trainer_name'];
                    }
                    return FutureBuilder(
                      future: getWeekName(
                          finishedWeeksWithAthlete[index]
                              .toString()
                              .split('_')[0],
                          finishedWeeksWithAthlete[index]
                              .toString()
                              .split('_')[1]),
                      builder: (BuildContext context, AsyncSnapshot snapshot2) {
                        if (snapshot2.hasData) {
                          if (snapshot2 != null) {
                            weekName = snapshot2.data[0].data['name'];
                          }
                          return Container(
                            margin: EdgeInsets.only(
                                bottom: SizeConfig.blockSizeVertical * 3),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          weekName.toUpperCase(),
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: 'Roboto',
                                            fontStyle: FontStyle.italic,
                                            fontSize:
                                                SizeConfig.blockSizeVertical *
                                                    3,
                                            fontWeight: FontWeight.w500,
                                          ),
                                          textAlign: TextAlign.start,
                                        ),
                                        SizedBox(
                                          height:
                                              SizeConfig.blockSizeVertical * 1,
                                        ),
                                        Text(
                                          trainerName.toUpperCase(),
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: 'Roboto',
                                            fontSize:
                                                SizeConfig.blockSizeVertical *
                                                    2.5,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: SizeConfig.blockSizeVertical * 2,
                                ),
                                Container(
                                  child: ListView.builder(
                                    physics: NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: workoutsList.length,
                                    itemBuilder:
                                        (BuildContext context, int index2) {
                                      String workoutName = '';
                                      String workoutTag = '';
                                      List<dynamic> workoutNotes = [];
                                      return FutureBuilder(
                                        future: getWorkoutName(
                                            finishedWeeksWithAthlete[index]
                                                .toString()
                                                .split('_')[0],
                                            finishedWeeksWithAthlete[index]
                                                .toString()
                                                .split('_')[1],
                                            workoutsList[index2]
                                                .toString()
                                                .split(' ')[0]),
                                        builder: (BuildContext context,
                                            AsyncSnapshot snapshot3) {
                                          if (snapshot3.hasData) {
                                            userNotesHistory = '';
                                            if (snapshot3 != null) {
                                              workoutName = snapshot3
                                                  .data[0].data['name'];
                                              workoutTag =
                                                  snapshot3.data[0].data['tag'];
                                              workoutNotes =
                                                  snapshot3.data[0].data['notes'];
                                              print('AAAAAAAAAAAAAAAAAA   ' + workoutNotes.toString());
                                            }
                                            userNotesHistory = WorkoutViewModel().getUserNotes(
                                                workoutNotes,
                                                widget.userDocument
                                                    .data['userUID']);
                                            return Container(
                                              margin: EdgeInsets.only(
                                                  bottom: SizeConfig
                                                          .blockSizeVertical *
                                                      1.25),
                                              width: double.infinity,
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
                                                      CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    Text(
                                                      workoutName
                                                              .toUpperCase() +
                                                          ' : ' +
                                                          workoutsList[index2]
                                                              .toString()
                                                              .split(' ')[1] +
                                                          ' ' +
                                                          workoutsList[index2]
                                                              .toString()
                                                              .split(' ')[2],
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontFamily: 'Roboto',
                                                          fontSize: SizeConfig
                                                                  .blockSizeVertical *
                                                              2.5,
                                                          fontStyle:
                                                              FontStyle.italic,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                    SizedBox(
                                                      height: SizeConfig
                                                              .blockSizeVertical *
                                                          0.4,
                                                    ),
                                                    Text(
                                                      workoutTag.toUpperCase(),
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontFamily: 'Roboto',
                                                          fontSize: SizeConfig
                                                                  .blockSizeVertical *
                                                              2.1,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                    userNotesHistory != ''
                                                        ? Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: <Widget>[
                                                              SizedBox(
                                                                height: SizeConfig
                                                                        .blockSizeVertical *
                                                                    2,
                                                              ),
                                                              Divider(
                                                                color: MyColors()
                                                                    .lightBlack,
                                                                height: 1,
                                                                thickness: 1,
                                                              ),
                                                              SizedBox(
                                                                height: SizeConfig
                                                                        .blockSizeVertical *
                                                                    2,
                                                              ),
                                                              Container(
                                                                child: Text(
                                                                  userNotesHistory,
                                                                  style:
                                                                      TextStyle(
                                                                    color: Colors
                                                                        .white60,
                                                                    fontFamily:
                                                                        'Roboto',
                                                                    fontSize:
                                                                        SizeConfig.blockSizeVertical *
                                                                            2,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          )
                                                        : EmptyContainer(),
                                                  ],
                                                ),
                                              ),
                                            );
                                          } else {
                                            return Container(
                                              margin: EdgeInsets.only(
                                                  bottom: SizeConfig
                                                          .blockSizeVertical *
                                                      1.25),
                                              width: double.infinity,
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
                                                      CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    Text(
                                                      '',
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontFamily: 'Roboto',
                                                          fontSize: SizeConfig
                                                                  .blockSizeVertical *
                                                              2.5,
                                                          fontStyle:
                                                              FontStyle.italic,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                    SizedBox(
                                                      height: SizeConfig
                                                              .blockSizeVertical *
                                                          0.4,
                                                    ),
                                                    Text(
                                                      '',
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontFamily: 'Roboto',
                                                          fontSize: SizeConfig
                                                                  .blockSizeVertical *
                                                              2.1,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                    userNotesHistory != ''
                                                        ? Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: <Widget>[
                                                              SizedBox(
                                                                height: SizeConfig
                                                                        .blockSizeVertical *
                                                                    2,
                                                              ),
                                                              Divider(
                                                                color: MyColors()
                                                                    .lightBlack,
                                                                height: 1,
                                                                thickness: 1,
                                                              ),
                                                              SizedBox(
                                                                height: SizeConfig
                                                                        .blockSizeVertical *
                                                                    2,
                                                              ),
                                                              Container(
                                                                child: Text(
                                                                  '',
                                                                  style:
                                                                      TextStyle(
                                                                    color: Colors
                                                                        .white60,
                                                                    fontFamily:
                                                                        'Roboto',
                                                                    fontSize:
                                                                        SizeConfig.blockSizeVertical *
                                                                            2,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          )
                                                        : EmptyContainer(),
                                                  ],
                                                ),
                                              ),
                                            );
                                          }
                                        },
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          );
                        } else {
                          return EmptyContainer();
                        }
                      },
                    );
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              );
            },
          ),
        ),
      ),
      // Container(
      //   child: Center(
      //     child: Container(
      //       width: SizeConfig.blockSizeHorizontal * 70,
      //       height: SizeConfig.blockSizeVertical * 5,
      //       child: RaisedButton(
      //         color: MyColors().black,
      //         onPressed: () {
      //           Navigator.of(context).pushAndRemoveUntil(
      //               MaterialPageRoute(
      //                 builder: (_) => ChooseAthlete(
      //                   userDocument: userDocument,
      //                   name: userDocument['display_name'],
      //                   email: userDocument['email'],
      //                   photo: userDocument['image'],
      //                   userUID: userUID,
      //                 ),
      //               ),
      //               (Route<dynamic> route) => false);
      //         },
      //         child: Text(
      //           'Change your athlete',
      //           style: TextStyle(
      //             color: MyColors().white,
      //             fontSize: SizeConfig.safeBlockHorizontal * 4
      //           ),
      //         ),
      //       ),
      //     ),
      //   ),
      // ),
      bottomNavigationBar: historyCustomBottomNavigationBar(
          context, widget.userDocument, widget.userTrainerDocument),
    );
  }
}
