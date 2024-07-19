import 'package:flutter/material.dart';

import '../Widgets/colors.dart';
class MyAdsPage extends StatelessWidget {
  const MyAdsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
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
          ],
        ),
      ),
    );
  }
}
