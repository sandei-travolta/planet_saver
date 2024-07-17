import 'package:cloud_firestore/cloud_firestore.dart';

class TransactionModel{
  final String transactionID;
  final String date;
  final int amount;
  final String senderID;
  final String receiverID;
  final bool status;

  TransactionModel({required this.transactionID,required this.date, required this.amount, required this.senderID, required this.receiverID,required this.status});
  Map<String,dynamic> toJson()=>{
    "TransactionID":transactionID,
    "Date":date,
    "Amount":amount,
    "SenderID":senderID,
    "ReceiverID":receiverID,
    "Status":status
  };
  static TransactionModel fromSnap(DocumentSnapshot documentSnapshot){
    var snapshot =documentSnapshot.data() as Map<String,dynamic>;
    return TransactionModel(
        transactionID: snapshot['TransactionID'],
        date: snapshot['Date'],
        amount: snapshot['Amount'],
        senderID: snapshot['SenderID'],
        receiverID: snapshot['ReceiverID'],
        status: snapshot['Status']
    );
  }
}