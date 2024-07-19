import 'package:flutter/material.dart';
import 'package:planet_saver/Models/orderModel.dart';

import '../../Widgets/colors.dart';
class OrdersCard extends StatelessWidget {
  const OrdersCard({
    super.key, required this.orderModel,
  });
  final OrderModel orderModel;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      height: 120,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.grey.withOpacity(0.3)
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            children: [
              Text("Order Tittle:",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w800,color: Colors.grey),),
              const SizedBox(width: 5,),
              Text(orderModel.orderTittle,style: TextStyle(fontSize: 20,fontWeight: FontWeight.w800),)
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text("Order Date:",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w800,color: Colors.grey),),
                  const SizedBox(width: 5,),
                  Text(orderModel.orderDate,style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600),),
                ],
              ),
              Text("${orderModel.orderPrice}  Ksh",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600),)
            ],
          ),
          const SizedBox(height: 3,),
          Row(
            children: [
              Text("Seller",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w800),)
            ],
          ),
          const SizedBox(height: 15,),
          Expanded(
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: primaryColorV1
                ),
                child: Center(
                    child: Text("Marks Order Complete",
                      style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                          color: Colors.white
                      ),)
                ),
              ))
        ],
      ),
    );
  }
}
