class ReceiptInfoModel {
  dynamic receiptType;
  dynamic adamId;
  dynamic appItemId;
  dynamic bundleId;
  dynamic applicationVersion;
  dynamic downloadId;
  dynamic versionExternalIdentifier;
  dynamic receiptCreationDate;
  dynamic receiptCreationDateMs;
  dynamic receiptCreationDatePst;
  dynamic requestDate;
  dynamic requestDateMs;
  dynamic requestDatePst;
  dynamic originalPurchaseDate1;
  dynamic originalPurchaseDateMs1;
  dynamic originalPurchaseDatePst1;
  dynamic originalApplicationVersion;
  dynamic inApp;
  dynamic productId;
  dynamic quantity;
  dynamic transactionId;
  dynamic originalTransactionId;
  dynamic purchaseDate;
  dynamic purchaseDateMs;
  dynamic purchaseDatePst;
  dynamic originalPurchaseDate2;
  dynamic originalPurchaseDateMs2;
  dynamic originalPurchaseDatePst2;
  dynamic expiresDate;
  dynamic expiresDateMs;
  dynamic expiresDatePst;
  dynamic webOrderLineItemId;
  dynamic isTrialPeriod;
  dynamic isInIntroOfferPeriod;

  ReceiptInfoModel(
      {this.receiptType,
      this.adamId,
      this.appItemId,
      this.bundleId,
      this.applicationVersion,
      this.downloadId,
      this.versionExternalIdentifier,
      this.receiptCreationDate,
      this.receiptCreationDateMs,
      this.receiptCreationDatePst,
      this.requestDate,
      this.requestDateMs,
      this.requestDatePst,
      this.originalPurchaseDate1,
      this.originalPurchaseDateMs1,
      this.originalPurchaseDatePst1,
      this.originalApplicationVersion,
      this.inApp,
      this.productId,
      this.quantity,
      this.transactionId,
      this.originalTransactionId,
      this.purchaseDate,
      this.purchaseDateMs,
      this.purchaseDatePst,
      this.originalPurchaseDate2,
      this.originalPurchaseDateMs2,
      this.originalPurchaseDatePst2,
      this.expiresDate,
      this.expiresDateMs,
      this.expiresDatePst,
      this.webOrderLineItemId,
      this.isTrialPeriod,
      this.isInIntroOfferPeriod});

  ReceiptInfoModel.fromJson(Map<String, dynamic> map)
      : receiptType = map['receipt_type'],
        adamId = map['adam_id'],
        appItemId = map['app_item_id'],
        bundleId = map['bundle_id'],
        applicationVersion = map['application_version'],
        downloadId = map['download_id'],
        versionExternalIdentifier = map['version_external_identifier'],
        receiptCreationDate = map['receipt_creation_date'],
        receiptCreationDateMs = map['receipt_creation_date_ms'],
        receiptCreationDatePst = map['receipt_creation_date_pst'],
        requestDate = map['request_date'],
        requestDateMs = map['request_date_ms'],
        requestDatePst = map['request_date_pst'],
        originalPurchaseDate1 = map['original_purchase_date'],
        originalPurchaseDateMs1 = map['original_purchase_date_ms'],
        originalPurchaseDatePst1 = map['original_purchase_date_pst'],
        originalApplicationVersion = map['original_application_version'],
        inApp = map['in_app'];
}
