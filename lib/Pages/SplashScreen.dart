import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:planet_saver/Pages/LoginPage.dart';

import 'Widgets/textWidgets.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(seconds: 5)).then((value) => Navigator.push(context, MaterialPageRoute(builder: (_)=>LoginPage())));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CupertinoColors.activeGreen,
      body: Center(
        child: splashText(),
      ),
    );
  }
}
