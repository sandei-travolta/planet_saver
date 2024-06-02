import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:planet_saver/FireBase/user_aunthetication.dart';
import 'package:planet_saver/FireBase/user_storage.dart';
import 'package:planet_saver/Models/user_model.dart';

import '../Pages/LoginPage.dart';

class UserController{
  UserAuthentication _userAuthentication=UserAuthentication();
  UserStorage _userStorage=UserStorage();
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
      Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>LoginPage()));});
  }
  Future<UserModel?> loginUser(String email,String password)async{
    UserCredential? _user=await _userAuthentication.loginUser(email, password);
    return getCurrentUser(_user!.user!.uid);
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