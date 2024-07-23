import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:planet_saver/Controllers/user_statemanager.dart';

import '../../FireBase/OrdersFirebase.dart';
import '../../Models/orderModel.dart';
import '../HomePage/Widget/OrdersCard.dart';
import '../Widgets/colors.dart';
class MyOrdersPage extends StatefulWidget {
  const MyOrdersPage({super.key});

  @override
  State<MyOrdersPage> createState() => _MyOrdersPageState();
}

class _MyOrdersPageState extends State<MyOrdersPage> {
  OrdersFireBase ordersFireBase=OrdersFireBase();
  List<OrderModel> orders=[];
  final user=Get.find<UserStateController>();

  @override
  void initState() {
    super.initState();
    fetchOrders();
  }
  void fetchOrders()async{
    orders=await ordersFireBase.getOrders();
    setState(() {});
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
              flex: 2,
              child: SafeArea(
                child: Container(
                  color: primaryColorV2.withOpacity(0.8),
                  width: double.maxFinite,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("My Orders",style: TextStyle(fontSize: 30,fontFamily: "PoppinsBold"),),
                    ],
                  ),
                ),
              )
          ),
          Expanded(
              flex: 11,
              child: Container(
                child: orders.isEmpty
                    ? Center(child:Text("You Have No Orders",
                    style: TextStyle(
                      fontSize: 18,
                    )))
                    :ListView.builder(
                    itemCount: orders.length,
                    itemBuilder: (context,index){
                      OrderModel orderModel=orders[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5.0,vertical: 5),
                        child: OrdersCard(orderModel: orderModel,currentUser: user.currentser.value),
                      );
                    }),
              ))
        ],
      ),
    );
  }
}
