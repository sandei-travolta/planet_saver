import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:planet_saver/Models/orderModel.dart';

class OrdersFireBase{
  FirebaseFirestore db=FirebaseFirestore.instance;
  void saveOrder(String orderTittle,int orderPrice,String orderDate,String datePlaced,String buyerId,String sellerId,bool status)async{
    List<OrderModel> buyerOrders=await getOrders(buyerId);
    List<OrderModel> sellerOrders=await getOrders(sellerId);
    OrderModel orderModel=OrderModel(
        orderTittle: orderTittle,
        orderPrice: orderPrice,
        orderId: "${buyerOrders.length}",
        orderDate: orderDate,
        datePlaced: datePlaced,
        buyerId: buyerId,
        sellerId: sellerId,
        status: status);
    OrderModel sellerOrder=OrderModel(
        orderTittle: orderTittle,
        orderPrice: orderPrice,
        orderId: "${sellerOrders.length}",
        orderDate: orderDate,
        datePlaced: datePlaced,
        buyerId: buyerId,
        sellerId: sellerId,
        status: status);
    await db.collection("Users").doc(buyerId).collection("Orders").doc(buyerOrders.length.toString()).set(orderModel.toJson());
    await db.collection("Users").doc(sellerId).collection("Orders").doc(sellerOrders.length.toString()).set(sellerOrder.toJson());
  }
  Future<List<OrderModel>> getOrders(String uid)async{
    List<OrderModel> orders=[];
    try{
      QuerySnapshot querySnapshot=await db.collection("Users").doc(uid).collection("Orders").get();
      print("getting Orders");
      for(var doc in querySnapshot.docs){
        OrderModel order=OrderModel.fromSnap(doc);
        orders.add(order);
      }
      print("Gots Order");
      print("number of apparent orders${orders.length}");
    }catch(e){
      print(e);
    }
    return orders;
  }
  Future<List<OrderModel>> getDaysOrders(String uid,String date)async{
    List<OrderModel> orders=[];
    try{
      QuerySnapshot querySnapshot=await db.collection("Users").doc(uid).collection("Orders").where('OrderDate',isEqualTo: date).get();
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