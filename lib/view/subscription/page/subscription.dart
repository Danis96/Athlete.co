import 'dart:io';

import 'package:attt/utils/colors.dart';
import 'package:attt/utils/emptyContainer.dart';
import 'package:attt/utils/size_config.dart';
import 'package:attt/view/subscription/page/page1-2.dart';
import 'package:attt/view/subscription/page/page1.dart';
import 'package:attt/view/subscription/page/page3.dart';
import 'package:attt/view/subscription/page/page2.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'widgets/resultCont.dart';
import 'widgets/textReviews.dart';

class SubscriptionClass extends StatefulWidget {
  final Card buildProductList;
  final List<Widget> Function() iosBuildProducts;
  final Function listenToUpdates;
  final PageController pageController;
  final DocumentSnapshot currentUserDocument;
  final DocumentSnapshot currentUserTrainerDocument;
  final String userName, userPhoto, userUID, userEmail;
  final bool userExist;

  SubscriptionClass({
    this.pageController,
    this.buildProductList,
    this.listenToUpdates,
    this.currentUserDocument,
    this.currentUserTrainerDocument,
    this.userName,
    this.userPhoto,
    this.userUID,
    this.userEmail,
    this.userExist,
    this.iosBuildProducts,
  });

  @override
  _SubscriptionClassState createState() => _SubscriptionClassState();
}

class _SubscriptionClassState extends State<SubscriptionClass> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return WillPopScope(
      onWillPop: () => _onWillPop(),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            decoration: BoxDecoration(color: MyColors().lightBlack),
            child: PageView(
              controller: widget.pageController,
              scrollDirection: Axis.vertical,
              children: [
                pageOne(
                  widget.pageController,
                  context,
                  widget.currentUserDocument,
                  widget.currentUserTrainerDocument,
                  widget.userName,
                  widget.userPhoto,
                  widget.userUID,
                  widget.userEmail,
                  widget.userExist,
                  checkIsIosTablet,
                ),
                pageOneToTwo(context, widget.pageController, checkIsIosTablet),
                pageTwo(context, widget.pageController, checkIsIosTablet),
                pageThree(widget.buildProductList, context ,checkIsIosTablet),
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool checkIsIosTablet(BuildContext context) {
    if (MediaQuery.of(context).size.width > 1000) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> _onWillPop() {
    return showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  backgroundColor: MyColors().lightBlack,
                  title: Text(
                    'Are you sure?',
                    style: TextStyle(color: MyColors().lightWhite),
                  ),
                  content: new Text(
                    'If you press yes, you will exit Athlete.co',
                    style: TextStyle(color: MyColors().lightWhite),
                  ),
                  actions: <Widget>[
                    new FlatButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: new Text(
                        'No',
                        style: TextStyle(color: MyColors().lightWhite),
                      ),
                    ),
                    new FlatButton(
                      onPressed: () => exit(0),
                      child: new Text(
                        'Yes',
                        style: TextStyle(color: MyColors().error),
                      ),
                    ),
                  ],
                )) ??
        true;
  }
}
