import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:planet_saver/Models/PaymentModel.dart';
import 'package:planet_saver/Models/PaymentStatusModel.dart';
import 'package:planet_saver/constants.dart';

import '../Models/PayMentStatusResponseBody.dart';
import '../Models/PaymentResponse.dart';
class PaymentController{
  Future<PaymentResponse?> iniatePayment(String uid,int amount,String mobileNo) async{
    final url=Uri.parse("${tunnelUrl}/api/payment");
    final PaymentModel paymentModel=PaymentModel(userId: uid, amount: amount, mobileNo: mobileNo);
    final body=jsonEncode(paymentModel.toJson());
    final headers={'Content-Type':'application/json'};
    final response=await http.post(url,body: body,headers: headers);
    if(response.statusCode==200){
      final Map<String, dynamic> responseBody = json.decode(response.body);
      final PaymentResponse paymentResponse = PaymentResponse.fromJson(responseBody);
      print("success");
      return paymentResponse;
    }
    else{
      print("Error code ${response.statusCode} ${response.body}");
      return null;
    }
  }
  Future<bool> paymentStatus(String checkoutId)async{
    final url=Uri.parse("${tunnelUrl}/api/payment");
    final PaymentStatus paymentStatusModel=PaymentStatus(checkoutRequestId: checkoutId);
    final body=jsonEncode(paymentStatusModel.toJson());
    final headers={'Content-Type':'application/json'};
    final response=await http.post(url,body: body,headers: headers);
    if(response.statusCode==200){
      final Map<String,dynamic> responseBody=json.decode(response.body);
      final PaymentStatusResponse paymentStatusResponse=PaymentStatusResponse.fromJson(responseBody);
      if(paymentStatusResponse.resultCode==0){
        return true;
      }
      return false;
    }
    return false;
  }
}