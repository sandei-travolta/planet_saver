import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel{
  final String name;
  final String uid;
  final String email;
  final int mobileNo;
  final int location;
  final bool verified;
  final String imgUrl;
  final String? role;
  UserModel({
    required this.imgUrl,
    required this.name,
    required this.uid,
    required this.email,
    required this.mobileNo,
    required this.location,
    required this.verified,
    this.role
  });
  Map<String,dynamic> toJson()=>{
    "name":name,
    "uid":uid,
    "email":email,
    "mobileNo":mobileNo,
    "location":location,
    "verified":verified,
    "imgUrl":imgUrl,
    "role":role
  };
  static UserModel fromSnap(DocumentSnapshot snapshot){
    var snap=snapshot.data() as Map<String,dynamic>;
    return UserModel(
      name: snap['name'],
      uid: snap['uid'],
      email: snap['email'],
      mobileNo: snap['mobileNo'],
      location: snap['location'],
      verified: snap['verified'],
      imgUrl: snap['imgUrl'],
      role: snap['role']
    );
  }
}