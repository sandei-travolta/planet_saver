import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:planet_saver/Models/Product.dart';

class AdsCloudFireStore{
  CollectionReference<Map<dynamic, dynamic>> _firebaseFirestore=FirebaseFirestore.instance.collection("Products");
  Future<bool> saveAd(String description,String tittle,List<String> url,int price,int weight,String uid)async{
    bool isSaved=false;
    Product product=Product(description: description,
        tittle: tittle,
        url: url,
        price: price,
        weight: weight,
        uid: uid
    );
    await _firebaseFirestore.doc().set(product.toJson()).then((bool) => isSaved=true);
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