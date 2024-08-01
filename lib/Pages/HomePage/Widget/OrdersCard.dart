import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:planet_saver/Controllers/paymentController.dart';
import 'package:planet_saver/FireBase/OrdersFirebase.dart';
import 'package:planet_saver/FireBase/TransactionsHistory.dart';
import 'package:planet_saver/FireBase/balanceController.dart';
import 'package:planet_saver/Models/orderModel.dart';

import '../../../Controllers/user_controller.dart';
import '../../../Models/PaymentResponse.dart';
import '../../../Models/user_model.dart';
import '../../Widgets/colors.dart';
class OrdersCard extends StatefulWidget {
  const OrdersCard({
    super.key,
    required this.orderModel,
    required this.currentUser,
    required this.refreshOrders
  });
  final OrderModel orderModel;
  final UserModel? currentUser;
  final VoidCallback refreshOrders;
  @override
  State<OrdersCard> createState() => _OrdersCardState();
}

class _OrdersCardState extends State<OrdersCard> {
  OrdersFireBase ordersFireBase=OrdersFireBase();
  TransactionHistory transactionHistory=TransactionHistory();
  BalanceController balanceController=BalanceController();
  TextEditingController mobileNoController=TextEditingController();
  PaymentController paymentController=PaymentController();
  String currentDate=DateFormat("dd-MM-yyyy").format(DateTime.now());
  Future<UserModel?> _returnUser(String id) async {
    UserController userController = UserController();
    UserModel? userModel = await userController.getCurrentUser(id);
    return userModel;
  }

  @override
  Widget build(BuildContext context) {
    mobileNoController.text=widget.currentUser!.mobileNo.toString();
    return FutureBuilder<UserModel?>(
      future:_returnUser(widget.orderModel.sellerId),
      builder: (context,userSnapshot) {
        if (userSnapshot.connectionState == ConnectionState.waiting) {
          return Center(
              child: Center(
                child: Container(
                    height: 40,
                    width: 40,
                    child: CircularProgressIndicator()),
              ));
        }
        if (!userSnapshot.hasData || userSnapshot.data == null) {
          return Text('User data not available');
        }
        var otherUser = userSnapshot.data!;
        return Container(
          height: 120,
          padding: EdgeInsets.all(8),
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
                  Text(widget.orderModel.orderTittle,style: TextStyle(fontSize: 20,fontWeight: FontWeight.w800),)
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text("Order Date:",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w800,color: Colors.grey),),
                      const SizedBox(width: 5,),
                      Text(widget.orderModel.orderDate,style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600),),
                    ],
                  ),
                  Text("${widget.orderModel.orderPrice}  Ksh",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600),)
                ],
              ),
              const SizedBox(height: 3,),
              Row(
                children: [
                  Text("Seller:",style: TextStyle(fontSize: 12,fontWeight: FontWeight.w800,color: Colors.grey),),
                  const SizedBox(width: 5,),
                  Text(widget.orderModel.sellerId==widget.currentUser!.uid?"You":otherUser.name,style: TextStyle(fontSize: 15,fontWeight: FontWeight.w800),)
                ],
              ),
              const SizedBox(height: 15,),
              Expanded(
                  child:widget.currentUser!.uid==widget.orderModel.sellerId?
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: primaryColorV2
                    ),
                    child: Center(
                        child: Text(widget.orderModel.status==true?"Order Complete" :"Order Pending",
                          style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w600,
                              color: Colors.white
                          ),)
                    ),
                  )
                      :
                  Container(
                    child: widget.orderModel.status?Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: primaryColorV1
                      ),
                      child: Center(
                          child: Text("Order Complete",
                            style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w600,
                                color: Colors.white
                            ),)
                      ),
                    ):
                    InkWell(
                      onTap: widget.orderModel.isDisposal?()=>showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Mark Order Complete'),
                            content: TextField(
                              decoration: InputDecoration(
                                hintText: "Mobile No",

                              ),
                            ),
                            actions: <Widget>[
                              TextButton(
                                child: Text('OK'),
                                onPressed: () async {
                                  PaymentResponse? paymentResponse= await paymentController.iniatePayment(
                                      widget.currentUser!.uid,
                                      widget.orderModel.orderPrice,
                                      mobileNoController.text.toString()
                                  );
                                  if(paymentResponse==null){
                                    customSnackBar("Check Mobile No and Try Again", context);
                                  }
                                  else{
                                    ///bool paymentStatus=await paymentController.paymentStatus(paymentResponse.checkoutRequestId);
                                    await Future.delayed(Duration(seconds: 45)).then((value) => print("Executed Now"));
                                    bool paymentStatus=await paymentController.paymentStatus(paymentResponse.checkoutRequestId);
                                    if(paymentStatus){
                                      OrderModel product=widget.orderModel;
                                      print("payment status $paymentStatus");
                                      transactionHistory.saveTransaction(paymentResponse.checkoutRequestId,currentDate,product.orderPrice,widget.currentUser!.uid,product.sellerId,false,widget.orderModel.sellerId);
                                      bool updated=await ordersFireBase.markOrderComplete(widget.orderModel.orderId);
                                      balanceController.updateBalance(widget.orderModel.sellerId, widget.orderModel.orderPrice);
                                      transactionHistory.saveTransaction(widget.orderModel.orderId,currentDate, widget.orderModel.orderPrice,widget.orderModel.buyerId, widget.orderModel.sellerId, true,widget.orderModel.sellerId);
                                      widget.refreshOrders;
                                      print("Saved");
                                      successCustomSnackBar("😎😎😎",context);
                                    }
                                    else{
                                      print("payment status $paymentStatus");
                                      customSnackBar("Tafuta Pesa😂😂😂", context);
                                    }
                                  }
                                  Navigator.of(context).pop();
                                },
                              ),
                              TextButton(
                                child: Text('Cancle'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        },
                      ):
                          ()async{
                        bool updated=await ordersFireBase.markOrderComplete(widget.orderModel.orderId);
                        balanceController.updateBalance(widget.orderModel.sellerId, widget.orderModel.orderPrice);
                        transactionHistory.saveTransaction(widget.orderModel.orderId,currentDate, widget.orderModel.orderPrice,widget.orderModel.buyerId, widget.orderModel.sellerId, true,widget.orderModel.sellerId);
                        print(updated);
                        widget.refreshOrders;
                      },
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
                      ),
                    ),
                  ))
            ],
          ),
        );
      }
    );
  }
}
