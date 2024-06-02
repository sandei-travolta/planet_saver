import 'package:cloud_firestore/cloud_firestore.dart';

class Product{
  final String tittle;
  ///Convert to list
  final List<String> url;
  final String uid;
  final String description;
  final int price;
  final int weight;
  Product({required this.description,required this.tittle, required this.url, required this.price, required this.weight, required this.uid});
  Map<String,dynamic> toJson()=>{
    "tittle":tittle,
    "url":url,
    "description":description,
    "price":price,
    "weight":weight,
    "uid":uid,
  };
  static Product fromSnap(DocumentSnapshot snapshot){
    var snap=snapshot.data() as Map<String,dynamic>;
    return Product(
        tittle:snap['tittle'],
        url:List<String>.from(snap['url']),
        description: snap['description'],
        price:snap['price'],
        weight:snap['weight'],
        uid:snap['uid']);
  }
}