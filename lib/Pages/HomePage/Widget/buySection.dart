import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../../../Controllers/user_statemanager.dart';
import '../../../Models/Product.dart';
import '../../DescriptionPage/DescriptionPage.dart';
class buyection extends StatelessWidget {
  const buyection({
    super.key,
    required this.stateController,
  });

  final UserStateController stateController;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        flex: 10,
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
    );
  }
}
