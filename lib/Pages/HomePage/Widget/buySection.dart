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
                ()=>GridView.builder(
                  itemCount: stateController.productsList.value.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.8,
                    crossAxisSpacing: 2,
                    mainAxisSpacing: 5
                  ), itemBuilder: (BuildContext context, int index) {
                    Product product=stateController.productsList.value[index];
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: AdCard(product: product),
                    );
                },
                )
          ),
        )
    );
  }
}

