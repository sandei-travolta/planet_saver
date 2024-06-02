import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class UserAuthentication{
  final FirebaseAuth auth=FirebaseAuth.instance;
  Future<UserCredential?> loginUser(String email,String password)async{
    UserCredential user=await auth.signInWithEmailAndPassword(email: email, password: password);
    if(user.user==null)
      return null;
    return user;
  }
  Future<UserCredential?> registerUser(String email,String password) async {
    UserCredential user=await auth.createUserWithEmailAndPassword(email: email, password: password);
    if(user.user!=null){
      return user;
    }
    else
      return null;
  }
}