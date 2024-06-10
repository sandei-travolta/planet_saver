import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:planet_saver/Controllers/image_picker.dart';
import 'package:planet_saver/Controllers/user_statemanager.dart';
class InputFiedsAd extends StatelessWidget {
  const InputFiedsAd({
    super.key,
    required this.titleController, required this.hintText, required this.labelText,
  });

  final TextEditingController titleController;
  final String hintText;
  final String labelText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0,vertical: 10),
      child: TextFormField(
        controller: titleController,
        decoration: InputDecoration(
            hintText: hintText,
            labelText: labelText
        ),
      ),
    );
  }
}
class NumeralInputFiedsAd extends StatelessWidget {
  const NumeralInputFiedsAd({
    super.key,
    required this.titleController, required this.hintText, required this.labelText,
  });

  final TextEditingController titleController;
  final String hintText;
  final String labelText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0,vertical: 8),
      child: TextFormField(
        keyboardType: TextInputType.number,
        controller: titleController,
        decoration: InputDecoration(
            hintText: hintText,
            labelText: labelText
        ),
      ),
    );
  }
}
class UploadImagesWidget extends StatelessWidget {
   UploadImagesWidget({
    super.key,
  });

  PickImage pickImage=PickImage();
  final user=Get.find<UserStateController>();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 20),
      child: Container(
          width: double.maxFinite,
          height:300,
          decoration: BoxDecoration(
              color: Colors.black26,
              borderRadius: BorderRadius.circular(12)
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                    onPressed: ()async{
                      List<File> pickedImages=await pickImage.pickMultipleImages(ImageSource.gallery,user.currentser.value)??[];
                      user.setImages(pickedImages);
                    },
                    icon: Icon(Icons.photo_camera,size: 45,
                    )
                ),
                Text("Upload Images",style: TextStyle(
                    fontSize: 18
                ),)
              ],
            ),
          ),
        ),
    );
  }
}

