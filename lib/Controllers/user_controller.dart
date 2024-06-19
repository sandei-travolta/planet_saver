import 'dart:ffi';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:planet_saver/Controllers/user_statemanager.dart';
import 'package:planet_saver/FireBase/user_aunthetication.dart';
import 'package:planet_saver/FireBase/user_storage.dart';
import 'package:planet_saver/Models/user_model.dart';
import 'package:planet_saver/Pages/Widgets/colors.dart';

import '../Pages/LoginPage.dart';

class UserController{
  UserAuthentication _userAuthentication=UserAuthentication();
  UserStorage _userStorage=UserStorage();
  final _userStateController=Get.find<UserStateController>();
  Future<void> registerUser(String name,String email,String password,String mobileNo,String location,BuildContext context) async {
    UserCredential? _user = await _userAuthentication.registerUser(
        email, password);
    int mobileNoInt = formatMobileNumber(mobileNo);
    UserModel userModel = UserModel(imgUrl: "url",
        name: name,
        uid: _user!.user!.uid,
        email: email,
        mobileNo: mobileNoInt,
        location: 0,
        verified: false);
    _userStorage.saveUser(userModel).then((value){
      successCustomSnackBar("Account Created", context);
      Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>LoginPage()));});
  }
  Future<bool> resetPassword(String email,BuildContext context)async{
    try{
      await _userAuthentication.auth.sendPasswordResetEmail(email: email);
      successCustomSnackBar("Email Sent", context);
      return true;
    }catch(e){

    }
    return false;
  }
  Future<bool> loginUser(String email,String password,BuildContext context)async{
    try{
      UserCredential? _user=await _userAuthentication.loginUser(email, password);
      UserModel? currentUser= await getCurrentUser(_user!.user!.uid);
      _userStateController.setCur(currentUser!);
      successCustomSnackBar("Logged In", context);
      return true;
    }
    on FirebaseAuthException catch(e){
      print(e.code);
      switch (e.code){
        case "invalid-credential":
         customSnackBar("Invalid Email or Password", context);
        case "network-request-failed":
          customSnackBar("You Appear to be offline", context);
        default:
          customSnackBar(e.code, context);
      }
    }
    return false;
    ///return getCurrentUser(_user!.user!.uid);
  }
  Future<UserModel?> getCurrentUser(String uid){
    return _userStorage.getUser(uid);
  }
  int formatMobileNumber(String mobileNo){
    int firstValue= int.parse(mobileNo[0]);
    if(firstValue==0){
      mobileNo='254'+mobileNo.substring(1);
      return int.parse(mobileNo);
    }
    return int.parse(mobileNo);
  }
}
ScaffoldFeatureController<SnackBar, SnackBarClosedReason> customSnackBar(String message,BuildContext context){
  return ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message),backgroundColor: Colors.red,));
}
ScaffoldFeatureController<SnackBar, SnackBarClosedReason> successCustomSnackBar(String message,BuildContext context){
  return ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message),backgroundColor: primaryColorV1,));
}