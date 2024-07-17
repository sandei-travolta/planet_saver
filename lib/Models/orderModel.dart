import 'package:cloud_firestore/cloud_firestore.dart';

class OrderModel{
  final String orderTittle;
  final int orderPrice;
  final String orderId;
  final String orderDate;
  final String datePlaced;
  final String buyerId;
  final String sellerId;
  final bool status;

  OrderModel({required this.orderTittle,required this.orderPrice,required this.orderId, required this.orderDate, required this.datePlaced,required this.buyerId, required this.sellerId,required this.status});

  Map<String,dynamic> toJson()=>{
    "OrderTittle":orderTittle,
    "OrderPrice":orderPrice,
    "OrderID":orderId,
    "OrderDate":orderDate,
    "DatePlaced":datePlaced,
    "BuyerId":buyerId,
    "SellerId":sellerId,
    "Status":status
  };
  static OrderModel fromSnap(DocumentSnapshot documentSnapshot){
    var snapShot=documentSnapshot.data() as Map<String,dynamic>;
    return OrderModel(
        orderTittle:snapShot['OrderTittle'],
        orderPrice: snapShot['OrderPrice'],
        orderId: snapShot['OrderId'],
        orderDate: snapShot['OrderDate'],
        datePlaced: snapShot['DatePlaced'],
        buyerId:snapShot['BuyerId'],
        sellerId: snapShot['sellerId'],
        status: snapShot['status']
    );
  }
}