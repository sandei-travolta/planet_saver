import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../Models/Product.dart';
import '../../DescriptionPage/DescriptionPage.dart';
import '../../Widgets/colors.dart';
class CardWidget extends StatelessWidget {
  const CardWidget({
    super.key,
    required this.product,
  });
  final Product product;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: InkWell(
        onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (_)=>DescriptionPage(product: product,))),
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
                      child: CachedNetworkImage(
                        placeholder: (context,url)=>
                            Center(
                              child: Container(
                                height: 40,
                                width: 40,
                                child: CircularProgressIndicator(),
                              ),
                            ),
                        imageUrl: product.url[0],fit: BoxFit.fill,
                      ),
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
                                      product.tittle,style: TextStyle(
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
                                    Text("${product.price} Ksh",
                                      style: TextStyle(
                                          fontSize: 20,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w600
                                      ),
                                    ),
                                    const SizedBox(width: 20,),
                                    Text("${product.price} Kg",
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
  }
}
class AdCard extends StatelessWidget {
  const AdCard({
    super.key,
    required this.product,
  });

  final Product product;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Container(
        color: primaryColorV2.withOpacity(0.8),
        height: 150,
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
                  Text(product.tittle,style: TextStyle(
                      fontSize: 18
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
                  Text("Category")
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0,vertical: 2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Icon(Icons.location_on,size: 15,),
                  Text("Nyeri")
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}