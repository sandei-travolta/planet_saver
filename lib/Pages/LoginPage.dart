import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:planet_saver/Controllers/user_statemanager.dart';
import 'package:planet_saver/Models/user_model.dart';
import 'package:planet_saver/Pages/HomePage/homePage.dart';
import 'package:planet_saver/Pages/LoginPage/RegisterPage.dart';
import 'package:planet_saver/Pages/Widgets/colors.dart';
import 'package:planet_saver/Pages/Widgets/textWidgets.dart';

import '../Controllers/user_controller.dart';
import '../Controllers/user_statemanager.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  UserController _userController=UserController();

  TextEditingController emailController=TextEditingController();

  TextEditingController passwordController=TextEditingController();

  final userStateController =Get.find<UserStateController>();

  bool isVisible=false;
  bool isLoading=false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          Expanded(
            flex: 4,
              child: Center(child: loginTittleText())),
          Expanded(
            flex: 7,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Container(
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
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          height:10,
                        ),
                        loginTexte("Login"),
                        const SizedBox(height: 10,),
                    Container(
                      width: 300,
                      child: TextFormField(
                        controller: emailController,
                        decoration: const InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          labelText: "Enter Email",
                          hintText: "Email",
                          labelStyle: TextStyle(
                              color: Colors.black
                          ),
                        )
                      )
                    ),
                        const SizedBox(height: 35,),
                        Container(
                            width: 300,
                            child: TextFormField(
                              obscureText: !isVisible,
                                controller: passwordController,
                                decoration: const InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  labelText: "Password",
                                  hintText: "password",
                                  labelStyle: TextStyle(
                                      color: Colors.black
                                  ),
                                )
                            )
                        ),
                        const SizedBox(height: 5,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Checkbox(
                              value: isVisible,
                              onChanged: (value) {
                                setState(() {
                                  isVisible = value!;
                                });
                                print(isVisible);
                              },
                            ),
                            Text("Show Password",style: TextStyle(color: Colors.white,fontSize: 20),),
                          ],
                        ),
                        const SizedBox(height: 20,),
                        InkWell(
                          onTap:()async {
                            setState(() {
                              isLoading=true;
                            });
                            bool loggedIn=await _userController.loginUser(emailController.text, passwordController.text,context);
                            if(loggedIn){
                              Navigator.push(context, MaterialPageRoute(builder: (_)=>HomePage()));
                            }
                            setState(() {
                              isLoading=false;
                            });
                          },
                          child: Container(
                            height: 55,
                            width: 220,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: primaryColorV2
                            ),
                            child: Center(
                              child: isLoading==false?
                              Text("Login",style: TextStyle(fontSize: 25,color: Colors.white,fontWeight: FontWeight.w600),)
                                  :
                              Container(
                                height: 40,
                                width: 40,
                                child: Center(
                                  child: CircularProgressIndicator(),
                                ),
                              )
                            ),
                          ),
                        ),
                        const SizedBox(height: 15,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text("Forgot Password ?",style: TextStyle(color: Colors.white,fontSize: 20),),
                            const SizedBox(width: 35,)
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              )),
          Expanded(
            flex: 2,
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 20,),
                    InkWell(
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => RegisterPage())),
                        child: Text("Create  Account?",style: TextStyle(color: Colors.black87,fontSize: 20),)),
                  ],
                ),
              ))
        ],
      ),
    );
  }
}
