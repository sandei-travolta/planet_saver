import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:planet_saver/Controllers/image_picker.dart';
import 'package:planet_saver/Models/Product.dart';

class AdsCloudFireStore{
  CollectionReference<Map<dynamic, dynamic>> _firebaseFirestore=FirebaseFirestore.instance.collection("Products");
  CollectionReference<Map<dynamic, dynamic>> _disposalCollection=FirebaseFirestore.instance.collection("Disposals");
  PickImage pickImage=PickImage();
  Future<bool> saveAd(String description,String tittle,List<File> files,int price,int weight,String uid)async{
    bool isSaved=false;
    List<String> urls=await pickImage.saveImages(files, uid);
    Product product=Product(description: description,
        tittle: tittle,
        url: urls,
        price: price,
        weight: weight,
        uid: uid
    );
    await _firebaseFirestore.doc().set(product.toJson()).then((bool) => isSaved=true);
    if(isSaved)
      return true;
    return false;
  }
  Future<bool> saveDisposalAd(String description,String tittle,List<File> files,int price,int weight,String uid)async{
    bool isSaved=false;
    List<String> urls=await pickImage.saveImages(files, uid);
    Product product=Product(description: description,
        tittle: tittle,
        url: urls,
        price: price,
        weight: weight,
        uid: uid
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

}