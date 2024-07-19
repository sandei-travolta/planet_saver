import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../Widgets/colors.dart';
class OrdersScreen extends StatelessWidget {
  OrdersScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    DateTime now = new DateTime.now();
    DateTime date = new DateTime(now.year, now.month, now.day);
    var formattedDate= DateFormat.yMMMd().format(date);
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
              child: ListView.builder(
                  itemCount: 3,
                  itemBuilder: (ontext,index){
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5.0,vertical: 5),
                  child: Container(
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
                            Text("Order-Tittle",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w800),)
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Order-price",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600),),
                            Text("Order-Date",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600),)
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
                  ),
                );
              }),
            ))
      ],
    );
  }
}
