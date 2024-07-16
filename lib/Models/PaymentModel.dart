// To parse this JSON data, do
//
//     final paymentModel = paymentModelFromJson(jsonString);

import 'dart:convert';

PaymentModel paymentModelFromJson(String str) => PaymentModel.fromJson(json.decode(str));

String paymentModelToJson(PaymentModel data) => json.encode(data.toJson());

class PaymentModel {
  String userId;
  int amount;
  String mobileNo;

  PaymentModel({
    required this.userId,
    required this.amount,
    required this.mobileNo,
  });

  factory PaymentModel.fromJson(Map<String, dynamic> json) => PaymentModel(
    userId: json["userId"],
    amount: json["amount"],
    mobileNo: json["mobileNo"],
  );

  Map<String, dynamic> toJson() => {
    "userId": userId,
    "amount": amount,
    "mobileNo": mobileNo,
  };
}
