import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:planet_saver/Controllers/user_statemanager.dart';
class DisposalSection extends StatelessWidget {
  DisposalSection({Key? key}) : super(key: key);
  final disposalsController=Get.find<UserStateController>();
  @override
  Widget build(BuildContext context) {
    return Expanded(
        flex: 10,
        child: Obx(
            ()=>Container(
              child: ListView.builder(
                  itemBuilder: (context,index){
                    return Container();
                  }
                  ),
          ),
        )
    );
  }
}
