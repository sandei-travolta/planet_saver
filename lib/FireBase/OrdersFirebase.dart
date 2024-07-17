import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:planet_saver/Models/orderModel.dart';

class OrdersFireBase{
  FirebaseFirestore db=FirebaseFirestore.instance;
  void saveOrder(String orderTittle,int orderPrice,String orderDate,String datePlaced,String buyerId,String sellerId,bool status)async{

    OrderModel orderModel=OrderModel(
        orderTittle: orderTittle,
        orderPrice: orderPrice,
        orderId: "",
        orderDate: orderDate,
        datePlaced: datePlaced,
        buyerId: buyerId,
        sellerId: sellerId,
        status: status);
    await db.collection("Users").doc(buyerId).collection("Orders").doc().set(orderModel.toJson());
    await db.collection("Users").doc(sellerId).collection("Orders").doc().set(orderModel.toJson());
  }
  Future<List<OrderModel>> getOrders(String uid)async{
    List<OrderModel> orders=[];
    try{
      QuerySnapshot querySnapshot=await db.collection("Users").doc(uid).collection("Orders").get();
      for(var doc in querySnapshot.docs){
        OrderModel order=OrderModel.fromSnap(doc);
        orders.add(order);
      }
    }catch(e){
      print(e);
    }
    return orders;
  }
}