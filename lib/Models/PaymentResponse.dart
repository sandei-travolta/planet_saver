// To parse this JSON data, do
//
//     final paymentResponse = paymentResponseFromJson(jsonString);

import 'dart:convert';

PaymentResponse paymentResponseFromJson(String str) => PaymentResponse.fromJson(json.decode(str));


class PaymentResponse {
  String merchantRequestId;
  String checkoutRequestId;
  String responseCode;
  String responseDescription;
  String customerMessage;

  PaymentResponse({
    required this.merchantRequestId,
    required this.checkoutRequestId,
    required this.responseCode,
    required this.responseDescription,
    required this.customerMessage,
  });

  factory PaymentResponse.fromJson(Map<String, dynamic> json) => PaymentResponse(
    merchantRequestId: json["MerchantRequestID"],
    checkoutRequestId: json["CheckoutRequestID"],
    responseCode: json["ResponseCode"],
    responseDescription: json["ResponseDescription"],
    customerMessage: json["CustomerMessage"],
  );
}
