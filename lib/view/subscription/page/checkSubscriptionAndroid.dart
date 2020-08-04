import 'dart:async';
import 'dart:io';
import 'package:attt/interface/subscriptionInterface.dart';
import 'package:attt/utils/colors.dart';
import 'package:attt/utils/emptyContainer.dart';
import 'package:attt/utils/size_config.dart';
import 'package:attt/view/chooseAthlete/pages/chooseAthlete.dart';
import 'package:attt/view/subscription/declinedScreen.dart';
import 'package:attt/view/subscription/page/subscription.dart';
import 'package:attt/view/subscription/page/widgets/price.dart';
import 'package:attt/view/subscription/page/widgets/subscriptionLoader.dart';
import 'package:attt/view/trainingPlan/pages/trainingPlan.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:in_app_purchase/in_app_purchase.dart';

const bool kAutoConsume = true;
const String _kConsumableId = 'consumable';
const String oneMonthID = 'onemonthathlete';
const String yearID = 'lifetimeathlete';
String purchaseExist = '';
List<String> _productIDs = [];

/// id's from Google Play Console
const List<String> _kProductIds = <String>[
  'onemonthathlete',
  'lifetimeathlete'
];

class CheckSubscriptionAndroid extends StatefulWidget {
  final bool userExist;
  final String userName, userEmail, userPhoto, userUID;
  final DocumentSnapshot currentUserDocument, currentUserTrainerDocument;

  CheckSubscriptionAndroid({
    this.userExist,
    this.userUID,
    this.userPhoto,
    this.userEmail,
    this.userName,
    this.currentUserTrainerDocument,
    this.currentUserDocument,
  });

  @override
  _CheckSubscriptionAndroidState createState() =>
      _CheckSubscriptionAndroidState();
}

class _CheckSubscriptionAndroidState extends State<CheckSubscriptionAndroid>
    implements SubscriptionInterface {
  PageController _pageController;
  final InAppPurchaseConnection _connection = InAppPurchaseConnection.instance;
  StreamSubscription<List<PurchaseDetails>> _subscription;
  List<String> _notFoundIds = [];
  List<ProductDetails> _products = [];
  List<PurchaseDetails> _purchases = [];
  bool _isAvailable = false,
      _isPurchased = false,
      _purchasePending = false,
      _loading = true;
  String _queryProductError,
      priceMonthly = '\$19.99',
      priceLifetime = '\$99.99';

  PurchaseDetails previousPurchase;

  @override
  void initState() {
    Stream purchaseUpdated =
        InAppPurchaseConnection.instance.purchaseUpdatedStream;
    _subscription = purchaseUpdated.listen((purchaseDetailsList) {
      _listenToPurchaseUpdate(purchaseDetailsList);
    }, onDone: () {
      _subscription.cancel();
    }, onError: (error) {
      // handle error here.
    });
    initStoreInfo();
    _pageController = PageController();
    print(_isPurchased.toString() + 'IS PURCHASE');
    loading();
    super.initState();
  }

  Future<void> initStoreInfo() async {
    final bool isAvailable = await _connection.isAvailable();
    if (!isAvailable) {
      setState(() {
        _isAvailable = isAvailable;
        _products = [];
        _purchases = [];
        _notFoundIds = [];
        _purchasePending = false;
        _loading = false;
      });
      return;
    }

    ProductDetailsResponse productDetailResponse =
        await _connection.queryProductDetails(_kProductIds.toSet());
    if (productDetailResponse.error != null) {
      setState(() {
        _queryProductError = productDetailResponse.error.message;
        _isAvailable = isAvailable;
        _products = productDetailResponse.productDetails;
        _purchases = [];
        _notFoundIds = productDetailResponse.notFoundIDs;
        _purchasePending = false;
        _loading = false;
      });
      return;
    }

    if (productDetailResponse.productDetails.isEmpty) {
      setState(() {
        _queryProductError = null;
        _isAvailable = isAvailable;
        _products = productDetailResponse.productDetails;
        _purchases = [];
        _notFoundIds = productDetailResponse.notFoundIDs;
        _purchasePending = false;
        _loading = false;
      });
      return;
    }

    final QueryPurchaseDetailsResponse purchaseResponse =
        await _connection.queryPastPurchases();
    if (purchaseResponse.error != null) {
      // handle query past purchase error..
    }
    final List<PurchaseDetails> verifiedPurchases = [];
    for (PurchaseDetails purchase in purchaseResponse.pastPurchases) {
      if (await verifyPurchase(purchase)) {
        verifiedPurchases.add(purchase);
      }
    }
    setState(() {
      _isAvailable = isAvailable;
      _products = productDetailResponse.productDetails;
      _purchases = verifiedPurchases;
      _notFoundIds = productDetailResponse.notFoundIDs;
      _purchasePending = false;
      _loading = false;
    });
  }

  Card _buildConnectionCheckTile() {
    if (_loading) {
      return Card(child: ListTile(title: const Text('Trying to connect...')));
    }
    final Widget storeHeader = ListTile(
      leading: Icon(_isAvailable ? Icons.check : Icons.block,
          color: _isAvailable ? Colors.green : ThemeData.light().errorColor),
      title: Text(
          'The store is ' + (_isAvailable ? 'available' : 'unavailable') + '.'),
    );
    final List<Widget> children = <Widget>[storeHeader];

    if (!_isAvailable) {
      _productIDs.add('Not available');
      children.addAll([
        Divider(),
        ListTile(
          title: Text('Not connected',
              style: TextStyle(color: ThemeData.light().errorColor)),
          subtitle: const Text(
              'Unable to connect to the payments processor. Has this app been configured correctly?'),
        ),
      ]);
    }
    return Card(child: Column(children: children));
  }

  void deliverProduct(PurchaseDetails purchaseDetails) async {
    // IMPORTANT!! Always verify a purchase purchase details before delivering the product.
    if (purchaseDetails.productID == _kConsumableId) {
      setState(() {
        _purchasePending = false;
      });
    } else {
      setState(() {
        _purchases.add(purchaseDetails);
        _purchasePending = false;
      });
    }
  }

//
  void listenToPurchaseUpdated(List<PurchaseDetails> purchaseDetailsList) {}

  void showPendingUI() {
    setState(() {
      _purchasePending = true;
    });
  }

  void handleError(IAPError error) {
    setState(() {
      _purchasePending = false;
    });
  }

  Card _buildProductList() {
    if (!_isAvailable) {
      _productIDs.add('Not available');

      /// ako nije store available prikazati ovo
      return Card(
        color: Colors.transparent,
        child: Container(
          height: SizeConfig.blockSizeVertical * 10,
          child: Center(
              child: Text(
            'Not available at the moment',
            style: TextStyle(
                color: MyColors().lightWhite,
                fontSize: SizeConfig.safeBlockHorizontal * 6),
          )),
        ),
      );
    }
    List<Widget> productList = <Widget>[];
    if (_notFoundIds.isNotEmpty) {
      _productIDs.add('Not available');
      productList.add(SizedBox(
        child: Container(
          child: Text('Not available at the moment'),
        ),
        width: 200,
      ));
    }

    // This loading previous purchases code is just a demo. Please do not use this as it is.
    // In your app you should always verify the purchase data using the `verificationData` inside the [PurchaseDetails] object before trusting it.
    // We recommend that you use your own server to verity the purchase data.
    Map<String, PurchaseDetails> purchases =
        Map.fromEntries(_purchases.map((PurchaseDetails purchase) {
      if (purchase.pendingCompletePurchase) {
        InAppPurchaseConnection.instance.completePurchase(purchase);
      }
      return MapEntry<String, PurchaseDetails>(purchase.productID, purchase);
    }));

    productList.addAll(_products
        .map(
          (ProductDetails productDetails) {
            /// get previous purchases
            /// then check is that purchases active and
            /// set the [_isPurchased] to accurate value
            previousPurchase = purchases[productDetails.id];

            purchaseExist = previousPurchase != null
                ? previousPurchase.productID.toString()
                : 'annual';
            print(purchaseExist + ' PURCHASE EXIST');

            _productIDs.add(purchaseExist);
            print('PRODUCT IDS: ' + _productIDs.toString());

            var names = productDetails.title.split(' ');

            return priceContainer(
              '7 Days Free Trial',
              names,
              productDetails.price.substring(1),
              context,
              subscribePressed,
              productDetails,
            );
          },
        )
        .toList()
        .reversed);

    return Card(
        color: Colors.transparent,
        child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[EmptyContainer(), Divider()] + productList));
  }

  @override
  void handleInvalidPurchase(PurchaseDetails purchaseDetails) {
    showDeclinedDialog(context, 'Invalid Purchase',
        'Purchase you are trying to get is not available at the moment.\n Please try again in a few moments.');
  }

  _listenToPurchaseUpdate(List<PurchaseDetails> purchaseDetailsList) {
    purchaseDetailsList.forEach((PurchaseDetails purchaseDetails) async {
      if (purchaseDetails.status == PurchaseStatus.pending) {
        showPendingUI();
      } else {
        if (purchaseDetails.status == PurchaseStatus.error) {
          handleError(purchaseDetails.error);
        } else if (purchaseDetails.status == PurchaseStatus.purchased) {
          bool valid = await verifyPurchase(purchaseDetails);
          if (valid) {
            deliverProduct(purchaseDetails);
          } else {
            handleInvalidPurchase(purchaseDetails);
            return;
          }
        }
        if (Platform.isAndroid) {
          if (!kAutoConsume && purchaseDetails.productID == _kConsumableId) {
            await InAppPurchaseConnection.instance
                .consumePurchase(purchaseDetails);
          }
        }
        if (purchaseDetails.pendingCompletePurchase) {
          await InAppPurchaseConnection.instance
              .completePurchase(purchaseDetails)
              .then((value) => Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                      builder: (_) => widget.userExist
                          ? widget.currentUserDocument.data['trainer'] !=
                                      null &&
                                  widget.currentUserDocument.data['trainer'] !=
                                      ''
                              ? TrainingPlan(
                                  userTrainerDocument:
                                      widget.currentUserTrainerDocument,
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
                            ))));
        } else {
          showDeclinedDialog(context, 'Not approved',
              'Please check your payments method, card validation or internet access.');
        }
      }
    });
  }

  /// function that is called on button pressed
  ///  in [priceContainer]
  ///  here we showPaywall and our connection with Google Play Subscriptions
  @override
  subscribePressed(ProductDetails productDetails) {
    PurchaseParam purchaseParam = PurchaseParam(
        productDetails: productDetails,
        applicationUserName: null,
        sandboxTesting: true);

    if (productDetails.id == _kConsumableId) {
      _connection.buyConsumable(
        purchaseParam: purchaseParam,
        autoConsume: kAutoConsume || Platform.isIOS,
      );
    } else {
      _connection.buyNonConsumable(purchaseParam: purchaseParam);
    }
  }

  @override
  Future<bool> verifyPurchase(PurchaseDetails purchaseDetails) {
    return Future<bool>.value(true);
  }

  Future<Timer> loading() async {
    return Timer(Duration(seconds: 3), onDoneLoading);
  }

  onDoneLoading() {
    print(purchaseExist + ' IS PURCHASED FROM on done loading');
    Navigator.of(context).push(MaterialPageRoute(
        builder: (_) =>
            purchaseExist == oneMonthID || purchaseExist == yearID
                ? widget.userExist
                    ? widget.currentUserDocument.data['trainer'] != null &&
                            widget.currentUserDocument.data['trainer'] != ''
                        ? TrainingPlan(
                            userTrainerDocument:
                                widget.currentUserTrainerDocument,
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
                      )
                : SubscriptionClass(
                    currentUserDocument: widget.currentUserDocument,
                    currentUserTrainerDocument:
                        widget.currentUserTrainerDocument,
                    buildProductList: _buildProductList(),
                    pageController: _pageController,
                    userName: widget.userName,
                    userEmail: widget.userEmail,
                    userPhoto: widget.userPhoto,
                    userUID: widget.userUID,
                    userExist: widget.userExist,
                  )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors().lightBlack,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SubLoader().subLoader(),
          SubLoader().subLoaderText(),
          Container(
            height: 0,
            width: 0,
            child: _buildProductList(),
          ),
        ],
      ),
    );
  }
}
