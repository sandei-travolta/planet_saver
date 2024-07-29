import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:planet_saver/Controllers/user_statemanager.dart';
import 'package:planet_saver/Pages/CreateAdPage/CreateAd.dart';
import 'package:planet_saver/Pages/CreateAdPage/PickUpRequest.dart';
import 'package:planet_saver/Pages/HomePage/homeScreen.dart';
import 'package:planet_saver/Pages/HomePage/messagePage.dart';
import 'package:planet_saver/Pages/HomePage/ordersScreen.dart';
import 'package:planet_saver/Pages/HomePage/profilScreen.dart';
import 'package:planet_saver/Pages/Widgets/colors.dart';
class HomePage extends StatefulWidget {
   HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
   int _currentPage=0;

   List<Widget> _screens=[
     HomeScreen(),
     MessageScreen(),
     OrdersScreen(),
     ProfileScreen(),
   ];
   final stateController=Get.find<UserStateController>();

  @override
  Widget build(BuildContext context) {
    final user=stateController.currentser.value;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
      floatingActionButton: Obx(
          ()=>FloatingActionButton.extended(onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (_)=>stateController.currentSelection.value==0?CreateAd():RequestPickUp()));
        }, label: Text(
         stateController.currentSelection.value==0?"Sell":"PickUp",
          style: TextStyle(
            fontSize: 18,
          ),
        ),
          icon: Icon(
              stateController.currentSelection.value==0?Icons.shopping_cart:Icons.cleaning_services_outlined,
            size:30),
          backgroundColor: primaryColorV2,
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: primaryColorV2, // Set the color of your container
          boxShadow: [
            BoxShadow(
              color: Colors.black54.withOpacity(0.6),
              blurRadius: 40.0,
              offset: Offset(0.8, 0.8), // Set the offset to move the shadow only on the top side
            ),
          ],
        ),
        height: 55,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(onPressed: (){
              setState(() {
                _currentPage=0;
              });
            }, icon: Icon(CupertinoIcons.home,color: Colors.white,size: 40,)),
            IconButton(onPressed: (){
              setState(() {
                _currentPage=1;
              });
            }, icon: Icon(CupertinoIcons.text_bubble_fill,color: Colors.white,size: 35,)),
            IconButton(onPressed: (){
              setState(() {
                _currentPage=2;
              });
            }, icon: Icon(CupertinoIcons.rectangle_fill_on_rectangle_angled_fill,color: Colors.white,size: 40,)),
            IconButton(onPressed: (){
              setState(() {
                _currentPage=3;
              });
            }, icon: Icon(CupertinoIcons.profile_circled,color: Colors.white,size: 40,)),
          ],
        ),
      ),
        body: SafeArea(child: _screens[_currentPage])
    );
  }
}
