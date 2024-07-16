import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:planet_saver/Controllers/user_statemanager.dart';
import 'package:planet_saver/FireBase/ChatsFireBase.dart';
import 'package:planet_saver/Pages/Widgets/colors.dart';


import '../../Controllers/paymentController.dart';
import '../../Models/Product.dart';
class DescriptionPage extends StatelessWidget {
   DescriptionPage({Key? key, required this.product}) : super(key: key);
  final Product product;
  final MessagingService messagingService=MessagingService();
  final PaymentController paymentController=PaymentController();
  final user=Get.find<UserStateController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        height: 60,
        color: primaryColorV2,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              width: 100,
              child: Text("${product.tittle}",maxLines: 1,overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w600,
                color: Colors.white
              ),),
            ),
            Text("~${product.price} Ksh",
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w600,
                  color: Colors.white
              ),),
            InkWell(
              onTap: (){
                messagingService.createFirstMessage(
                    user.currentser.value!.uid,
                    product.uid,
                    "Making Inquiry on ${product.tittle}",
                    true
                );
                print("message sent");
              },
              child: Container(
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
                          child: CachedNetworkImage(
                            placeholder: (context,url)=>Center(
                              child: Container(
                                height: 40,
                                width: 40,
                                child: CircularProgressIndicator(),
                              ),
                            ),
                            imageUrl:product.url[0],fit: BoxFit.fill,)),
                      Positioned(
                          child: InkWell(
                            onTap: ()=>showModalBottomSheet(
                              context: context,
                              builder: (BuildContext context){
                                TextEditingController nameConroller=TextEditingController();
                                TextEditingController townController=TextEditingController();
                                TextEditingController mobileNoController=TextEditingController();
                                TextEditingController dateController=TextEditingController();
                                nameConroller.text=user.currentser.value!.name;
                                mobileNoController.text=user.currentser.value!.mobileNo.toString();

                                return Container(
                                  width: double.maxFinite,
                                  height: context.mediaQuery.size.height*0.6,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(12),
                                      topLeft: Radius.circular(12)
                                    )
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      const SizedBox(height: 10,),
                                      Text("Place Order",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w700),),
                                      const SizedBox(height: 5,),
                                      modalFormTittles("Your Name"),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                                        child: TextField(
                                          controller: nameConroller,
                                          decoration: InputDecoration(
                                            hintText: "Name"
                                          )
                                        ),
                                      ),
                                      const SizedBox(height: 10,),
                                      modalFormTittles("Delivery Adrress"),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                                        child: TextField(
                                            controller: townController,
                                            decoration: InputDecoration(
                                                hintText: "Your Location"
                                            )
                                        ),
                                      ),
                                      const SizedBox(height: 10,),
                                      modalFormTittles("Mobile No to make Payment"),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 15.0,vertical: 5),
                                        child: TextField(
                                            controller: mobileNoController,
                                            decoration: InputDecoration(
                                                hintText: "No to Make Payment"
                                            )
                                        ),
                                      ),
                                      modalFormTittles("Pick Up Date"),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                                        child: TextField(
                                            controller: dateController,
                                            decoration: InputDecoration(
                                                hintText: "Pick Up Date"
                                            )
                                        ),
                                      ),
                                      const SizedBox(height: 20,),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                        child: InkWell(
                                          onTap: (){
                                            paymentController.iniatePayment(
                                                user.currentser.value!.uid,
                                                product.price,
                                                mobileNoController.text.toString()
                                            );
                                          },
                                          child: Container(
                                            height: 50,
                                            width: double.maxFinite,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(12),
                                              color: primaryColorV1
                                            ),
                                            child: Center(
                                              child: Text(
                                                "Make Order",
                                                style: TextStyle(
                                                  fontSize: 25,
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.white
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                );
                              }
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Container(
                                                      height: 50,
                                                      width: 50,
                                                      decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: primaryColorV2,
                                                      ),
                                                      child: Center(child: Icon(Icons.shopping_cart,
                                                      size: 30,
                                                      color: Colors.white,
                                                      )
                                                      ),
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
                      itemCount: product.url.length,
                      itemBuilder: (context,index){
                    return Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Container(
                          color: Colors.black12,
                          width: 200,
                          height: 200,
                          child: CachedNetworkImage(
                            placeholder: (context,url)=>Center(
                              child: Container(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(),
                              ),
                            ),
                            imageUrl:product.url[index],fit: BoxFit.fill,),
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
                                  Text(product.category,style: TextStyle(
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
                                    product.region,
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

  Padding modalFormTittles(String text) {
    return Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Text(text),
                                        ],
                                      ),
                                    );
  }
}
