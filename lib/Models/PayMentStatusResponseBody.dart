// To parse this JSON data, do
//
//     final paymentStatusResponse = paymentStatusResponseFromJson(jsonString);

import 'dart:convert';

PaymentStatusResponse paymentStatusResponseFromJson(String str) => PaymentStatusResponse.fromJson(json.decode(str));


class PaymentStatusResponse {
  String responseCode;
  String responseDescription;
  String merchantRequestId;
  String checkoutRequestId;
  String resultCode;
  String resultDesc;

  PaymentStatusResponse({
    required this.responseCode,
    required this.responseDescription,
    required this.merchantRequestId,
    required this.checkoutRequestId,
    required this.resultCode,
    required this.resultDesc,
  });

  factory PaymentStatusResponse.fromJson(Map<String, dynamic> json) => PaymentStatusResponse(
    responseCode: json["ResponseCode"],
    responseDescription: json["ResponseDescription"],
    merchantRequestId: json["MerchantRequestID"],
    checkoutRequestId: json["CheckoutRequestID"],
    resultCode: json["ResultCode"],
    resultDesc: json["ResultDesc"],
  );

}
