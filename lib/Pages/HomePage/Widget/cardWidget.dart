import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:planet_saver/Controllers/user_statemanager.dart';

import '../../../Models/Product.dart';
import '../../DescriptionPage/DescriptionPage.dart';
import '../../DescriptionPage/PickUpDescriptionPage.dart';
import '../../Widgets/colors.dart';
class AdCard extends StatelessWidget {
  AdCard({
    super.key,
    required this.product,
  });

  final Product product;
  final pageSelected=Get.find<UserStateController>().currentSelection.value;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.push(context,MaterialPageRoute(builder: (_)=>pageSelected==0?DescriptionPage(product: product):PickUpDescriptionPage(product: product)));
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Container(
          color: primaryColorV2.withOpacity(0.8),
          height: 160,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: 140,
                width: double.maxFinite,
                child: CachedNetworkImage(
                  placeholder: (context,url)=>Center(
                    child: Container(
                      height: 40,
                      width: 40,
                      child: CircularProgressIndicator(),
                    ),
                  ),
                  imageUrl: product.url[0],fit: BoxFit.fill,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 100,
                      child: Text(product.tittle,style: TextStyle(
                          fontSize: 18,
                          overflow: TextOverflow.ellipsis
                      ),
                      ),
                    ),
                    Text("${product.price} Ksh")
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("${product.weight} Kg",style: TextStyle(
                        fontSize: 15
                    ),
                    ),
                    Text(
                      product.category,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5.0,vertical: 2),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Icon(Icons.location_on,size: 15,),
                    Text(product.region)
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}