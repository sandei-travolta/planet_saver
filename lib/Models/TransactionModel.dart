import 'package:cloud_firestore/cloud_firestore.dart';

class TransactionModel{
  final String date;
  final int amount;
  final String senderID;
  final String receiverID;
  final bool status;

  TransactionModel({required this.date, required this.amount, required this.senderID, required this.receiverID,required this.status});
  Map<String,dynamic> toJson()=>{
    "Date":date,
    "Amount":amount,
    "SenderID":senderID,
    "ReceiverID":receiverID,
    "Status":status
  };
  static TransactionModel fromSnap(DocumentSnapshot documentSnapshot){
    var snapshot =documentSnapshot.data() as Map<String,dynamic>;
    return TransactionModel(
        date: snapshot['Date'],
        amount: snapshot['Amount'],
        senderID: snapshot['SenderID'],
        receiverID: snapshot['ReceiverID'],
        status: snapshot['Status']
    );
  }
}