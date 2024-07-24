import 'package:flutter/material.dart';
import 'package:planet_saver/FireBase/OrdersFirebase.dart';
import 'package:planet_saver/FireBase/TransactionsHistory.dart';
import 'package:planet_saver/FireBase/balanceController.dart';
import 'package:planet_saver/Models/orderModel.dart';

import '../../../Controllers/user_controller.dart';
import '../../../Models/user_model.dart';
import '../../Widgets/colors.dart';
class OrdersCard extends StatefulWidget {
  const OrdersCard({
    super.key,
    required this.orderModel,
    required this.currentUser
  });
  final OrderModel orderModel;
  final UserModel? currentUser;
  @override
  State<OrdersCard> createState() => _OrdersCardState();
}

class _OrdersCardState extends State<OrdersCard> {

  OrdersFireBase ordersFireBase=OrdersFireBase();
  TransactionHistory transactionHistory=TransactionHistory();
  BalanceController balanceController=BalanceController();
  Future<UserModel?> _returnUser(String id) async {
    UserController userController = UserController();
    UserModel? userModel = await userController.getCurrentUser(id);
    return userModel;
  }

  @override
  Widget build(BuildContext context) {
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
                      onTap: ()async{
                        bool updated=await ordersFireBase.markOrderComplete(widget.orderModel.orderId);
                        balanceController.updateBalance(widget.orderModel.sellerId, widget.orderModel.orderPrice);
                        transactionHistory.saveTransaction(widget.orderModel.orderId,"current-Date", widget.orderModel.orderPrice,widget.orderModel.buyerId, widget.orderModel.sellerId, true,widget.orderModel.sellerId);
                        print(updated);
                        setState(() {

                        });
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
