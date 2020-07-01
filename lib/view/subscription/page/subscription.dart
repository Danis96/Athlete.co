import 'package:attt/utils/colors.dart';
import 'package:attt/utils/size_config.dart';
import 'package:attt/view/subscription/page/page1.dart';
import 'package:attt/view/subscription/page/page3.dart';
import 'package:attt/view/subscription/page/page2.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SubscriptionClass extends StatefulWidget {
  final Card buildProductList;
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
  });

  @override
  _SubscriptionClassState createState() => _SubscriptionClassState();
}

class _SubscriptionClassState extends State<SubscriptionClass> {
  @override
  Widget build(BuildContext context) {

    SizeConfig().init(context);

    return Scaffold(
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
                  widget.userExist),
              pageTwo(context),
              pageThree(widget.buildProductList),
            ],
          ),
        ),
      ),
    );
  }
}
