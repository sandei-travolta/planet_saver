import 'package:flutter/material.dart';
import 'package:planet_saver/Pages/Widgets/colors.dart';

import '../../DummyData/dummyProucts.dart';
import '../../Models/Product.dart';
class DescriptionPage extends StatelessWidget {
  const DescriptionPage({Key? key, required this.product}) : super(key: key);
  final Product product;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        height: 60,
        color: primaryColorV2,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text("${product.tittle}",
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w600,
              color: Colors.white
            ),),
            Text("~${product.price} Ksh",
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w600,
                  color: Colors.white
              ),),
            Container(
              height: 50,
              width: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: primaryColor
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Icon(Icons.shopping_cart,
                    color: Colors.white,
                    size: 30,
                  ),
                  Text("Inquire",style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w500
                  ),)
                ],
              ),
            )
          ],
        ),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
                flex: 4,
                child: Container(
                  padding: EdgeInsets.symmetric(vertical:5,horizontal: 5),
                  height: double.maxFinite,
                  width: double.infinity,
                  child: Stack(
                    children: [
                      Container(
                          height: double.maxFinite,
                          width: double.infinity,
                          child: Image.network(product.url[0],fit: BoxFit.fill,)),
                      Positioned(
                          child: InkWell(
                            onTap: ()=>Navigator.pop(context),
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Container(
                                                      height: 50,
                                                      width: 50,
                                                      decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: primaryColorV2,
                                                      ),
                                                      child: Center(child: Icon(Icons.arrow_back,
                                                      size: 40,)),
                                                    ),
                            ),
                          ))
                    ],
                  ),
            )
            ),
            Expanded(
              flex: 2,
                child: Container(
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                      itemCount: 4,
                      itemBuilder: (context,index){
                    return Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Container(
                          color: Colors.black12,
                          width: 200,
                          height: 200,
                          child: Image.network(product.url[0],fit: BoxFit.fill,),
                        ),
                      ),
                    );
                  }),
            )
            ),
            Expanded(
                flex: 4,
                child: Container(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const SizedBox(height: 10,),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(product.tittle,style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.w700
                              ),),
                              Row(
                                children: [
                                  Icon(Icons.add_chart_sharp),
                                  const SizedBox(width: 10,),
                                  Text("Plastic",style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
                                    color: Colors.black45
                                  ),),
                                ],
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5.0),
                          child: Row(
                            children: [
                              Text(
                                "${product.price} Ksh",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "${product.weight} Kg",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black45
                                ),
                              ),
                              Row(
                                children: [
                                  Icon(Icons.location_on,size: 25,),
                                  Text(
                                    "Nyeri",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black45
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        const SizedBox(height: 20,),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text("Description",style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w700
                              ),)
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                product.description,
                                maxLines: 15,
                                style: TextStyle(
                                  fontSize: 15
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20,),
                      ],
                    ),
                  ),
                )
            )
          ],
        ),
      ),
    );
  }
}