import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:planet_saver/Models/TransactionModel.dart';

class TransactionHistory{
  FirebaseFirestore db=FirebaseFirestore.instance;
  void saveTransaction(String transactionID,String date,int amount,String senderID,String receiverID,bool status,String useID)async{
    TransactionModel transaction=TransactionModel(
        transactionID: transactionID,
        date: date,
        amount: amount,
        senderID: senderID,
        receiverID: receiverID,
        status: status
    );
    await db.collection("Users").doc(useID).collection("Transactions").doc().set(transaction.toJson());
    ///await db.collection("Users").doc(receiverID).collection("Transactions").doc().set(transaction.toJson());
  }
  Future<List<TransactionModel>> getTransactions(String uid)async{
    List<TransactionModel> transactionsHistory=[];
    try{
      QuerySnapshot querySnapshot=await db.collection("Users").doc(uid).collection("Transactions").get();
      for(var doc in querySnapshot.docs){
        TransactionModel transaction=TransactionModel.fromSnap(doc);
        transactionsHistory.add(transaction);
      }
    }catch(e){
      print(e);
    }
    return transactionsHistory;
  }
}