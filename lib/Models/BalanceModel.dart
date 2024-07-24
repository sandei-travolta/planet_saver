import 'package:cloud_firestore/cloud_firestore.dart';

class BalanceModel{
  final int? amount;

  BalanceModel({required this.amount});
  static BalanceModel fromSnap(DocumentSnapshot documentSnapshot){
    var snap=documentSnapshot.data() as Map<String,dynamic>;
    return BalanceModel(amount: snap["Balance"]);
  }
}