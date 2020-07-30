import 'package:attt/view/subscription/recieptModels/receiptInfoModel.dart';

class RecieptModel {
  dynamic status;
  dynamic environment;
  ReceiptInfoModel receipt;

  RecieptModel(this.status, this.environment, this.receipt);

  factory RecieptModel.fromJson(Map<String, dynamic> map) {
    return RecieptModel(map['status'], map['environment'],
        ReceiptInfoModel.fromJson(map['receipt']));
  }
}
