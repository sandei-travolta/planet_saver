
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:planet_saver/FireBase/ads_storage.dart';
import 'package:planet_saver/Pages/Widgets/colors.dart';

import '../../Controllers/user_statemanager.dart';
import '../Widgets/textWidgets.dart';
import '../constants.dart';
import 'Widgets/widgets.dart';
class CreateAd extends StatefulWidget {
  CreateAd({Key? key}) : super(key: key);

  @override
  State<CreateAd> createState() => _CreateAdState();
}

class _CreateAdState extends State<CreateAd> {
  TextEditingController titleController=TextEditingController();

  TextEditingController descriptionController=TextEditingController();

  TextEditingController priceController=TextEditingController();

  TextEditingController weightController=TextEditingController();

  TextEditingController categoryController=TextEditingController();

  TextEditingController regionController=TextEditingController();

  final AdsCloudFireStore saveAd=AdsCloudFireStore();
 /* SingleValueDropDownController product=SingleValueDropDownController();*/


  bool isLoading=false;

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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
              child: TextFormField(
                controller: categoryController,
                readOnly: true,
                onTap: ()async{
                  String? selectedValue = await showDialog<String>(
                    context: context,
                    builder: (BuildContext context) {
                      return SimpleDialog(
                        title: const Text('Select Category'),
                        children: categories.map((String category) {
                          return SimpleDialogOption(
                            onPressed: () {
                              Navigator.pop(context, category);
                            },
                            child: Text(category),
                          );
                        }).toList(),
                      );
                    },
                  );

                  if (selectedValue != null) {
                    setState(() {
                      categoryController.text = selectedValue;
                    });
                  }
                },
                decoration: InputDecoration(
                  hintText: "Select Category",
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
              child: TextFormField(
                controller: regionController,
                readOnly: true,
                onTap: ()async{
                  String? selectedValue = await showDialog<String>(
                    context: context,
                    builder: (BuildContext context) {
                      return SimpleDialog(
                        title: const Text('Select Region'),
                        children: counties.map((String category) {
                          return SimpleDialogOption(
                            onPressed: () {
                              Navigator.pop(context, category);
                            },
                            child: Text(category),
                          );
                        }).toList(),
                      );
                    },
                  );

                  if (selectedValue != null) {
                    setState(() {
                      regionController.text = selectedValue;
                    });
                  }
                },
                decoration: InputDecoration(
                  hintText: "Select Region",
                ),
              ),
            ),
            Text("Upload Images",style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600
            ),
            ),
            UploadImagesWidget(),
            ///add  type and region form fields
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 45.0),
              child:InkWell(
                  onTap: (){
                    if(user.pickedImages.isNotEmpty){
                      setState(() {
                        isLoading=true;
                      });
                      saveAd.saveAd(
                          descriptionController.text,
                          titleController.text,user.pickedImages.value,
                          int.parse(priceController.text),
                          int.parse(weightController.text),
                          user.currentser.value!.uid,
                          categoryController.text,
                          regionController.text);
                      print(user.currentser.value!.uid);
                      print(user.currentser.value!.name);
                      user.clearImages();
                      descriptionController.clear();
                      titleController.clear();
                      weightController.clear();
                      priceController.clear();
                      setState(() {
                        isLoading=false;
                      });
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
                      child: isLoading==false?Text(
                        "Create Ad",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 25
                        ),
                      ):Container(
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      )
                    ),
                  ),
                ),
              ),
            const SizedBox(height: 50,)
          ],
        ),
      ),
    );
  }
}

