import 'package:flutter/material.dart';
import 'package:planet_saver/Pages/Widgets/textWidgets.dart';
class ForgotPassword extends StatelessWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              loginTittleText(),
            ],
          )
        ],
      ),
    );
  }
}
