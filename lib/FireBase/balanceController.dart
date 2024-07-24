import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:planet_saver/Models/BalanceModel.dart';

class BalanceController{
  FirebaseFirestore firebaseFirestore=FirebaseFirestore.instance;
  Future<BalanceModel?> fetchBalance(String uid) async {
    try {
      QuerySnapshot<Map<String, dynamic>> balanceDocs = await firebaseFirestore
          .collection("Users")
          .doc(uid)
          .collection("Balance")
          .get();

      if (balanceDocs.docs.isNotEmpty) {
        DocumentSnapshot<Map<String, dynamic>> balanceDoc = balanceDocs.docs.first;
        BalanceModel balance = BalanceModel.fromSnap(balanceDoc);
        print("gotten ${balance.amount}");
        return balance;
      } else {
        print("No Document got");
        return BalanceModel(amount: 0);
      }
    } catch (e) {
      print("Error fetching balance: $e");
      return null;
    }
  }
  void updateBalance(String uid,int amount)async{
    BalanceModel? balanceModel=await fetchBalance(uid);
    int newBalance=balanceModel!.amount!+amount;
    ///Update Balance
    QuerySnapshot<Map<String,dynamic>> balanceDoc=await firebaseFirestore
        .collection("Users")
        .doc(uid)
        .collection("Balance").get();
    if(balanceDoc.docs.isNotEmpty){
      firebaseFirestore
          .collection("Users")
          .doc(uid)
          .collection("Balance")
          .doc(uid+"Balance")
          .update({"Ämount":newBalance});
    }
    else{
      firebaseFirestore
          .collection("Users")
          .doc(uid)
          .collection("Balance")
          .doc(uid+"Balance")
          .set({"Balance":newBalance});
    }
  }
}