import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:planet_saver/Controllers/user_statemanager.dart';
import 'package:planet_saver/FireBase/ads_storage.dart';
import 'package:planet_saver/Pages/DescriptionPage/DescriptionPage.dart';
import 'package:planet_saver/Pages/Widgets/colors.dart';
import 'package:planet_saver/Pages/utilities/searchfunction.dart';

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
  late List<Product> disposals;

   int? selectedCategory=null;
  final stateController=Get.find<UserStateController>();
  int selectedpage=0;
  late List<Product> filteredproduct;
  late List<Product> filteredDisposal;
  void getProducts()async{
    products=await adsController.fetchProducts();
    disposals=await adsController.fetchDisposals();
    stateController.setProducts(products);
    stateController.setDisposals(disposals);
  }
  void filterProducts(String category)async{
    filteredproduct=products.where((product) => product.category==category).toList();
    filteredDisposal=disposals.where((product) => product.category==category).toList();
    stateController.setProducts(filteredproduct);
    stateController.setDisposals(filteredDisposal);
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
          flex:2,
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
                    const SizedBox(width: 10,),
                    Container(
                      width: context.width*0.8,
                      height: 40,
                      decoration: BoxDecoration(
                      ),
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: categories.length,
                          itemBuilder: (context,index){
                            return Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 5.0,vertical: 5),
                              child: InkWell(
                                onTap: (){
                                  if(selectedCategory.isNull||selectedCategory!=index){
                                    setState(() {
                                      selectedCategory=index;
                                    });
                                    filterProducts(categories[index]);
                                  }
                                  else if(!selectedCategory.isNull&&selectedCategory==index){
                                    setState(() {
                                      selectedCategory=null;
                                    });
                                    getProducts();
                                  }
                                },
                                child: Container(
                                  height: 10,
                                  decoration: BoxDecoration(
                                      color: !selectedCategory.isNull && selectedCategory==index?Colors.white:primaryColorV1.withOpacity(0.8),
                                      borderRadius: BorderRadius.circular(12)
                                  ),
                                  child: Center(
                                      child:Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                        child: Text(
                                          categories[index],
                                          style: TextStyle(
                                              fontWeight: FontWeight.normal,
                                              fontSize: 15,
                                            color:  !selectedCategory.isNull && selectedCategory==index?Colors.black:Colors.white,
                                          ),
                                        ),
                                      )
                                  ),
                                ),
                              ),
                            );
                          }),
                    ),
                    IconButton(onPressed: (){
                      List<Product> list=stateController.currentSelection.value==0?stateController.productsList.value:stateController.disposalList.value;
                      showSearch(
                          context: context,
                          delegate: CustomSearchDelegeta(
                              list: list
                          )
                      );
                      }, icon:Icon(Icons.search,size: 30,color: Colors.white,)),
                  ],
                ),
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



