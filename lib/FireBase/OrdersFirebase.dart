import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:planet_saver/Models/orderModel.dart';

class OrdersFireBase{
  FirebaseFirestore db=FirebaseFirestore.instance;
  void saveOrder(String orderTittle,int orderPrice,String orderDate,String datePlaced,String buyerId,String sellerId,bool status)async{
    List<OrderModel> ordersLenght=await getOrders();
    OrderModel orderModel=OrderModel(
        orderTittle: orderTittle,
        orderPrice: orderPrice,
        orderId: "${ordersLenght.length}",
        orderDate: orderDate,
        datePlaced: datePlaced,
        buyerId: buyerId,
        sellerId: sellerId,
        status: status);
    await db.collection("Orders").doc(ordersLenght.length.toString()).set(orderModel.toJson());
  }
  
  Future<List<OrderModel>> getOrders()async{
    List<OrderModel> orders=[];
    try{
      QuerySnapshot querySnapshot=await db.collection("Orders").get();
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
  Future<List<OrderModel>> getUsersOrders(String userID)async{
    List<OrderModel> orders=[];
    try{
      QuerySnapshot querySnapshot=await db.collection("Orders").where(Filter.or(Filter("SellerId",isEqualTo:userID),Filter("BuyerId",isEqualTo: userID))).get();
      for(var doc in querySnapshot.docs){
        OrderModel order=OrderModel.fromSnap(doc);
        orders.add(order);
      }
    }catch(e){
      print(e);
    }
    return orders;
  }
  Future<bool> markOrderComplete(String docID)async{
    try{
      await db.collection("Orders").doc(docID).update({"Status":true});
      return true;
    }catch(e){
      return false;
    }
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