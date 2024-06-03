import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:planet_saver/Controllers/user_statemanager.dart';
import 'package:planet_saver/FireBase/ads_storage.dart';
import 'package:planet_saver/Pages/DescriptionPage/DescriptionPage.dart';
import 'package:planet_saver/Pages/Widgets/colors.dart';

import '../../Models/Product.dart';
import '../constants.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  AdsCloudFireStore adsController=AdsCloudFireStore();
  late List<Product> products;
  final stateController=Get.find<UserStateController>();
  void getProducts()async{
    products=await adsController.fetchProducts();
    stateController.setProducts(products);
  }
  @override
  void initState(){
    getProducts();
    // TODO: implement initState

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
          flex:3,
          child: Container(
            decoration: BoxDecoration(
              color: primaryColorV2.withOpacity(0.8)
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(height: 40,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 40,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(14)
                      ),
                      height: 43,
                      width: 250,
                    ),
                    const SizedBox(width: 10,),
                    IconButton(onPressed: (){
                      showBottomSheet(context: context, builder:(_){
                        return BottomSheet();
                      });
                    }, icon:Icon(Icons.filter_list,size: 28,color: Colors.black,)),
                    Text("Filter",style: TextStyle(fontSize: 18,fontWeight: FontWeight.normal),)
                  ],
                ),
                const SizedBox(height: 18,),
                Container(
                  width: 390,
                  height: 40,
                  decoration: BoxDecoration(
                  ),
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: categories.length,
                      itemBuilder: (context,index){
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                      child: Container(
                        height: 10,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12)
                        ),
                        child: Center(
                          child:Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 2),
                            child: Text(
                              categories[index],
                              style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize: 15
                              ),
                            ),
                          )
                        ),
                      ),
                    );
                  }),
                )
              ],
            ),
          ),
        ),
        Expanded(
          flex: 11,
            child: Container(
              child: Obx(
              ()=>ListView.builder(
                  itemCount: stateController.productsList.value.length,
                    itemBuilder:(context,index){
                    List<Product> product=stateController.productsList.value;
                    return Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: InkWell(
                        onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (_)=>DescriptionPage(product: product[index],))),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Container(
                            width: double.maxFinite,
                            height: 300,
                            child: Column(
                              children: [
                                Expanded(
                                    flex: 3,
                                    child: Container(
                                      width: double.maxFinite,
                                      child: Image.network(product[index].url[0],fit: BoxFit.fill,),
                                )),
                                Expanded(
                                    flex: 1,
                                    child: Container(
                                      width: double.infinity,
                                      color:Colors.green,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                const SizedBox(height: 5,),
                                                Row(
                                                  children: [
                                                    Text(
                                                      product[index].tittle,style: TextStyle(
                                                      fontSize: 23,
                                                      color: Colors.white,
                                                      fontWeight: FontWeight.w700
                                                    ),),
                                                    const SizedBox(width: 20,),
                                                    Text("- Plastic",style: TextStyle(
                                                      fontSize: 18,
                                                      color: Colors.white,
                                                      fontWeight: FontWeight.w500
                                                    ),),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    Text("${product[index].price} Ksh",
                                                    style: TextStyle(
                                                      fontSize: 20,
                                                      color: Colors.black,
                                                      fontWeight: FontWeight.w600
                                                    ),
                                                    ),
                                                    const SizedBox(width: 20,),
                                                    Text("${product[index].price} Kg",
                                                    style: TextStyle(
                                                      fontSize: 18,
                                                      color: Colors.black,
                                                      fontWeight: FontWeight.w400
                                                    ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Row(
                                                  children: [
                                                    Text("Nyeri",
                                                    style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight: FontWeight.w600
                                                    ),
                                                    ),
                                                    Icon(Icons.location_on_rounded)
                                                  ],
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    )),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                }),
              ),
        )
        )
      ],
    );
  }
}

class BottomSheet extends StatelessWidget {
  const BottomSheet({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(10),
            topLeft: Radius.circular(10)
        )
      ),
    );
  }
}
