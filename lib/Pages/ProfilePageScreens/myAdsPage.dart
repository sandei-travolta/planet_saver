import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:planet_saver/Controllers/user_statemanager.dart';
import 'package:planet_saver/FireBase/ads_storage.dart';

import '../../Models/Product.dart';
import '../Widgets/colors.dart';
class MyAdsPage extends StatefulWidget {
  const MyAdsPage({super.key});

  @override
  State<MyAdsPage> createState() => _MyAdsPageState();
}

class _MyAdsPageState extends State<MyAdsPage> {
  List<Product> myads=[];
  List<Product> myDisposals=[];
  final userId=Get.find<UserStateController>().currentser.value!.uid;
  final AdsCloudFireStore adsController=AdsCloudFireStore();
  void fetchAds()async{
    print("Getting");
    myads=await adsController.fetchUsersAds(userId);
    myDisposals=await adsController.fetchUsersDisposal(userId);
    setState(() {
    });
  }
  @override
  void initState() {
    super.initState();
    fetchAds();
  }
  int currentIndex=0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
                flex: 2,
                child: Container(
                  color: primaryColorV2.withOpacity(0.8),
                  width: double.maxFinite,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("My Ads",style: TextStyle(fontSize: 30,fontFamily: "PoppinsBold"),),
                    ],
                  ),
                )
            ),
            Expanded(
                ////flex: 1,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 30,vertical: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: (){
                          setState(() {
                            currentIndex=0;
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: currentIndex==0?Colors.green:Colors.white,
                            border: currentIndex==0?Border.all():Border.all(
                              width: 2,
                              color: Colors.black
                            )
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5.0,horizontal: 40),
                            child: Center(
                              child: Text("Selling",
                                /*style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w800
                                ),*/
                              ),
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: (){
                          setState(() {
                            currentIndex=1;
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: currentIndex==1?Colors.green:Colors.white,
                              border: currentIndex==1?Border.all():Border.all(
                                  width: 2,
                                  color: Colors.black
                              )
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5.0,horizontal: 40),
                            child: Center(
                              child: Text("Disposals",
                                /*style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w800
                                ),*/
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
            ),
            Expanded(
              flex: 14,
                child: Container(
                  child: ListView.builder(
                      itemCount: currentIndex==0?myads.length:myDisposals.length,
                      itemBuilder: (context,index){
                        Product product=currentIndex==0?myads[index]:myDisposals[index];
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Container(
                          height: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.black12
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 2,
                                  child: Container(
                                    height: 100,
                                    child: CachedNetworkImage(
                                      placeholder: (context,url)=>CircularProgressIndicator(),
                                      imageUrl:product.url[0],
                                      fit: BoxFit.fitHeight,
                                    ),
                                  )
                              ),
                              Expanded(
                                flex: 4,
                                  child: Container(
                                    padding: EdgeInsets.all(5),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Row(
                                          children: [
                                            Text(product.tittle,
                                              style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.w600
                                              ),
                                            )
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Text(product.category,
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w600
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Text("${product.price} Ksh",
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w600
                                              ),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  )),
                              IconButton(onPressed: () async {
                                bool deleted=currentIndex==0?await adsController.deleteAd(product.productId)
                                :
                                await adsController.deleteDisposal(product.productId);
                                fetchAds();
                              }, icon: Icon(Icons.delete))
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
                ))
          ],
        ),
      ),
    );
  }
}
