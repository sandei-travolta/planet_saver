import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:planet_saver/Controllers/image_picker.dart';
import 'package:planet_saver/Models/Product.dart';

class AdsCloudFireStore{
  CollectionReference<Map<dynamic, dynamic>> _firebaseFirestore=FirebaseFirestore.instance.collection("Products");
  CollectionReference<Map<dynamic, dynamic>> _disposalCollection=FirebaseFirestore.instance.collection("Disposals");
  PickImage pickImage=PickImage();
  Future<bool> saveAd(String description,String tittle,List<File> files,int price,int weight,String uid,String category,String region)async{
    bool isSaved=false;
    List<String> urls=await pickImage.saveImages(files, uid);
    Product product=Product(description: description,
        tittle: tittle,
        url: urls,
        price: price,
        weight: weight,
        uid: uid,
        category: category,
        region: region
    );
    await _firebaseFirestore.doc().set(product.toJson()).then((bool) => isSaved=true);
    if(isSaved)
      return true;
    return false;
  }
  Future<bool> saveDisposalAd(String description,String tittle,List<File> files,int price,int weight,String uid,String category,String region)async{
    bool isSaved=false;
    List<String> urls=await pickImage.saveImages(files, uid);
    Product product=Product(description: description,
        tittle: tittle,
        url: urls,
        price: price,
        weight: weight,
        uid: uid,
        category: category,
        region: region
    );
    await _disposalCollection.doc().set(product.toJson()).then((bool) => isSaved=true);
    if(isSaved)
      return true;
    return false;
  }
  Future<List<Product>> fetchProducts() async {
    List<Product> products = [];

    try {
      QuerySnapshot querySnapshot = await _firebaseFirestore.get();

      for (var doc in querySnapshot.docs) {
        Product product = Product.fromSnap(doc);
        products.add(product);
      }
    } catch (e) {
      print('Error fetching products: $e');
    }
    return products;
  }
  Future<List<Product>> fetchUsersAds(String uid) async {
    List<Product> products = [];

    try {
      QuerySnapshot querySnapshot = await _firebaseFirestore.where('uid',isEqualTo: uid).get();

      for (var doc in querySnapshot.docs) {
        Product product = Product.fromSnap(doc);
        products.add(product);
      }
    } catch (e) {
      print('Error fetching products: $e');
    }

    return products;
  }
  Future<List<Product>> fetchDisposals()async{
    List<Product> disposals=[];
    try{
      QuerySnapshot querySnapshot=await _disposalCollection.get();
      for(var doc in querySnapshot.docs){
        Product product=Product.fromSnap(doc);
        disposals.add(product);
      }
    }catch(e){
      print("Error fetching disposal ${e}");
    }
    print("done");
    return disposals;
  }
}