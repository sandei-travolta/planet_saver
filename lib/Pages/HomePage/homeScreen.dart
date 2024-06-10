import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:planet_saver/Controllers/user_statemanager.dart';
import 'package:planet_saver/FireBase/ads_storage.dart';
import 'package:planet_saver/Pages/DescriptionPage/DescriptionPage.dart';
import 'package:planet_saver/Pages/Widgets/colors.dart';

import '../../Models/Product.dart';
import '../constants.dart';
import 'Widget/bottomSheet.dart';
import 'Widget/buySection.dart';
import 'Widget/disposalSection.dart';
import 'Widget/texts.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  AdsCloudFireStore adsController=AdsCloudFireStore();
  late List<Product> products;
  final stateController=Get.find<UserStateController>();
  int selectedpage=0;
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
    final List pages=[
      buyection(stateController: stateController),
      DisposalSection()
    ];
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
                        return CustomBottomSheet();
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
          flex: 1,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0,vertical: 3.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: primaryColorV1.withOpacity(0.3),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          stateController.setPage(0);
                        });
                      },
                      child: Obx(
                            () => Container(
                          decoration: BoxDecoration(
                            color: stateController.currentSelection.value == 0
                                ? primaryColorV2.withOpacity(0.6)
                                : Colors.white,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          padding: EdgeInsets.symmetric(
                            vertical: 2,
                            horizontal: 35,
                          ),
                          child: Center(
                            child: categoryText("On Sell"),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          stateController.setPage(1);
                        });
                      },
                      child: Obx(
                            () => Container(
                          decoration: BoxDecoration(
                            color: stateController.currentSelection.value == 1
                                ? primaryColorV2.withOpacity(0.6)
                                : Colors.white,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          padding: EdgeInsets.symmetric(
                            vertical: 2,
                            horizontal: 35,
                          ),
                          child: Center(
                            child: categoryText("Disposal"),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ),
          ),
        ),
        Obx(() => pages[stateController.currentSelection.value])
      ],
    );
  }
}



