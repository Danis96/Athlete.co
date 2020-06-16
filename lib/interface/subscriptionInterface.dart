
import 'package:in_app_purchase/in_app_purchase.dart';

abstract class SubscriptionInterface {
   Future<void> initStoreInfo();
   void deliverProduct(PurchaseDetails purchaseDetails);
   void showPendingUI();
   void handleError(IAPError error);
   Future<bool> verifyPurchase(PurchaseDetails purchaseDetails);
   void handleInvalidPurchase(PurchaseDetails purchaseDetails);
   subscribePressed(ProductDetails productDetails);
}