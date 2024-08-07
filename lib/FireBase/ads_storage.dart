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
    String _productId=idGenerator();
    Product product=Product(
        description: description,
        tittle: tittle,
        url: urls,
        price: price,
        weight: weight,
        uid: uid,
        category: category,
        region: region,
        status: false,
        productId: _productId,
    );
    await _firebaseFirestore.doc(_productId).set(product.toJson()).then((bool) => isSaved=true);
    if(isSaved)
      return true;
    return false;
  }
  Future<bool> saveDisposalAd(String description,String tittle,List<File> files,int price,int weight,String uid,String category,String region)async{
    bool isSaved=false;
    List<String> urls=await pickImage.saveImages(files, uid);
    String _productId=idGenerator();
    Product product=Product(description: description,
        tittle: tittle,
        url: urls,
        price: price,
        weight: weight,
        uid: uid,
        category: category,
        region: region,
        status: false,
        productId: _productId
    );
    await _disposalCollection.doc(_productId).set(product.toJson()).then((bool) => isSaved=true);
    if(isSaved)
      return true;
    return false;
  }
  Future<List<Product>> fetchProducts(String uid) async {
    List<Product> products = [];

    try {
      QuerySnapshot querySnapshot = await _firebaseFirestore.where(Filter.and(Filter("uid",isNotEqualTo: uid),Filter("status",isEqualTo: false))).get();
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
  Future<List<Product>> fetchUsersDisposal(String uid) async {
    List<Product> products = [];

    try {
      QuerySnapshot querySnapshot = await _disposalCollection.where('uid',isEqualTo: uid).get();

      for (var doc in querySnapshot.docs) {
        Product product = Product.fromSnap(doc);
        products.add(product);
      }
    } catch (e) {
      print('Error fetching products: $e');
    }

    return products;
  }
  Future<List<Product>> fetchDisposals(String uid)async{
    List<Product> disposals=[];
    try{
      QuerySnapshot querySnapshot=await _disposalCollection.where(Filter.and(Filter("uid",isNotEqualTo: uid),Filter("status",isEqualTo:false))).get();
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
  Future<bool> deleteAd(String uid)async{
    try{
      await _firebaseFirestore.doc(uid).delete();
      return true;
    }catch(e){
      print(e);
      return false;
    }
  }
  Future<bool> deleteDisposal(String uid)async{
    try{
      await _disposalCollection.doc(uid).delete();
      return true;
    }catch(e){
      return false;
    }
  }
  Future<bool> updatproductStatus(String uid)async{
    try{
      await _firebaseFirestore.doc(uid).update({"status":true});
      return true;
    }catch(e){
      return false;
    }
  }
  Future<bool> updateDisposalStatus(String uid)async{
    try{
      await _disposalCollection.doc(uid).update({"status":true});
      print("updated: ${uid}");
      return true;
    }catch(e){
      print("notUpdated: ${e} : ${uid}");
      return false;
    }
  }
}
String idGenerator() {
  final now = DateTime.now();
  return now.microsecondsSinceEpoch.toString();
}
