import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:planet_saver/FireBase/ads_storage.dart';

import '../../Controllers/user_statemanager.dart';
import '../Widgets/colors.dart';
import '../Widgets/textWidgets.dart';
import '../constants.dart';
import 'Widgets/widgets.dart';
class RequestPickUp extends StatefulWidget {
  RequestPickUp({Key? key}) : super(key: key);

  @override
  State<RequestPickUp> createState() => _RequestPickUpState();
}

class _RequestPickUpState extends State<RequestPickUp> {
  TextEditingController titleController=TextEditingController();

  TextEditingController descriptionController=TextEditingController();

  TextEditingController priceController=TextEditingController();

  TextEditingController weightController=TextEditingController();
  TextEditingController categoryController=TextEditingController();
  TextEditingController regionController=TextEditingController();
  TextEditingController dateController=TextEditingController();
  String dropdownvalue = 'cans';
  bool isLoading=false;
  var price=0;
  final user=Get.find<UserStateController>();
  final AdsCloudFireStore saveAd=AdsCloudFireStore();
  @override
  Widget build(BuildContext context) {
    priceController.text=price.toString();
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
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
                PriceInputFiedsAd(
                  titleController: priceController,
                  hintText: 'Set The price',
                  labelText: 'Product price',
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0,vertical: 8),
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    controller: weightController,
                    decoration: InputDecoration(
                        hintText: 'Weight(kG)',
                        labelText: 'Product Weight(30ksh/kg)',
                    ),
                    onChanged: (value){
                      int weight=int.parse(value);
                      price=weight*30;
                      priceController.text=price.toString();
                    },
                  ),
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
                          regionController.text=selectedValue;
                        });
                      }
                    },
                    decoration: InputDecoration(
                      hintText: "Select Region",
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: TextField(
                    readOnly: true,
                    controller: dateController,
                    decoration: InputDecoration(
                        hintText: "Pick Up Date"
                    ),
                    onTap: ()async{
                      DateTime? pickedDate=await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now(),
                          lastDate: DateTime(2025)
                      );
                      if(pickedDate!=null){
                        String formattedDate=DateFormat("dd-MM-yyyy").format(pickedDate);
                        dateController.text=formattedDate;
                      }
                    },
                  ),
                ),
                const SizedBox(height: 30,),
                Text("Upload Images",style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600
                ),),
                UploadImagesWidget(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 45.0),
                  child:InkWell(
                    onTap: (){
                      if(user.pickedImages.isNotEmpty){
                        setState(() {
                          isLoading=true;
                        });
                        saveAd.saveDisposalAd(descriptionController.text, titleController.text,user.pickedImages.value,int.parse(priceController.text),int.parse(weightController.text),user.currentser.value!.uid,categoryController.text,regionController.text);
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
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("SAved")));
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
        ),
      ),
    );
  }
}
