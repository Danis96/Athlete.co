import 'dart:convert';

import 'package:attt/view/subscription/recieptModels/recieptModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter_inapp_purchase/flutter_inapp_purchase.dart';
import 'package:attt/utils/size_config.dart';
import 'package:flutter_inapp_purchase/modules.dart';

import '../../../utils/colors.dart';
import '../../../utils/emptyContainer.dart';
import '../../../utils/size_config.dart';
import '../../chooseAthlete/pages/chooseAthlete.dart';
import '../../trainingPlan/pages/trainingPlan.dart';
import '../declinedScreen.dart';
import 'page1.dart';
import 'widgets/resultCont.dart';
import 'package:attt/view/subscription/page/page1-2.dart';
import 'package:attt/view/subscription/page/page1.dart';
import 'package:attt/view/subscription/page/page2.dart';

import 'widgets/textReviews.dart';

class CheckSubscription extends StatefulWidget {
  final bool userExist;
  final String userName, userEmail, userPhoto, userUID;
  final DocumentSnapshot currentUserDocument, currentUserTrainerDocument;

  CheckSubscription({
    this.userExist,
    this.userUID,
    this.userPhoto,
    this.userEmail,
    this.userName,
    this.currentUserTrainerDocument,
    this.currentUserDocument,
  });

  @override
  _CheckSubscriptionState createState() => new _CheckSubscriptionState();
}

class _CheckSubscriptionState extends State<CheckSubscription> {
  PageController _pageController;
  StreamSubscription _purchaseUpdatedSubscription;
  StreamSubscription _purchaseErrorSubscription;
  StreamSubscription _conectionSubscription;
  final List<String> _productLists = [
    'com.tech.ios.Athlete.Monthly.subscription',
    'com.tech.ios.Athlete.Annual.subscription',
  ];

  String _platformVersion = 'Unknown';
  List<IAPItem> _items = [];
  List<PurchasedItem> _purchases = [];
  var secretToken = '97c854b72ef64868bd6efe8fab6a1ef0';

  @override
  void initState() {
    super.initState();
    initPlatformState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    if (_conectionSubscription != null) {
      _conectionSubscription.cancel();
      _conectionSubscription = null;
    }
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    FlutterInappPurchase.instance.clearTransactionIOS();
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      platformVersion = await FlutterInappPurchase.instance.platformVersion;
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // prepare
    var result = await FlutterInappPurchase.instance.initConnection;
    print('result: $result');

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });

    // refresh items for android
    try {
      String msg = await FlutterInappPurchase.instance.consumeAllItems;
      print('consumeAllItems: $msg');
    } catch (err) {
      print('consumeAllItems error: $err');
    }

    _conectionSubscription =
        FlutterInappPurchase.connectionUpdated.listen((connected) {
      print('connected: $connected');
    });

    _purchaseUpdatedSubscription =
        FlutterInappPurchase.purchaseUpdated.listen((productItem) {
      print('purchase-updated: $productItem');
      print('Transaction ID: ' + productItem.transactionId.toString());
      print('Transaction Date: ' + productItem.transactionDate.toString());
      print('Original transaction identifier: ' +
          productItem.originalTransactionIdentifierIOS.toString());
      print('Transaction state: ' + productItem.transactionStateIOS.toString());

      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (_) => widget.userExist
              ? widget.currentUserDocument.data['trainer'] != null &&
                      widget.currentUserDocument.data['trainer'] != ''
                  ? TrainingPlan(
                      userTrainerDocument: widget.currentUserTrainerDocument,
                      userDocument: widget.currentUserDocument,
                    )
                  : ChooseAthlete(
                      userDocument: widget.currentUserDocument,
                      name: widget.userName,
                      email: widget.userEmail,
                      photo: widget.userPhoto,
                      userUID: widget.userUID,
                    )
              : ChooseAthlete(
                  userDocument: widget.currentUserDocument,
                  name: widget.userName,
                  email: widget.userEmail,
                  photo: widget.userPhoto,
                  userUID: widget.userUID,
                )));
    });

    _purchaseErrorSubscription =
        FlutterInappPurchase.purchaseError.listen((purchaseError) {
      print('purchase-error: $purchaseError');
      if (purchaseError.code == 'E_USER_CANCELLED') {
        showDeclinedDialog(
            context, 'Purchase cancelled', 'User has cancel the purhase');
      }
      if (purchaseError.code == 'E_UNKNOWN') {
        showDeclinedDialog(context, 'No internet',
            'There is no internet connection.Please try again later.');
      }
    });

    await FlutterInappPurchase.instance.initConnection
        .then((value) => print('BILLING CONNECTED'));
    this._getProduct();
    this._getPurchaseHistory();
  }

  void _requestPurchase(IAPItem item) {
    FlutterInappPurchase.instance.requestPurchase(item.productId);
  }

  Future _getProduct() async {
    List<IAPItem> items =
        await FlutterInappPurchase.instance.getProducts(_productLists);
    for (var item in items) {
      print('${item.toString()}');
      this._items.add(item);
    }

    setState(() {
      this._items = items;
      this._purchases = [];
    });
  }

  Future _getPurchases() async {
    List<PurchasedItem> items =
        await FlutterInappPurchase.instance.getAvailablePurchases();
    for (var item in items) {
      print('${item.toString()}');
      this._purchases.add(item);
    }

    setState(() {
      this._items = [];
      this._purchases = items;
    });
  }

  Future _getPurchaseHistory() async {
    List<PurchasedItem> items =
        await FlutterInappPurchase.instance.getPurchaseHistory();
    var receiptBody = {
      'receipt-data': items.last.transactionReceipt,
      'password': secretToken
    };
    var result = await FlutterInappPurchase.instance
        .validateReceiptIos(receiptBody: receiptBody, isTest: true);
    Map resultMap = jsonDecode(result.body);
    var reciept = RecieptModel.fromJson(resultMap);
    print(reciept.receipt.inApp.last['expires_date_ms']);
    var expirationDateMS = reciept.receipt.inApp.last['expires_date_ms'];
    var thisMoment = DateTime.now().toUtc().millisecondsSinceEpoch;
    print(thisMoment);
    print('expirationDateMS ' +
        expirationDateMS.toString() +
        '\n' +
        '          thisMoment ' +
        thisMoment.toString()); 

        int comparedResult = expirationDateMS.toString().compareTo(thisMoment.toString());
        print(comparedResult);
        if(comparedResult == 1) {
         Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (_) => widget.userExist
              ? widget.currentUserDocument.data['trainer'] != null &&
                      widget.currentUserDocument.data['trainer'] != ''
                  ? TrainingPlan(
                      userTrainerDocument: widget.currentUserTrainerDocument,
                      userDocument: widget.currentUserDocument,
                    )
                  : ChooseAthlete(
                      userDocument: widget.currentUserDocument,
                      name: widget.userName,
                      email: widget.userEmail,
                      photo: widget.userPhoto,
                      userUID: widget.userUID,
                    )
              : ChooseAthlete(
                  userDocument: widget.currentUserDocument,
                  name: widget.userName,
                  email: widget.userEmail,
                  photo: widget.userPhoto,
                  userUID: widget.userUID,
                )));
        } else print('nije');
    
  }

  List<Widget> _renderInApps() {
    List<Widget> widgets = this
        ._items
        .map((item) => GestureDetector(
              onTap: () => this._requestPurchase(item),
              child: Stack(children: [
                Container(
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(255, 198, 7, 1.0),
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                  ),
                  margin: EdgeInsets.only(
                    top: SizeConfig.blockSizeVertical * 1,
                  ),
                  height: Platform.isIOS
                      ? SizeConfig.blockSizeVertical * 13.5
                      : SizeConfig.blockSizeVertical * 15,
                  child: Padding(
                    padding: EdgeInsets.all(
                        MediaQuery.of(context).size.width < 400 ? 4.0 : 10.0),
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.only(
                              left: 10.0,
                              top: checkForTablet(context)
                                  ? 5.0
                                  : Platform.isIOS ? 1 : 10.0),
                          alignment: Alignment.centerLeft,
                          width: SizeConfig.blockSizeHorizontal * 100,
                          child: Text(
                            '7 Days Free Trial',
                            style: TextStyle(
                                color: Colors.black.withOpacity(0.6),
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.normal,
                                fontSize: checkIsIosTablet(context)
                                    ? SizeConfig.safeBlockHorizontal * 3
                                    : SizeConfig.safeBlockHorizontal * 3),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(
                              left: 10.0,
                              top: checkForTablet(context)
                                  ? 3
                                  : Platform.isIOS ? 1 : 5),
                          alignment: Alignment.centerLeft,
                          width: SizeConfig.blockSizeHorizontal * 100,
                          child: Text(
                            item.title,
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.italic,
                                fontSize: checkIsIosTablet(context)
                                    ? SizeConfig.safeBlockHorizontal * 4
                                    : Platform.isIOS
                                        ? SizeConfig.safeBlockHorizontal * 4
                                        : SizeConfig.safeBlockHorizontal * 6.5),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 10.0, top: 0),
                          alignment: Alignment.centerLeft,
                          width: SizeConfig.blockSizeHorizontal * 100,
                          child: Text(
                            'then only '.toUpperCase() + '£' + item.price,
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                                fontSize: checkIsIosTablet(context)
                                    ? SizeConfig.safeBlockHorizontal * 5
                                    : Platform.isIOS
                                        ? SizeConfig.safeBlockHorizontal * 5
                                        : SizeConfig.safeBlockHorizontal * 4),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ]),
            ))
        .toList();
    return widgets;
  }

  List<Widget> _renderPurchases() {
    List<Widget> widgets = this
        ._purchases
        .map((item) => Container(
              margin: EdgeInsets.symmetric(vertical: 10.0),
              child: Container(
                child: Column(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(bottom: 5.0),
                      child: Text(
                        item.toString(),
                        style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.black,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ))
        .toList();
    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    print(MediaQuery.of(context).size.width);
    double screenWidth = MediaQuery.of(context).size.width - 20;
    double buttonWidth = (screenWidth / 3) - 20;
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          decoration: BoxDecoration(color: MyColors().lightBlack),
          child: PageView(
            controller: _pageController,
            scrollDirection: Axis.vertical,
            children: [
              pageOne(
                _pageController,
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
              pageOneToTwo(context, _pageController, checkIsIosTablet),
              pageTwo(context, _pageController, checkIsIosTablet),
              Stack(
                children: <Widget>[
                  Container(
                    width: SizeConfig.blockSizeHorizontal * 100,
                    height: SizeConfig.blockSizeVertical * 100,
                    color: MyColors().lightBlack.withOpacity(0.5),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      top: Platform.isIOS
                          ? checkIsIosTablet(context)
                              ? SizeConfig.blockSizeVertical * 1
                              : SizeConfig.blockSizeVertical * 2
                          : SizeConfig.blockSizeVertical * 11,
                      left: SizeConfig.blockSizeHorizontal * 3,
                    ),
                    width: SizeConfig.blockSizeHorizontal * 100,
                    child: RichText(
                      text: TextSpan(
                        text: 'Become a well balanced athlete who is ',
                        style: TextStyle(
                            color: MyColors().white,
                            fontSize: checkIsIosTablet(context)
                                ? SizeConfig.safeBlockHorizontal * 5
                                : Platform.isIOS
                                    ? SizeConfig.safeBlockHorizontal * 6
                                    : SizeConfig.safeBlockHorizontal * 8,
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w400),
                        children: <TextSpan>[
                          TextSpan(
                              text: 'ready to compete and win',
                              style: TextStyle(
                                  fontSize: checkIsIosTablet(context)
                                      ? SizeConfig.safeBlockHorizontal * 5
                                      : Platform.isIOS
                                          ? SizeConfig.safeBlockHorizontal * 6
                                          : SizeConfig.safeBlockHorizontal * 8,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white)),
                        ],
                      ),
                    ),
                  ),
                  Container(
                      margin: EdgeInsets.only(
                        top: Platform.isIOS
                            ? checkIsIosTablet(context)
                                ? SizeConfig.blockSizeVertical * 10
                                : SizeConfig.blockSizeVertical * 12.5
                            : SizeConfig.blockSizeVertical * 30,
                        left: SizeConfig.blockSizeHorizontal * 3,
                      ),
                      child: Column(
                        children: <Widget>[
                          Container(
                            alignment: Alignment.centerLeft,
                            child: Text(ReviewText().text5,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: checkIsIosTablet(context)
                                        ? SizeConfig.safeBlockHorizontal * 5
                                        : Platform.isIOS
                                            ? SizeConfig.safeBlockHorizontal *
                                                6.0
                                            : SizeConfig.safeBlockHorizontal *
                                                8.0,
                                    fontStyle: FontStyle.normal,
                                    fontWeight: FontWeight.w400)),
                          ),
                          resultCont('', '-', ' Be Stronger, fitter, faster'),
                          resultCont('', '-', ' Improve power & conditioning'),
                          resultCont('', '-', ' Reduce body fat'),
                          resultCont('', '-', ' Increase muscle mass'),
                          resultCont('', '-', ' Improve mobility'),
                        ],
                      )),
                  Platform.isIOS
                      ? Container(
                          margin: EdgeInsets.only(
                              top: SizeConfig.blockSizeVertical * 48),
                          child: Text(
                              'App payments made through iTunes are controlled and managed by Apple.\nYour payment will be charged to your iTunes account at confirmation of purchase.Your subscription automatically renews unless auto-renew is turned off at least 24 hours before the end of the current period.Your Account will be charged for renewal within 24 hours prior to the end of the current, period, and the cost of the renewal will be stated.You may managed your subscription and may turn off auto-renewal by going to your iTunes Account Settings after purchase.You may cancel your purchase anytime during the 7-day trial period withouth cost,where applicable.Any unused portion of a free trial period, if offered, will be forfeited if you purchase subscription to that app, where applicable.',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                              )),
                        )
                      : EmptyContainer(),
                  Platform.isIOS
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.white)),
                              width: SizeConfig.blockSizeHorizontal * 20,
                              margin: EdgeInsets.only(
                                top: checkIsIosTablet(context)
                                    ? SizeConfig.blockSizeVertical * 62
                                    : Platform.isIOS
                                        ? SizeConfig.blockSizeVertical * 62.5
                                        : SizeConfig.blockSizeVertical * 78,
//                            left: SizeConfig.blockSizeHorizontal * 20,
//                            right: SizeConfig.blockSizeHorizontal * 20
                              ),
                              child: FlatButton(
                                  onPressed: () => FlutterInappPurchase.instance
                                      .getAvailablePurchases()
                                      .then((value) => print('restored')),
                                  child: Text(
                                    'Restore purchase',
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  )),
                            ),
//                          Container(
//                            width: SizeConfig.blockSizeHorizontal * 20,
//                            decoration: BoxDecoration(
//                                border: Border.all(color: Colors.white)
//                            ),
//                            margin: EdgeInsets.only(
//                              top: checkIsIosTablet(context)
//                                  ? SizeConfig.blockSizeVertical * 62
//                                  : Platform.isIOS ?  SizeConfig.blockSizeVertical * 62.5: SizeConfig.blockSizeVertical * 78,),
//                            child: FlatButton(onPressed: () =>  this._getProduct(), child: Text('Get subscriptions', style: TextStyle(
//                              color: Colors.white,
//                            ),)),
//                          )
                          ],
                        )
                      : EmptyContainer(),
                  Container(
                    margin:
                        EdgeInsets.only(top: SizeConfig.blockSizeVertical * 67),
                    child: Column(
                      children: this._renderInApps(),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  bool checkIsIosTablet(BuildContext context) {
    if (MediaQuery.of(context).size.width > 800) {
      return true;
    } else {
      return false;
    }
  }

  bool checkForTablet(BuildContext context) {
    if (MediaQuery.of(context).size.width > 600) {
      return true;
    } else {
      return false;
    }
  }
}
