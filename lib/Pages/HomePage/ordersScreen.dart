import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:planet_saver/Controllers/user_statemanager.dart';
import 'package:planet_saver/FireBase/OrdersFirebase.dart';
import 'package:planet_saver/Models/orderModel.dart';

import '../Widgets/colors.dart';
import 'Widget/OrdersCard.dart';
class OrdersScreen extends StatefulWidget {
  OrdersScreen({Key? key}) : super(key: key);

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  OrdersFireBase ordersFireBase=OrdersFireBase();
  List<OrderModel> orders=[];
  late var formattedDate;
  late var queryDate;
  final stateController=Get.find<UserStateController>();
  void fetchOrders()async{
    orders=await ordersFireBase.getDaysOrders(stateController.currentser.value!.uid,queryDate);
    setState(() {});
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    DateTime now = new DateTime.now();
    DateTime date = new DateTime(now.year, now.month, now.day);
    formattedDate= DateFormat.yMMMd().format(date);
    queryDate=DateFormat("dd-MM-yyyy").format(date);
    fetchOrders();
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
            flex: 2,
            child: Container(
              color: primaryColorV2.withOpacity(0.8),
              child: Center(
                  child:Text("Orders",style: TextStyle(fontSize: 30,fontFamily: "PoppinsBold"),),
              ),
            )),
        Expanded(
            flex: 2,
            child: Container(
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      formattedDate,
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w500
                      ),),
                    const SizedBox(
                      width: 35,
                    ),
                    Icon((Icons.calendar_today))
                  ],
                ),
              ),
            )),
        Expanded(
            flex: 11,
            child: Container(
              /*child: Text("No orders set for ${formattedDate}",
                style: TextStyle(
                  fontSize: 18,
                ),
              ),*/
              child: orders.isEmpty
                  ? Center(child:Text("No orders set for ${formattedDate}",
                style: TextStyle(
                  fontSize: 18,
                )))
                  :ListView.builder(
                  itemCount: orders.length,
                  itemBuilder: (context,index){
                    OrderModel orderModel=orders[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5.0,vertical: 5),
                  child: OrdersCard(orderModel: orderModel),
                );
              }),
            ))
      ],
    );
  }
}

