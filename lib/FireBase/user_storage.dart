import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:planet_saver/Models/user_model.dart';

class UserStorage{
  CollectionReference<Map<dynamic, dynamic>> firebaseFirestore=FirebaseFirestore.instance.collection("Users");
  Future<void> saveUser(UserModel user)async{
    try {
      await firebaseFirestore.doc(user.uid).set(user.toJson()).then((_) =>print("User Saved"));
    }catch(e){

      print("eror Saving User"+e.toString());
    }
  }
  Future<UserModel?> getUser(String uid)async{
    try{
      UserModel currentUser=UserModel.fromSnap(await firebaseFirestore.doc(uid).get());
      return currentUser;
    }catch(e){
      print(e.toString());
    }
  }
  Future<void> updateProfileImage(String imgUrl,String uid)async{
    await firebaseFirestore.doc(uid).update({"imgUrl":imgUrl});
  }
  Future<bool> updateUserPofile(String name,String mobileNo,String role,String uid)async{
    try{
      await firebaseFirestore.doc(uid).update({
        "name":name,
        "mobileNo":mobileNo,
        "role":role
      });
      return true;
    }catch(e){
      return false;
    }
  }
}