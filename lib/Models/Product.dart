import 'package:cloud_firestore/cloud_firestore.dart';

class Product{
  final String tittle;
  final List<String> url;
  final String uid;
  final String productId;
  final String description;
  final int price;
  final int weight;
  final String category;
  final String region;
  final bool status;
  Product({required this.description,required this.tittle, required this.url, required this.price, required this.weight, required this.uid,required this.category,required this.region,required this.status,required this.productId});
  Map<String,dynamic> toJson()=>{
    "tittle":tittle,
    "url":url,
    "description":description,
    "price":price,
    "weight":weight,
    "uid":uid,
    "category":category,
    "region":region,
    "status":status,
    "productId":productId
  };
  static Product fromSnap(DocumentSnapshot snapshot){
    var snap=snapshot.data() as Map<String,dynamic>;
    return Product(
        tittle:snap['tittle'],
        url:List<String>.from(snap['url']),
        description: snap['description'],
        price:snap['price'],
        weight:snap['weight'],
        uid:snap['uid'],
        category: snap['category'],
        region: snap['region'],
        status: snap['status'],
        productId: snap['productId']
    );
  }
}