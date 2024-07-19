import 'package:flutter/material.dart';

import '../Widgets/colors.dart';
class WalletPage extends StatelessWidget {
  const WalletPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
                flex: 2,
                child: Container(
                  color: primaryColorV2.withOpacity(0.8),
                  width: double.maxFinite,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("My Wallet",style: TextStyle(fontSize: 30,fontFamily: "PoppinsBold"),),
                    ],
                  ),
                )
            ),
            Expanded(
                flex: 2,
                child: Container(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.grey
                  ),
                  child: Center(
                    child: Column(

                    ),
                  ),
                ),
              ),
            )),
            Expanded(
                flex: 9,
                child: Container(
                  color: Colors.purple,
                ))
          ],
        ),
      ),
    );
  }
}
