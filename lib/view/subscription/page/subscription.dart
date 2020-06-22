import 'dart:io';
import 'package:attt/interface/subscriptionInterface.dart';
import 'package:attt/utils/colors.dart';
import 'package:attt/utils/emptyContainer.dart';
import 'package:attt/utils/size_config.dart';
import 'package:attt/view/chooseAthlete/pages/chooseAthlete.dart';
import 'package:attt/view/subscription/declinedScreen.dart';
import 'package:attt/view/subscription/page/page1.dart';
import 'package:attt/view/subscription/page/page3.dart';
import 'package:attt/view/subscription/page/widgets/page2.dart';
import 'package:attt/view/subscription/page/widgets/price.dart';
import 'package:attt/view/trainingPlan/pages/trainingPlan.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';



class SubscriptionClass extends StatefulWidget {

  final Card buildProductList;
  final Function listenToUpdates;
  final PageController pageController;

  SubscriptionClass({
    this.pageController,
    this.buildProductList,
    this.listenToUpdates
});

  @override
  _SubscriptionClassState createState() => _SubscriptionClassState();
}

class _SubscriptionClassState extends State<SubscriptionClass> {

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return  Scaffold(
            backgroundColor: Colors.transparent,
            body: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                decoration: BoxDecoration(color: MyColors().lightBlack),
                child: PageView(
                  controller: widget.pageController,
                  scrollDirection: Axis.vertical,
                  children: [
                    pageOne(widget.pageController),
                    pageTwo(),
                    pageThree(widget.buildProductList),
                  ],
                ),
              ),
            ),
          );
  }
}
