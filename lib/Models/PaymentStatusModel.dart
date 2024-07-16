// To parse this JSON data, do
//
//     final paymentStatus = paymentStatusFromJson(jsonString);

import 'dart:convert';


String paymentStatusToJson(PaymentStatus data) => json.encode(data.toJson());

class PaymentStatus {
  String checkoutRequestId;

  PaymentStatus({
    required this.checkoutRequestId,
  });


  Map<String, dynamic> toJson() => {
    "checkoutRequestID": checkoutRequestId,
  };
}
