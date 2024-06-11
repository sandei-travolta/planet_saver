import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../../../Controllers/user_statemanager.dart';
import '../../../Models/Product.dart';
import '../../DescriptionPage/DescriptionPage.dart';
import 'cardWidget.dart';
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
                  return CardWidget(product: product[index]);
                }),
          ),
        )
    );
  }
}

