import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:planet_saver/FireBase/ads_storage.dart';
import 'package:planet_saver/Pages/Widgets/colors.dart';

import '../../Controllers/user_statemanager.dart';
import '../Widgets/textWidgets.dart';
import 'Widgets/widgets.dart';
class CreateAd extends StatelessWidget {
  CreateAd({Key? key}) : super(key: key);
  TextEditingController titleController=TextEditingController();
  TextEditingController descriptionController=TextEditingController();
  TextEditingController priceController=TextEditingController();
  TextEditingController weightController=TextEditingController();
  final AdsCloudFireStore saveAd=AdsCloudFireStore();
  final user=Get.find<UserStateController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                loginTittleText(),
              ],
            ),
            InputFiedsAd(
              titleController: titleController,
              hintText: 'What are You Selling ?',
              labelText: 'Product Tittle',
            ),
            NumeralInputFiedsAd(
              titleController: priceController,
              hintText: 'Set The price',
              labelText: 'Product price',
            ),
            NumeralInputFiedsAd(
              titleController: weightController,
              hintText: 'Weight(kG)',
              labelText: 'Product Weight',
            ),
            InputFiedsAd(
              titleController: descriptionController,
              hintText: 'What are You Selling ?',
              labelText: 'Product Tittle',
            ),
            Text("Upload Images",style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600
            ),),
            UploadImagesWidget(),
            ///add  type and region form fields
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 45.0),
              child:InkWell(
                  onTap: (){
                    if(user.pickedImages.isNotEmpty){
                      saveAd.saveAd(descriptionController.text, titleController.text,user.pickedImages.value,int.parse(priceController.text),int.parse(weightController.text),user.currentser.value!.uid);
                      user.clearImages();
                      print("ad successfull");
                    }
                    else
                      print("ad not Saved");
                  },
                  child: Container(
                    height: 45,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: primaryColorV2,
                      borderRadius: BorderRadius.circular(15)
                    ),
                    child: Center(
                      child: Text(
                        "Create Ad",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 25
                        ),

                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

