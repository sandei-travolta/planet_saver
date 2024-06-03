import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:planet_saver/Controllers/user_controller.dart';
import 'package:planet_saver/Pages/LoginPage.dart';
import 'package:planet_saver/Pages/LoginPage/registrationFom2.dart';
import 'package:planet_saver/Pages/LoginPage/registrationForm1.dart';
import 'package:planet_saver/Pages/Widgets/colors.dart';
import 'package:planet_saver/Pages/Widgets/textWidgets.dart';
class RegisterPage extends StatefulWidget {
  RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  UserController _userController=UserController();
  TextEditingController nameController =TextEditingController();
  TextEditingController contactController =TextEditingController();
  TextEditingController locationController=TextEditingController();
  TextEditingController emailController=TextEditingController();
  TextEditingController passWordController=TextEditingController();
  TextEditingController confirmPassWordController=TextEditingController();
  int _currentPage=0;
  bool isLoading=false;
  @override
  Widget build(BuildContext context) {
    List _forms=[
      PersonalInfo(
        nameController: nameController,
        mobileNoController: contactController,
        locationController: locationController,
      ),
      MoreInfo(
        emailController: emailController,
        passwordController: passWordController,
        confirmPasswordController: confirmPassWordController,
      )
    ];
    return Scaffold(
      body: Column(
        children: [
          Expanded(
              flex: 4,
              child: Center(child: loginTittleText())),
          _forms[_currentPage],
          Expanded(
              flex: 2,
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 20,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _currentPage==0?Container(
                    height: 40,
                      width: 120,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12)
                      ),
                    ):InkWell(
                          onTap: (){
                            setState(() {
                              _currentPage=0;
                            });
                          },
                      child: Container(
                            height: 40,
                            width: 120,
                            decoration: BoxDecoration(
                                color: primaryColorV2,
                                borderRadius: BorderRadius.circular(12)
                            ),
                            child: Center(
                              child: Text(
                                "Back",style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.w700),
                              ),
                            ),
                          ),
                    ),
                        Container(
                          height: 30,
                          width: 80,
                        ),
                        _currentPage==1?InkWell(
                          onTap: (){
                            setState(() {
                              isLoading=true;
                            });
                            _userController.registerUser(nameController.text, emailController.text, passWordController.text,contactController.text, locationController.text, context);
                            setState(() {
                              isLoading=false;
                            });
                            },
                            child: Container(
                            height: 40,
                            width: 120,
                            decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: primaryColorV2,
                            ),
                            child: Center(
                            child: isLoading==false?Text(
                            "Submit",style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.w700),
                            ):Center(
                            child: Container
                              (
                                  height: 30,
                                  width: 30,
                                  child: CircularProgressIndicator(),
                                ),
                              ),
                            ),
                          ),
                        ):InkWell(
                          onTap: (){
                            setState(() {
                              _currentPage=1;
                            });
                          },
                          child: Container(
                            height: 40,
                            width: 120,
                            decoration: BoxDecoration(
                              color: primaryColorV2,
                              borderRadius: BorderRadius.circular(12)
                            ),
                            child: Center(
                              child: Text(
                                "Next",style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.w700),
                              ),
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ))
        ],
      )
    );
  }
}
