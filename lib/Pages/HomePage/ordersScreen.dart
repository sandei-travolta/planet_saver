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
              child: Text("No orders set for ${formattedDate}",
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ))
      ],
    );
  }
}
