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
  final user=Get.find<UserStateController>();
  final AdsCloudFireStore adsController=AdsCloudFireStore();
  void fetchAds()async{
    print("Getting");
    myads=await adsController.fetchUsersAds(user.currentser.value!.uid);
    setState(() {
    });
  }
  @override
  void initState() {
    super.initState();
    fetchAds();
  }
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
              flex: 14,
                child: Container(
                  child: ListView.builder(
                      itemCount: myads.length,
                      itemBuilder: (context,index){
                        Product product=myads[index];
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
                                      mainAxisAlignment: MainAxisAlignment.start,
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
                                        )
                                      ],
                                    ),
                                  )),
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
