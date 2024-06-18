import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:planet_saver/Controllers/user_controller.dart';
import 'package:planet_saver/Pages/Widgets/textWidgets.dart';

import 'LoginPage/registrationFom2.dart';
import 'Widgets/colors.dart';
import 'Widgets/textinput_widgets.dart';
class ForgotPassword extends StatelessWidget {
  ForgotPassword({Key? key}) : super(key: key);
  TextEditingController emailController=TextEditingController();
  UserController _userController=UserController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 40,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              loginTittleText(),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: context.height*0.6,
              padding: registerFormPad(),
              decoration: BoxDecoration(
                color: primaryColorV1.withOpacity(0.6),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(45),
                  topRight: Radius.circular(12),
                  bottomRight: Radius.circular(45),
                  bottomLeft: Radius.circular(12),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 20,
                  ),
                  Text("Enter Email To Reset Password",style: TextStyle(
                    fontSize: 20,
                    color: Colors.white
                  ),),
                  SizedBox(
                    height: context.height*0.1,
                  ),
                  registrationTextFields(emailController,Icons.email,"Enetr Email","Email"),
                  SizedBox(
                    height: context.height*0.15,
                  ),
              InkWell(
                onTap: ()async{
                  bool reset=await _userController.resetPassword(emailController.text,context);
                  if(reset)
                    print("reset");
                },
                child: Container(
                  height: 55,
                  width: 220,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: primaryColorV2
                  ),
                  child: Center(
                    child: Text("Reset",style: TextStyle(fontSize: 25,color: Colors.white,fontWeight: FontWeight.w600),)
                  )),
              )],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
