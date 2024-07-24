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
        return balance;
      } else {
        return BalanceModel(amount: 0);
      }
    } catch (e) {
      print("Error fetching balance: $e");
      return null;
    }
  }
}