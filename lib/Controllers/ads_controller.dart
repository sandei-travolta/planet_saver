import 'package:planet_saver/Models/Product.dart';

class AdsController{
Future<void> createAd(String description,String tittle,List<String> url,int price,int weight,String uid,String category,String region) async{
  final Product product=Product(description: description,
      tittle: tittle,
      url: url,
      price: price,
      weight: weight,
      uid: uid,
      category: category,
      region: region
  );

}
}