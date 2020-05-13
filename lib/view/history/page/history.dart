import 'package:attt/utils/colors.dart';
import 'package:attt/utils/customScreenAnimation.dart';
import 'package:attt/utils/size_config.dart';
import 'package:attt/view/chooseAthlete/pages/chooseAthlete.dart';
import 'package:attt/view/history/widgets/historyCustomBottomNavigationBar.dart';
import 'package:attt/view/settings/pages/settingsPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class History extends StatelessWidget {
  final DocumentSnapshot userDocument;
  final DocumentSnapshot userTrainerDocument;
  final String userUID;
  const History(
      {Key key, this.userTrainerDocument, this.userDocument, this.userUID})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: MyColors().lightBlack,
      body: Padding(
        padding: EdgeInsets.only(
          top: SizeConfig.blockSizeVertical * 8,
          left: SizeConfig.blockSizeHorizontal * 4.5,
          right: SizeConfig.blockSizeHorizontal * 4.5,
        ),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'WEEK 1',
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Roboto',
                                fontStyle: FontStyle.italic,
                                fontSize: SizeConfig.blockSizeVertical * 3,
                                fontWeight: FontWeight.w500,
                              ),
                              textAlign: TextAlign.start,
                            ),
                            SizedBox(
                              height: SizeConfig.blockSizeVertical * 1,
                            ),
                            Text(
                              'ALEKSANDAR RAKIĆ',
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Roboto',
                                fontSize: SizeConfig.blockSizeVertical * 2.5,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          child: IconButton(
                            onPressed: () => Navigator.of(context).push(
                              CardAnimationTween(
                                widget: SettingsPage(),
                              ),
                            ),
                            icon: Icon(
                              Icons.settings,
                              color: MyColors().white,
                              size: SizeConfig.blockSizeHorizontal * 7,
                            ),
                          ),
                        )
                      ],
                    ),
                    Container(
                      child: ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: 3,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            margin: EdgeInsets.only(
                                bottom: SizeConfig.blockSizeVertical * 1.25),
                            width: double.infinity,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(4),
                                ),
                                color: Colors.black),
                            child: Padding(
                              padding: EdgeInsets.only(
                                top: SizeConfig.blockSizeVertical * 3,
                                bottom: SizeConfig.blockSizeVertical * 3,
                                left: SizeConfig.blockSizeHorizontal * 5.2,
                                right: SizeConfig.blockSizeHorizontal * 5.2,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    'WORKOUT ' +
                                        (index + 1).toString() +
                                        ' : 20 DEC',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'Roboto',
                                        fontSize:
                                            SizeConfig.blockSizeVertical * 2.5,
                                        fontStyle: FontStyle.italic,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  SizedBox(
                                    height: SizeConfig.blockSizeVertical * 0.4,
                                  ),
                                  Text(
                                    'UPPER BODY',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'Roboto',
                                        fontSize:
                                            SizeConfig.blockSizeVertical * 2.1,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  SizedBox(
                                    height: SizeConfig.blockSizeVertical * 2,
                                  ),
                                  Divider(
                                    color: MyColors().lightBlack,
                                    height: 1,
                                    thickness: 1,
                                  ),
                                  SizedBox(
                                    height: SizeConfig.blockSizeVertical * 2,
                                  ),
                                  Container(
                                    child: Text(
                                      'My workout note. The workout was great!!!',
                                      style: TextStyle(
                                        color: Colors.white60,
                                        fontFamily: 'Roboto',
                                        fontSize:
                                            SizeConfig.blockSizeVertical * 2,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
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
          context, userDocument, userTrainerDocument),
    );
  }
}
