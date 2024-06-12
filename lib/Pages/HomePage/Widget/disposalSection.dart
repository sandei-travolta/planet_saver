import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:planet_saver/Controllers/user_statemanager.dart';
import 'package:planet_saver/Pages/HomePage/Widget/cardWidget.dart';

import '../../../Models/Product.dart';
class DisposalSection extends StatelessWidget {
  DisposalSection({Key? key}) : super(key: key);
  final disposalsController=Get.find<UserStateController>();
  @override
  Widget build(BuildContext context) {
    return Expanded(
        flex: 10,
        child: Obx(
            ()=>Container(
              child: GridView.builder(
                itemCount: disposalsController.disposalList.value.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.8,
                    crossAxisSpacing: 5,
                    mainAxisSpacing: 5
                ), itemBuilder: (BuildContext context, int index) {
                Product product=disposalsController.disposalList.value[index];
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
